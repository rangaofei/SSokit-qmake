#include "QmlLogModel.h"


QmlLogModel::QmlLogModel(QObject *parent) : QObject(parent),m_revCount(0),m_senCount(0)
{
    m_dataList=new LogMessageList;
}

QmlLogModel::~QmlLogModel()
{

}

/**
 * 接收的信息数量
 * @brief QmlLogModel::revCount
 * @return
 */
qint64 QmlLogModel::revCount()
{
    return m_revCount;
}

/**
 * 设置接收信息数量
 * @brief QmlLogModel::setRevCount
 * @param count
 */
void QmlLogModel::setRevCount(qint64 count)
{
    this->m_revCount=count;
}

/**
 * 发送信息的数量
 * @brief QmlLogModel::senCount
 * @return
 */
qint64 QmlLogModel::senCount()
{
    return m_senCount;
}

/**
 * 设置发送信息的数量
 * @brief QmlLogModel::setSenCount
 * @param count
 */
void QmlLogModel::setSenCount(qint64 count)
{
    this->m_senCount=count;
}

/**
 * @brief QmlLogModel::dataList
 * @return
 * 当前所有的数据列表
 */
LogMessageList *QmlLogModel::dataList()
{
    return m_dataList;
}

/**
 * @brief QmlLogModel::setDataList
 * @param dataList
 * 设置数据列表
 */
void QmlLogModel::setDataList(LogMessageList *dataList)
{
    this->m_dataList=dataList;
}

/**
 * @brief QmlLogModel::dumpLogMsg
 * @param rev
 * @param host
 * @param buf
 * @param length
 * 输出日志
 */
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

/**
 * @brief QmlLogModel::dumpLogMsg
 * @param data
 * 输出日志
 */
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

/**
 * @brief QmlLogModel::clearRevCount
 * @param clearData
 * 清除已接收的数量
 */
void QmlLogModel::clearRevCount(bool clearData)
{
    this->m_revCount=0;
    emit revCountChanged();
    if(clearData){
        this->m_dataList->clearRecvData();
        emit dataListChanged();
    }
}

/**
 * @brief QmlLogModel::clearSenCount
 * @param clearData
 * 清除已发送的数量
 */
void QmlLogModel::clearSenCount(bool clearData)
{
    this->m_senCount=0;
    emit senCountChanged();
    if(clearData){
        this->m_dataList->clearSendData();
        emit dataListChanged();
    }
}

/**
 * @brief QmlLogModel::clearAll
 * 清除所有的数据
 */
void QmlLogModel::clearAll()
{
    SoundManager::playClear();
    clearRevCount(false);
    clearSenCount(false);
    this->m_dataList->clearData();
    emit dataListChanged();
}

/**
 * @brief QmlLogModel::clearData
 * @param type
 * 暂时不用
 */
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
