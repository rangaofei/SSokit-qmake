import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.Layouts 1.12
import src.strings 1.0
import QtQuick.Controls.Styles 1.4
import src.soundmanager 1.0

import "../widgets" as Widgets


GroupBox{
    property var detailLogText: ""
    property var time: ""
    property var isRev: ""
    property var host: ""
    property var length
    property var dataWidth

    signal dataTypeChanged(var index)
    topPadding: 5
    bottomPadding: 5
    id:container

    background: Rectangle{
        radius: 5
        color:"#37474f"
        border.color: "#bdbdbd"
        border.width: 1
    }
    ColumnLayout{
        width: parent.width
        height: parent.height
        RowLayout{
            Layout.fillWidth: true
            Layout.leftMargin: 10
            Layout.rightMargin: 10
            Layout.alignment: Qt.AlignTop
            Text {
                height: 12
                Layout.fillWidth: true
                text: "显示形式"
                font.pixelSize: 10
                color: "#AAAAAA"
                wrapMode: Text.WordWrap
            }
            Widgets.SmallEidtComboBox{
                id: dataType
                Layout.preferredHeight: 20
                Layout.preferredWidth: 150
                showLeftIndicator: false
                editable: false
                font.pixelSize: 10
                currentIndex:0
                normalColor:"white"
                indicatorColor: "white"
                model: ListModel {
                    Component.onCompleted: {
                        for(var a in Strings.logItemDataType){
                            append({ text: Strings.logItemDataType[a] })
                        }
                    }
                }
                onCurrentIndexChanged: {
                    dataTypeChanged(currentIndex)
                }
            }
        }

        ScrollView{
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true
            Layout.columnSpan: 8
            background: Rectangle{
                radius: 0
                color:"#37474f"
                border.color: "#bdbdbd"
                border.width: 1
            }
            TextArea {
                id: detail
                text: detailLogText
                selectByMouse: true
                selectedTextColor: "#37474f"
                selectionColor: "white"
                color: "white"
                wrapMode: Text.Wrap
                readOnly: true
            }
        }
        RowLayout{
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignBottom
            RowLayout{
                Layout.alignment: Qt.AlignLeft
                Text {
                    text: (isRev?"接收":"发送")+"时间: "
                    color: "#AAAAAA"
                    font.pixelSize: 10
                    wrapMode: Text.WordWrap
                }

                Text {
                    text: time
                    color: "white"
                    font.pixelSize: 10
                    wrapMode: Text.WordWrap
                }
            }
            RowLayout{
                Layout.alignment: Qt.AlignLeft
                Text {
                    text: (isRev ? "接收":"发送")+"地址: "
                    color: "#AAAAAA"
                    font.pixelSize: 10
                    wrapMode: Text.WordWrap
                }

                Text {
                    text: host
                    color: "white"
                    font.pixelSize: 10
                    wrapMode: Text.WordWrap
                }
            }
            RowLayout{
                Layout.alignment: Qt.AlignLeft
                Text {
                    text: (isRev?"接收":"发送")+"长度: "
                    color: "#AAAAAA"
                    font.pixelSize: 10
                    wrapMode: Text.WordWrap
                }

                Text {
                    text: length
                    color: "white"
                    font.pixelSize: 10
                    wrapMode: Text.WordWrap
                }
            }
        }
    }

    states: [
        State {
            name: "in"
            PropertyChanges {
                target: container
                x:container.parent.width-container.width
                opacity:1.0
            }
        },
        State {
            name: "out"
            PropertyChanges {
                target: container
                x:container.parent.width
                opacity:0.5
            }
        }
    ]

    transitions: Transition {
        PropertyAnimation {
            properties: "x,opacity"; duration: 200; easing.type: Easing.OutQuad }
    }

    function showLogItemDetail(){
        SoundManager.playSlideOpenSound()
        container.state="in"
    }

    function hideLogItemDetail(){
        SoundManager.playSlideCloseSound()
        container.state="out"
    }

    function getTypeIndex(){
        return dataType.currentIndex+5
    }
}
