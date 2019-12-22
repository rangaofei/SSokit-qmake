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


void JsonFormat::checkJonsStr(const QString jsonStr)
{
    const QByteArray jsonArray=jsonStr.toLatin1();
    m_jsonDocument=new QJsonDocument(QJsonDocument::fromJson(jsonArray,&m_error));
    if(m_error.error != QJsonParseError::NoError)
    {
        qDebug() << "json error!"<<m_error.errorString();
        qDebug()<<m_error.offset;
        return;
    }
    QByteArray result=m_jsonDocument->toJson(QJsonDocument::Indented);
    emit formattedJson(QString(result));
    delete m_jsonDocument;
}


void JsonFormat::formatJson(const QString jsonStr)
{
    const QByteArray jsonArray=jsonStr.toLatin1();
    m_jsonDocument=new QJsonDocument(QJsonDocument::fromJson(jsonArray,&m_error));
    if(m_error.error!=QJsonParseError::NoError)
    {
        qDebug() << "json error!"<<m_error.errorString();
        qDebug()<<m_error.offset;
        return;
    }
    if(m_jsonDocument->isNull()||m_jsonDocument->isEmpty()){
        return;
    }
    if(m_jsonDocument->isObject())
    {
        QJsonObject jsonObject=m_jsonDocument->object();
        jsonObject.keys();
    }else if(m_jsonDocument->isArray())
    {
        QJsonArray jsonArray=m_jsonDocument->array();
        foreach (QJsonValue childValue, jsonArray) {
            if(childValue.isObject()){
                QJsonObject aa=childValue.toObject();
            }
        }
    }

}

void JsonFormat::convertJsonToTree(const QString jsonStr)
{
    if(jsonStr==nullptr||jsonStr.isNull()||jsonStr.isEmpty()){
        return;
    }
    const QByteArray jsonArray=jsonStr.toLatin1();
    QJsonDocument *jsonDoc=new QJsonDocument(QJsonDocument::fromJson(jsonArray));
    if(m_error.error!=QJsonParseError::NoError)
    {
        qDebug() << "json error!"<<m_error.errorString();
        qDebug()<<m_error.offset;
        return;
    }
    if(jsonDoc==nullptr||jsonDoc->isEmpty()||jsonDoc->isNull()){
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

    //    switch (role) {
    //    case JsonType::KEY:
    //        return "key";
    //    }
    qDebug()<<"index valid";
    TreeItem *item = static_cast<TreeItem*>(index.internalPointer());

    return item->data(index.column());
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
    if(doc->isObject()){
        QJsonObject jsonObject=doc->object();
        QStringList keyList=jsonObject.keys();
        int count=keyList.size();
        for(int i=0;i<count;i++){
            QString key=keyList.at(i);
            QJsonValue jsonValue = jsonObject.value(key);
            if(jsonValue==QJsonValue::Undefined){
                continue;
            }
            TreeItem * childItem=new TreeItem(rootItem);
            if(jsonValue.isBool()){
                childItem->setData(key+":"+(jsonValue.toBool()?"true":"false"));
            }else if(jsonValue.isString()){

                childItem->setData(key+":"+jsonValue.toString());
                qDebug()<<jsonValue.toString();
            }
            rootItem->appendChild(childItem);
        }
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
    if (parent.column() > 0)
        return 0;

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
