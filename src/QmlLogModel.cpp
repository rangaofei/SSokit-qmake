#include "QmlLogModel.h"

QmlLogModel::QmlLogModel(QObject *parent) : QObject(parent),m_revCount(0),m_senCount(0)
{
    m_dataList=new LogMessageList;
}

QmlLogModel::~QmlLogModel()
{

}

qint64 QmlLogModel::revCount()
{
    return m_revCount;
}

void QmlLogModel::setRevCount(qint64 count)
{
    this->m_revCount=count;
}

qint64 QmlLogModel::senCount()
{
    return m_senCount;
}

void QmlLogModel::setSenCount(qint64 count)
{
    this->m_senCount=count;
}

LogMessageList *QmlLogModel::dataList()
{
    return m_dataList;
}

void QmlLogModel::setDataList(LogMessageList *dataList)
{
    this->m_dataList=dataList;
}

void QmlLogModel::dumpLogMsg(bool rev, QString &host, const QByteArray& buf, qint64 length)
{
    QString hexData = TK::bin2hex(buf, static_cast<uint>(length));
    LogMessageModel* data=new LogMessageModel;
    data->setIsRev(rev);
    data->setHost(host);
    data->setBuf(buf);
    data->setLength(length);
    dumpLogMsg(data);
}

void QmlLogModel::dumpLogMsg(LogMessageModel* data) {
    m_dataList->addData(data);
    if(data->isRev()){
        ++m_revCount;
        emit revCountChanged();
    }else {
        ++m_senCount;
        emit senCountChanged();
    }
    emit setCurrentIndex(m_dataList->rowCount()-1);
}


void QmlLogModel::clearRevCount()
{
    this->m_revCount=0;
    emit revCountChanged();
}

void QmlLogModel::clearSenCount()
{
    this->m_senCount=0;
    emit senCountChanged();
}

void QmlLogModel::clearAll()
{
    clearRevCount();
    clearSenCount();
    this->m_dataList->clearData();
}
