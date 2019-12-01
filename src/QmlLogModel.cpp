#include "QmlLogModel.h"

QmlLogModel::QmlLogModel(QObject *parent) : QObject(parent),m_revCount(0),m_senCount(0)
{
    m_dataList=new LogMessageList;
}

QmlLogModel::~QmlLogModel()
{

}

/***
 * 接收的信息数量
 * @brief QmlLogModel::revCount
 * @return
 */
qint64 QmlLogModel::revCount()
{
    return m_revCount;
}

/***
 * 设置接收信息数量
 * @brief QmlLogModel::setRevCount
 * @param count
 */
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

void QmlLogModel::dumpLogMsg(bool rev, QString &host,const char* buf, qint64 length)
{
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


void QmlLogModel::clearRevCount(bool clearData)
{
    this->m_revCount=0;
    emit revCountChanged();
    if(clearData){
       this->m_dataList->clearRecvData();
        emit dataListChanged();
    }
}

void QmlLogModel::clearSenCount(bool clearData)
{
    this->m_senCount=0;
    emit senCountChanged();
    if(clearData){
        this->m_dataList->clearSendData();
        emit dataListChanged();
    }
}

void QmlLogModel::clearAll()
{
    clearRevCount(false);
    clearSenCount(false);
    this->m_dataList->clearData();
    emit dataListChanged();
}

void QmlLogModel::clearData(QmlLogModel::ClearType type)
{
    switch (type) {
    case ALL:
        this->m_dataList->clearData();
        break;
    case RECEIVE:
        this->m_dataList->clearRecvData();
        break;
    case SEND:
        this->m_dataList->clearSendData();
        break;
    }
}
