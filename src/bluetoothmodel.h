#ifndef BLUETOOTHMODEL_H
#define BLUETOOTHMODEL_H

#include <QObject>
#include <qbluetoothlocaldevice.h>
#include <QVariant>
#include <QList>
#include <QBluetoothServiceDiscoveryAgent>
#include <QBluetoothDeviceDiscoveryAgent>
#include <QLowEnergyController>
#include <QBluetoothServiceInfo>

QT_FORWARD_DECLARE_CLASS (QBluetoothDeviceInfo)
QT_FORWARD_DECLARE_CLASS (QBluetoothServiceInfo)

class BlueToothModel : public QObject
{
    Q_OBJECT
public:
    explicit BlueToothModel(QObject *parent = nullptr);
    ~BlueToothModel();

signals:
    void devicesUpdated();
    void servicesUpdated();
    void characteristicsUpdated();
    void updateChanged();
    void stateChanged();
    void disconnected();
    void randomAddressChanged();

public slots:

    void startDeviceDiscovery();

    void addDevice(const QBluetoothDeviceInfo&);
    void deviceScanFinished();
    void deviceScanError(QBluetoothDeviceDiscoveryAgent::Error);

private:
    void setUpdate(const QString &message);
    QBluetoothDeviceDiscoveryAgent *discoveryAgent;
    QList<QObject *> devices;
    QList<QObject *> m_services;
    QList<QObject *> m_characteristics;
    QString m_previousAddress;
    QString m_message;
    bool connected = false;
    QLowEnergyController *controller = nullptr;
    bool m_deviceScanState = false;
    bool randomAddress = false;
};

#endif // BLUETOOTHMODEL_H