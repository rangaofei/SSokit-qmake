import QtQuick 2.12

import QtBluetooth 5.12

import src.bluetoothmodel 1.0

Rectangle {
    BlueToothModel{
        id:model
    }
    width: 300
    height:300
    color: "red"
    MouseArea{
        width: parent.width
        height: parent.height
        anchors.centerIn: parent
        onClicked: model.startDeviceDiscovery()
    }
    BluetoothDiscoveryModel {
            id: btModel
            running: true
            discoveryMode: BluetoothDiscoveryModel.DeviceDiscovery
            onDiscoveryModeChanged: console.log("Discovery mode: " + discoveryMode)
            onServiceDiscovered: console.log("Found new service " + service.deviceAddress + " " + service.deviceName + " " + service.serviceName);
            onDeviceDiscovered: console.log("New device: " + device)
            onErrorChanged: {
                    switch (btModel.error) {
                    case BluetoothDiscoveryModel.PoweredOffError:
                        console.log("Error: Bluetooth device not turned on"); break;
                    case BluetoothDiscoveryModel.InputOutputError:
                        console.log("Error: Bluetooth I/O Error"); break;
                    case BluetoothDiscoveryModel.InvalidBluetoothAdapterError:
                        console.log("Error: Invalid Bluetooth Adapter Error"); break;
                    case BluetoothDiscoveryModel.NoError:
                        break;
                    default:
                        console.log("Error: Unknown Error"); break;
                    }
            }
       }
}
