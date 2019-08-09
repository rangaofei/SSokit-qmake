#include "bluetoothmodel.h"

BlueToothModel::BlueToothModel(QObject *parent) : QObject(parent) {
    discoveryAgent = new QBluetoothDeviceDiscoveryAgent();
    discoveryAgent->setLowEnergyDiscoveryTimeout(5000);
    connect(discoveryAgent, &QBluetoothDeviceDiscoveryAgent::deviceDiscovered,
            this, &BlueToothModel::addDevice);
    connect(discoveryAgent,
            QOverload<QBluetoothDeviceDiscoveryAgent::Error>::of(&QBluetoothDeviceDiscoveryAgent::error),
            this, &BlueToothModel::deviceScanError);
    connect(discoveryAgent, &QBluetoothDeviceDiscoveryAgent::finished, this, &BlueToothModel::deviceScanFinished);

    setUpdate("Search");
    qDebug("init bluetooth");
}

BlueToothModel::~BlueToothModel(){
    delete discoveryAgent;
        delete controller;
        qDeleteAll(devices);
        qDeleteAll(m_services);
        qDeleteAll(m_characteristics);
        devices.clear();
        m_services.clear();
        m_characteristics.clear();
}
void BlueToothModel::setUpdate(const QString &message) {

}

void BlueToothModel::startDeviceDiscovery()
{
    qDeleteAll(devices);
    devices.clear();
    emit devicesUpdated();
    qDebug("start scan");
    setUpdate("Scanning for devices ...");
    discoveryAgent->start(QBluetoothDeviceDiscoveryAgent::LowEnergyMethod);

    if (discoveryAgent->isActive()) {
        m_deviceScanState = true;
        Q_EMIT stateChanged();
    }
}

void BlueToothModel::addDevice(const QBluetoothDeviceInfo &info) {
    qDebug("name %s",info.name().toStdString().data());
    qDebug("add %s",info.address().toString().toStdString().data());
    qDebug("uuid %s",info.deviceUuid().toString().toStdString().data());
}

void BlueToothModel::deviceScanFinished() {
    qDebug("%s","finished");
}

void BlueToothModel::deviceScanError(QBluetoothDeviceDiscoveryAgent::Error error) {
    qDebug("Error %d",error);
}
