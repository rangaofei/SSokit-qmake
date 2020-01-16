#ifndef DEVICEINFO_H
#define DEVICEINFO_H

#include <QObject>
#include <QNetworkInterface>
#include <QDebug>

class DeviceInfo : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString netName READ netName WRITE setNetName NOTIFY netNameChanged)
    Q_PROPERTY(int mtu READ mtu WRITE setMtu NOTIFY mtuChanged)
public:
    explicit DeviceInfo(QObject *parent = nullptr);

    ~DeviceInfo();

    QString netName();
    void setNetName(const QString &name);

    int mtu();
    void setMtu(const int &mtu);

signals:
    void netNameChanged();
    void mtuChanged();

public slots:

private:
    QString m_netName;
    int m_MTU;
};

#endif // DEVICEINFO_H
