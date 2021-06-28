#include "JsonFormat.h"
#include <QDebug>

JsonFormat::JsonFormat(QObject *parent)
{
    Q_UNUSED(parent)
}

JsonFormat::~JsonFormat()
{
    if(m_jsonDocument!=nullptr){
        delete  m_jsonDocument;
        m_jsonDocument=nullptr;
    }
}

JsonModel *JsonFormat::jsonModel(){
    return m_jsonModel;
}

void JsonFormat::setJsonModel(JsonModel *jsonModel){
    this->m_jsonModel=jsonModel;
}

/**
 * @brief JsonFormat::checkJonsStr
 * @param data
 * 检查是否可以格式化json
 */
void JsonFormat::checkJonsStr(const QVariant data)
{
    QString jsonStr=data.toString();
    qDebug()<<jsonStr;
    const QByteArray jsonArray=jsonStr.toUtf8();
    m_jsonDocument=new QJsonDocument(QJsonDocument::fromJson(jsonArray,&m_error));
    if(m_error.error != QJsonParseError::NoError)
    {
        emit formattedError(m_error.errorString()+":"+QString::number( m_error.offset));
        return;
    }
    QByteArray result=m_jsonDocument->toJson(QJsonDocument::Indented);
    emit formattedJson(QString(result));
    emit formattedError("");
    delete m_jsonDocument;
    m_jsonDocument=nullptr;
}


void JsonFormat::convertJsonToTreeModel(const QVariant data)
{
    QString jsonStr=data.toString();
    qDebug()<<jsonStr;
    if(jsonStr==nullptr||jsonStr.isNull()||jsonStr.isEmpty()){
        return;
    }
    const QByteArray jsonArray=jsonStr.toUtf8();
    QJsonDocument *jsonDoc=new QJsonDocument(QJsonDocument::fromJson(jsonArray));
    if(m_error.error!=QJsonParseError::NoError)
    {
        qDebug() << "json error!"<<m_error.errorString();
        qDebug()<<m_error.offset;
        return;
    }
    if(jsonDoc==nullptr||jsonDoc->isEmpty()||jsonDoc->isNull()){
        qDebug()<<"jsondoc is empty";
        return;
    }
    m_jsonModel=new JsonModel();
    m_jsonModel->convertJsonToTree(jsonDoc);
    emit jsonModelChanged();
}

JsonModel::JsonModel(QObject *parent)
{
    Q_UNUSED(parent)
}

JsonModel::~JsonModel()
{
    delete rootItem;
}

int JsonModel::columnCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent)
    return 1;
}

QVariant JsonModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
    {
        qDebug()<<"index inValid";
        return QVariant();
    }
    TreeItem *item = static_cast<TreeItem*>(index.internalPointer());
    JsonCustomProperty* prop=item->property();
    switch (role) {
    case JsonType::KEY:
        return item->itemData();
    case JsonType::VALUE:
        return "value";
    }
    return QVariant();


}

Qt::ItemFlags JsonModel::flags(const QModelIndex &index) const
{
    if (!index.isValid())
        return Qt::NoItemFlags;

    return QAbstractItemModel::flags(index);
}


void JsonModel::convertJsonToTree(QJsonDocument *doc)
{
    rootItem=new TreeItem();
    rootItem->setData("JSON");
    rootItem->setProperty("JSON","",0);
    if(doc->isObject()){
        QJsonObject jo=doc->object();
        parseJsonObject(rootItem,&jo);
    }else if(doc->isArray()){
        QJsonArray ja=doc->array();
        parseJsonArray(rootItem,&ja);
    }

}

