#ifndef UTIL_H
#define UTIL_H

#include <QNetworkInterface>
#include <QString>
#include <QSysInfo>


class Util{
public:

    //获取主机的mac地址
    static QString getHostMacAddress()
    {
        QList<QNetworkInterface> nets = QNetworkInterface::allInterfaces();// 获取所有网络接口列表
        int nCnt = nets.count();
        QString strMacAddr = "";
        for(int i = 0; i < nCnt; i ++)
        {
            // 如果此网络接口被激活并且正在运行并且不是回环地址，则就是我们需要找的Mac地址
            if(nets[i].flags().testFlag(QNetworkInterface::IsUp) &&     nets[i].flags().testFlag(QNetworkInterface::IsRunning) && !nets[i].flags().testFlag(QNetworkInterface::IsLoopBack))
            {
                strMacAddr = nets[i].hardwareAddress();
                break;
            }
        }
        return strMacAddr;

    }

    //获取系统类型，osx，win，linux
    static QString getSystemType()
    {
        return QSysInfo::productType();
    }
    //获取系统版本
    static QString getSystemVersion()
    {
        return QSysInfo::productVersion();
    }
    //获取用户名称
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
