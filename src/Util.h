#ifndef UTIL_H
#define UTIL_H

#include <QNetworkInterface>
#include <QString>
#include <QSysInfo>


class Util{
public:
    static QString getHostMacAddress()
    {
        QList<QNetworkInterface> nets = QNetworkInterface::allInterfaces();// 获取所有网络接口列表
        int nCnt = nets.count();
        QString strMacAddr = "";
        for(int i = 0; i < nCnt; i ++)
        {
            // 如果此网络接口被激活并且正在运行并且不是回环地址，则就是我们需要找的Mac地址
            if(nets[i].flags().testFlag(QNetworkInterface::IsUp) && nets[i].flags().testFlag(QNetworkInterface::IsRunning) && !nets[i].flags().testFlag(QNetworkInterface::IsLoopBack))
            {
                strMacAddr = nets[i].hardwareAddress();
                break;
            }
        }
        return strMacAddr;

    }

    static QString getSystemType()
    {
        return QSysInfo::productType();
    }

    static QString getSystemVersion()
    {
        return QSysInfo::productVersion();
    }

    static QString getProductName()
    {
        return QSysInfo::prettyProductName();
    }

    static QString getUUID()
    {
        return getHostMacAddress()+"-"+QSysInfo::machineUniqueId();
    }

    static QString getHostName(){
        return QSysInfo::machineHostName();
    }

};

#endif // UTIL_H
