import QtQuick 2.0

import QtQuick.Layouts 1.12

import "../widget" as Widget

RowLayout {
    property alias checked: switchButton.checked
    property alias text: title.text

    signal switchCheckedChanged(var checked)
    Text {
        Layout.leftMargin: 30
        Layout.alignment: Qt.AlignLeft|Qt.AlignVCenter
        Layout.fillWidth: true
        id: title
        font.pixelSize: 13

    }

    Widget.SwitchButton{
        Layout.alignment: Qt.AlignRight|Qt.AlignVCenter
        Layout.fillWidth: false
        id:switchButton
        onCheckedChanged: switchCheckedChanged(checked)
    }

}