void JsonModel::parseJsonObject(TreeItem *parentItem, QJsonObject *jsonValue)
{
    QStringList keyList=jsonValue->keys();
    int count=keyList.size();
    for(int i=0;i<count;i++){
        QString key=keyList.at(i);
        QJsonValue jv = jsonValue->value(key);

        TreeItem * childItem=new TreeItem(rootItem);
        if(jv==QJsonValue::Undefined)
        {
            childItem->setData(key+" : "+"null");
            childItem->setProperty(key,"",0);
        }
        else if(jv.isBool())
        {
            childItem->setData(key+" : "+(jv.toBool()?"true":"false"));
            childItem->setProperty(key,(jv.toBool()?"true":"false"),1);
        }
        else if(jv.isString())
        {
            childItem->setData(key+" : "+jv.toString());
            childItem->setProperty(key,jv.toString(),3);
        }
        else if(jv.isDouble())
        {
            childItem->setData(key+" : "+QString::number(jv.toDouble()));
            childItem->setProperty(key,QString::number(jv.toDouble()),4);
        }
        else if (jv.isObject())
        {
            childItem->setData(key);
            childItem->setProperty(key,"",5);
            QJsonObject jo=jv.toObject();
            parseJsonObject(childItem,&jo);
        }else if (jv.isArray())
        {
            childItem->setData(key);
            QJsonArray ja=jv.toArray();
            childItem->setProperty(key,"",6);
            parseJsonArray(childItem,&ja);
        }else {
            childItem->setData(key+":"+jv.toString("null"));
            childItem->setProperty(key,"",7);
        }
        parentItem->appendChild(childItem);
    }
}

void JsonModel::parseJsonArray(TreeItem *parentItem, QJsonArray *jsonValue)
{
    int count=jsonValue->size();
    for(int i=0;i<count;i++){
        QJsonValue jv=jsonValue->at(i);
        if(jv==QJsonValue::Undefined){
            continue;
        }
        TreeItem * childItem=new TreeItem(rootItem);
        if(jv.isBool())
        {
            childItem->setData(QString::number(i)+" : "+(jv.toBool()?"true":"false"));
            childItem->setProperty(QString::number(i),jv.toBool()?"true":"false",1);
        }
        else if(jv.isString()){
            childItem->setData(QString::number(i)+" : "+jv.toString());
            childItem->setProperty(QString::number(i),jv.toString(),2);

        }
        else if (jv.isDouble()) {
            childItem->setData(QString::number(i)+" : "+QString::number(jv.toDouble()));
            childItem->setProperty(QString::number(i),QString::number(jv.toDouble()),3);
        }
        else if(jv.isObject())
        {
            childItem->setData(QString::number(i)+" : ");
            childItem->setProperty(QString::number(i),"",4);
            QJsonObject jo=jv.toObject();
            parseJsonObject(childItem,&jo);
        }
        else if(jv.isArray())
        {
            childItem->setProperty(QString::number(i)+" : ","",5);
            QJsonArray ja=jv.toArray();
            childItem->setData(QString::number(i)+" : ");
            childItem->setProperty(QString::number(i),"",6);
            parseJsonArray(childItem,&ja);
        }
        parentItem->appendChild(childItem);
    }


}

QModelIndex JsonModel::index(int row, int column, const QModelIndex &parent) const
{
    if (!hasIndex(row, column, parent))
        return QModelIndex();

    TreeItem *parentItem;

    if (!parent.isValid())
        parentItem = rootItem;
    else
        parentItem = static_cast<TreeItem*>(parent.internalPointer());

    TreeItem *childItem = parentItem->child(row);
    if (childItem)
        return createIndex(row, column, childItem);
    return QModelIndex();
}

QModelIndex JsonModel::parent(const QModelIndex &index) const
{
    if (!index.isValid())
        return QModelIndex();

    TreeItem *childItem = static_cast<TreeItem*>(index.internalPointer());
    TreeItem *parentItem = childItem->parentItem();

    if (parentItem == rootItem)
        return QModelIndex();

    return createIndex(parentItem->row(), 0, parentItem);
}

int JsonModel::rowCount(const QModelIndex &parent) const
{
    TreeItem *parentItem;

    if (!parent.isValid())
        parentItem = rootItem;
    else
        parentItem = static_cast<TreeItem*>(parent.internalPointer());

    return parentItem->childCount();
}



QHash<int, QByteArray> JsonModel::roleNames() const
{
    QHash<int, QByteArray>  d;
    d[JsonType::KEY] = "key";
    d[JsonType::VALUE] = "value";
    return d;
}
