#include "JsonFormat.h"
#include <QDebug>
JsonFormat::JsonFormat()
{

}

JsonFormat::~JsonFormat()
{
    if(m_jsonDocument!=nullptr){
        delete  m_jsonDocument;
        m_jsonDocument=nullptr;
    }
}

void JsonFormat::checkJonsStr(QString jsonStr)
{   const QByteArray jsonArray=jsonStr.toLatin1();
    m_jsonDocument=new QJsonDocument(QJsonDocument::fromJson(jsonArray,&m_error));
    if(m_error.error != QJsonParseError::NoError)
    {
        qDebug() << "json error!"<<m_error.errorString();
        return;
    }
    QByteArray result=m_jsonDocument->toJson(QJsonDocument::Indented);
    emit formattedJson(QString(result));
}

void JsonFormat::formatJson()
{

}
