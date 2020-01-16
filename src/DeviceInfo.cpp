#include "DeviceInfo.h"

DeviceInfo::DeviceInfo(QObject *parent) : QObject(parent)
{
    QList<QNetworkInterface> list=QNetworkInterface::allInterfaces();
    if(list.length()<=0){
        return;
    }
    qDebug()<<list.length();
    foreach (QNetworkInterface ni, list) {
        if(!ni.flags().testFlag(QNetworkInterface::IsUp)||!ni.flags().testFlag(QNetworkInterface::IsRunning)){
            continue;
        }
        QList<QNetworkAddressEntry> addresses=ni.addressEntries();
        if(addresses.isEmpty()){
            continue;
        }
        bool hasIPV4=false;
        foreach(QNetworkAddressEntry entry, addresses){
            if(entry.ip().protocol()==QAbstractSocket::IPv4Protocol){
                qDebug()<<entry.ip();
                qDebug()<<entry.broadcast()<<"||"<<ni.flags().testFlag(ni.CanBroadcast);
                hasIPV4=true;
            }
        }
        if(!hasIPV4){
            continue;
        }
        qDebug()<<"+++++++++++++++++++++++++++++";
        qDebug()<<ni.humanReadableName();
        qDebug()<<ni.flags();
        qDebug()<<ni.maximumTransmissionUnit();

        qDebug()<<"+++++++++++++++++++++++++++++";
    }
    const QNetworkInterface interface=list.at(0);
    this->setMtu(interface.maximumTransmissionUnit());
    this->setNetName(interface.humanReadableName());
}

DeviceInfo::~DeviceInfo()
{

}

QString DeviceInfo::netName()
{
    return this->m_netName;
}

void DeviceInfo::setNetName(const QString &name)
{
    this->m_netName=name;
}

int DeviceInfo::mtu()
{
    return this->m_MTU;
}

void DeviceInfo::setMtu(const int &mtu)
{
    this->m_MTU=mtu;
}
