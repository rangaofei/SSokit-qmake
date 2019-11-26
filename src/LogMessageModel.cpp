#include "LogMessageModel.h"
#include "toolkit.h"

#include <QDebug>
#include <bitset>



LogMessageList::LogMessageList(QObject *parent)
{
    Q_UNUSED(parent)
}

LogMessageList::~LogMessageList()
{

}

void LogMessageList::setCurrentItem(int index)
{
    this->m_currentData=m_dataList[index];
}

void LogMessageList::addData(LogMessageModel *model)
{
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    m_dataList.append(model);
    endInsertRows();
}

void LogMessageList::clearData()
{
    beginRemoveRows(QModelIndex(), 0, m_dataList.size()-1);
    qDeleteAll(m_dataList);
    endRemoveRows();
}

void LogMessageList::clearRecvData()
{
    int length=m_dataList.size();
    if(length<=0){
        return;
    }
    for(int i=length-1;i>=0;i--){
        if(m_dataList.at(i)->isRev()){
            beginRemoveRows(QModelIndex(),i,i);
            m_dataList.removeAt(i);
            endRemoveRows();
        }
    }
}

void LogMessageList::clearSendData()
{
    int length=m_dataList.size();
    if(length<=0){
        return;
    }
    for(int i=length-1;i>=0;i--){
        if(!m_dataList.at(i)->isRev()){
            beginRemoveRows(QModelIndex(),i,1);
            m_dataList.removeAt(i);
            endRemoveRows();
        }
    }
}

LogMessageModel* LogMessageList::get(int index)
{
    if(index<0||index>=m_dataList.size()){
        return nullptr;
    }
    return m_dataList[index];
}

int LogMessageList::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);
    return m_dataList.size();
}

QVariant LogMessageList::data(const QModelIndex &index, int role) const
{
    if (index.row() < 0 || index.row() >= m_dataList.size())
    {
        return QVariant();
    }
    LogMessageModel* d = m_dataList[index.row()];
    if (role == Datatype::time)
    {
        return d->time();
    }
    else if (role == Datatype::isRev)
    {
        return d->isRev();

    }
    else if (role == Datatype::host)
    {
        return d->host();
    }
    else if (role == Datatype::ascData) {
        QString ascData = TK::bin2ascii(d->buf(), static_cast<uint>(d->length()));
        return ascData;
    }
    else if (role == Datatype::hexData) {
        QString hexData = TK::bin2hex(d->buf(),static_cast<uint>(d->length()));
        return hexData;
    }
    else if (role == Datatype::textData) {
        return QString(d->byteArray());
    }
    else if (role == Datatype::length) {
        return d->length();
    }
    else if (role == Datatype::binData) {
        QString binData="0x"+d->byteArray().toHex(' ').toUpper();
        QStringList list=binData.split(' ');
        return list.join(" 0x");
    }
    return QVariant();

}

QHash<int, QByteArray> LogMessageList::roleNames() const
{
    QHash<int, QByteArray>  d;
    d[Datatype::time] = "time";
    d[Datatype::isRev] = "isRev";
    d[Datatype::host] = "host";
    d[Datatype::ascData]="ascData";
    d[Datatype::hexData] = "hexData";
    d[Datatype::textData] ="textData";
    d[Datatype::length] = "length";
    d[Datatype::binData] = "binData";
    return d;
}

