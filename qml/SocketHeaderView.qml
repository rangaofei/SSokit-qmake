import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

GridLayout{
    property int content_Width: 150
    property bool checkEnabled: false

    columns: 3
    rows: 4
    columnSpacing: 10
    Label{
        Layout.columnSpan: 1
        text: qsTr("Header:")
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
    }
    TextField{
        id:header
        Layout.columnSpan: 2
        Layout.preferredWidth: content_Width
        background: Rectangle {
            color: enabled ? "transparent" : "#00ffffff"
            border.color: enabled ? "#bdbdbd" : "#bdbdbd"
            radius: 3
        }
    }
    Text{
        Layout.columnSpan: 1
        Layout.preferredWidth:50
        Layout.preferredHeight: 25
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        text: qsTr("长度类型")
    }
    EditComboBox{
        id:lengthSizeBox
        Layout.columnSpan: 2
        Layout.preferredWidth: content_Width
        editable: false
        //                enabled: canSendMsg
        model: ListModel {
            id: model
            ListElement { text: qsTr("none") }
            ListElement { text: qsTr("short") }
            ListElement { text: qsTr("int") }
        }

    }
    Text{
        Layout.columnSpan: 1
        Layout.preferredWidth: 50
        Layout.preferredHeight: 25
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        text: qsTr("Endian")
    }
    EditComboBox{
        id:endianBox
        Layout.columnSpan: 2
        Layout.preferredWidth: content_Width
        currentIndex: 0
        model: ListModel {
            ListElement { text: qsTr("Big") }
            ListElement { text: qsTr("Little") }
        }
    }
    RoundCheckBox{
        id:withHeader
        Layout.columnSpan: 3
        enabled: checkEnabled
        Layout.preferredWidth: 50
        Layout.fillHeight:false
        Layout.preferredHeight: 25
        checked: false
        showText: false
        text: qsTr("添加")
    }
    function getHeader(){
        console.log("header text::"+header.text)
        return header.text
    }

    function getLengthSize(){
        return lengthSizeBox.currentIndex*2
    }

    function isBigEndian(){
        return endianBox.currentIndex==0
    }
    function isWithHeader(){
        return withHeader.checked
    }
}

