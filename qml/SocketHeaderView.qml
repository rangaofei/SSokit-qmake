import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import src.strings 1.0

ColumnLayout{
    property int content_Width: 150
    property int content_height: 30
    property bool checkEnabled: false
    property bool isVisible: true

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
                    model: ListModel {
                        Component.onCompleted: {
                            append({ text: Strings.headerNone })
                            append({ text: Strings.headerShort })
                            append({ text: Strings.headerInt })
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
            Layout.preferredHeight: 30
            //            Text{
            //                Layout.preferredWidth: 50
            //                Layout.preferredHeight: 20
            //                verticalAlignment: Text.AlignVCenter
            //                horizontalAlignment: Text.AlignHCenter
            //                text: qsTr("Enable")
            //                visible: true
            //            }

            RoundCheckBox{
                id:withHeader
                enabled: checkEnabled
                Layout.preferredWidth: content_Width/3
                Layout.preferredHeight: 50
                checked: false
                showText: false
                visible: true
            }
        }
    }
    //组合动画
    ParallelAnimation{
        id: menuStartAnim
        //属性动画
        NumberAnimation{
            target: container
            properties: "x"
            from:-210
            to: 0
            //动画持续时间，毫秒
            duration: 300
            //动画渐变曲线
            easing.type: Easing.OutQuad
        }
        NumberAnimation{
            target: container
            properties: "opacity"
            from: 0.2
            to: 1.0
            duration: 300;
            easing.type: Easing.OutQuad
        }
    }
    ParallelAnimation{
        id: menuStopAnim
        NumberAnimation{
            target: container
            properties: "x"
            from: 0
            to: -210
            duration: 300
            easing.type: Easing.Linear
        }
        NumberAnimation{
            target: container
            properties: "opacity"
            from: 1.0
            to: 0.2
            duration: 500;
            easing.type: Easing.Linear
        }
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

    function startShow(){
        menuStartAnim.start()
    }

    function stopShow(){
        menuStopAnim.start()
    }
}

