import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import src.strings 1.0

ColumnLayout{
    property int content_Width: 150
    property int content_height: 30
    property bool checkEnabled: false

    id:container
    RowLayout{
        Layout.fillWidth: true
        Layout.preferredHeight: 30
        Label{
            text: Strings.header
            Layout.preferredHeight: content_height
            Layout.preferredWidth: 50
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }
        TextField{
            id:header
            Layout.preferredWidth: content_Width
            Layout.preferredHeight: content_height
            background: Rectangle {
                color: enabled ? "transparent" : "#00ffffff"
                border.color: enabled ? "#bdbdbd" : "#bdbdbd"
                radius: 3
            }
        }
    }

    RowLayout{
        Layout.fillWidth: true
        Layout.preferredHeight: 30
        Label{
            text: Strings.tailer
            Layout.preferredHeight: content_height
            Layout.preferredWidth: 50
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }
        TextField{
            id:tailer
            Layout.preferredWidth: content_Width
            Layout.preferredHeight: content_height
            background: Rectangle {
                color: enabled ? "transparent" : "#00ffffff"
                border.color: enabled ? "#bdbdbd" : "#bdbdbd"
                radius: 3
            }
        }
    }
    RowLayout{
        ColumnLayout{
            RowLayout{
                Layout.fillWidth: true
                Layout.preferredHeight: 30
                Text{
                    Layout.preferredWidth:50
                    Layout.preferredHeight: content_height
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    text: Strings.headerLengthType
                }
                EditComboBox{
                    id:lengthSizeBox
                    Layout.preferredHeight: content_height
                    Layout.preferredWidth: content_Width*2/3
                    showLeftIndicator: false
                    editable: false
                    currentIndex:0
                    model: ListModel {
                        Component.onCompleted: {
                            append({ text: Strings.headerLengthValue[0] })
                            append({ text: Strings.headerLengthValue[1] })
                            append({ text: Strings.headerLengthValue[2] })
                        }
                    }

                }
            }
            RowLayout{
                Layout.fillWidth: true
                Layout.preferredHeight: 30
                Text{
                    Layout.preferredWidth: 50
                    Layout.preferredHeight: content_height
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    text: Strings.headerEndian
                }
                EditComboBox{
                    id:endianBox
                    Layout.preferredHeight: content_height
                    Layout.preferredWidth: content_Width*2/3
                    showLeftIndicator: false
                    currentIndex: 0
                    model: ListModel {
                        Component.onCompleted: {
                            append({ text: Strings.headerEndianValue[0] })
                            append({ text: Strings.headerEndianValue[1] })
                        }
                    }
                }
            }
        }
        ColumnLayout{
            Layout.fillWidth: true
            Layout.leftMargin: 10
            Layout.preferredHeight: 30
            Text{
                Layout.preferredWidth: 30
                Layout.preferredHeight: 20
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                text: Strings.headerEnable
                visible: true
            }

            RoundCheckBox{
                id:withHeader
                enabled: checkEnabled
                Layout.preferredWidth: 30
                Layout.preferredHeight: 30
                checked: false
                showText: false
                visible: true
            }
        }
    }

    states: [
        State {
            name: "in"
            PropertyChanges {
                target: container
                x:0
                opacity:1.0
            }
        },
        State {
            name: "out"
            PropertyChanges {
                target: container
                x:-210
                opacity:0.5
            }
        }
    ]


    transitions: Transition {
        PropertyAnimation {
            properties: "x,opacity"; duration: 200; easing.type: Easing.OutQuad }
    }


    function getHeader(){
        return header.text
    }

    function getTailer(){
        return tailer.text
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

    function startShow(){
        container.state="in"
    }

    function stopShow(){
        container.state="out"
    }
}

