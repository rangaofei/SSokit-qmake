import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.Layouts 1.12
import src.strings 1.0
import src.settingtool 1.0

import "../icons" as Icons

Component{
    id:listViewItem
    ItemDelegate{
        id:delegate
        width: parent.width
        height: 50
        background: Rectangle{
            color: delegate.highlighted?"#37474f":"#00000000"
            radius:4
        }
        onHighlightedChanged: {
            downArrow.requestPaint()
            upArrow.requestPaint()
        }

        highlighted: logListView.currentIndex===index

        RowLayout{
            width:parent.width
            spacing: 5
            Icons.IconUpArrow{
                id:upArrow
                y:5
                hightlighted: delegate.highlighted
                visible: !isRev
            }

            Icons.IconDownArrow{
                id:downArrow
                y:5
                hightlighted: delegate.highlighted
                visible:isRev
            }
            ColumnLayout{
                width:parent.width
                spacing: 5

                RowLayout{
                    Layout.leftMargin: 10
                    Layout.rightMargin: 10
                    Layout.fillWidth: true
                    Layout.fillHeight: false
                    Layout.topMargin: 5
                    clip: true

                    Text {
                        width: 50
                        height: 20
                        verticalAlignment: Text.AlignVCenter
                        maximumLineCount: 1
                        textFormat: Text.PlainText
                        clip :true
                        wrapMode: Text.NoWrap
                        color:delegate.highlighted?"white":"#37474f"
                        text: Strings.logTime+" : "
                        font.pixelSize: 10
                    }
                    Text {
                        height: 20
                        text: time
                        width: 150
                        elide: Text.ElideRight
                        verticalAlignment: Text.AlignVCenter
                        maximumLineCount: 1
                        textFormat: Text.PlainText
                        clip :true
                        wrapMode: Text.NoWrap
                        color:delegate.highlighted?"white":"#37474f"
                        font.pixelSize: 10
                    }
                    Text {
                        height: 20
                        width: 50
                        verticalAlignment: Text.AlignVCenter
                        maximumLineCount: 1
                        textFormat: Text.PlainText
                        clip :true
                        wrapMode: Text.NoWrap
                        color:delegate.highlighted?"white":"#37474f"
                        text: Strings.logHost+" : "
                        rightPadding: 10
                        font.pixelSize: 10
                    }
                    Text {
                        width: 200
                        height: 20
                        text: host
                        elide: Text.ElideRight
                        verticalAlignment: Text.AlignVCenter
                        maximumLineCount: 1
                        textFormat: Text.PlainText
                        clip :true
                        wrapMode: Text.NoWrap
                        color:delegate.highlighted?"white":"#37474f"
                        font.pixelSize: 10
                    }
                    Text {
                        height: 20
                        width: 50
                        verticalAlignment: Text.AlignVCenter

                        maximumLineCount: 1
                        textFormat: Text.PlainText
                        clip :true
                        wrapMode: Text.NoWrap
                        color:delegate.highlighted?"white":"#37474f"
                        text: Strings.logLength+" : "
                        rightPadding: 10
                        font.pixelSize: 10
                    }
                    Text {
                        height: 20
                        text: length
                        elide: Text.ElideRight
                        verticalAlignment: Text.AlignVCenter
                        maximumLineCount: 1
                        textFormat: Text.PlainText
                        clip :true
                        wrapMode: Text.NoWrap
                        color:delegate.highlighted?"white":"#37474f"
                        font.pixelSize: 10
                    }
                }

                RowLayout{
                    Layout.fillWidth: true
                    Layout.fillHeight: false
                    Layout.leftMargin: 10
                    Layout.rightMargin: 10
                    clip: true
                    Text {
                        Layout.fillWidth: true
                        text: hexData
                        elide: Text.ElideRight
                        maximumLineCount: 1
                        textFormat: Text.PlainText
                        clip :true
                        wrapMode: Text.NoWrap
                        color:delegate.highlighted?"white":"#37474f"
                    }

                }
            }
        }
        MouseArea{
            anchors.fill: parent
            hoverEnabled: SettingTool.getEnableLogHover()
            onClicked: {
                logListView.currentIndex=index
            }
            onEntered: {
                logListView.currentIndex=index
            }
            onExited: {
            }
            onDoubleClicked: {
                logView.showDetail();
            }
        }
    }
}

