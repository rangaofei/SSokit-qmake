import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

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
        ColumnLayout{
            width:parent.width
            spacing: 5
            RowLayout{
                Layout.leftMargin: 10
                Layout.rightMargin: 10
                Layout.fillWidth: true
                Layout.topMargin: 5
                IconUpArrow{
                    id:upArrow
                    y:5
                    hightlighted: delegate.highlighted
                    visible: !isRev
                }
                IconDownArrow{
                    id:downArrow
                    y:5
                    hightlighted: delegate.highlighted
                    visible:isRev
                }
                Text {
                    width: 50
                    height: 20
                    verticalAlignment: Text.AlignVCenter
                    maximumLineCount: 1
                    textFormat: Text.PlainText
                    clip :true
                    wrapMode: Text.NoWrap
                    color:delegate.highlighted?"white":"#37474f"
                    text: qsTr("Time:")
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
                    text: qsTr("Ip:")
                    rightPadding: 10
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
                    text: qsTr("Length:")
                    rightPadding: 10
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

                }
            }

            Row{
                Layout.fillWidth: true
                leftPadding: 10
                rightPadding: 10
                Text {
                    width: parent.width
                    height: 20
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
        MouseArea{
            anchors.fill: parent
            onClicked: {
                logListView.currentIndex=index
            }
        }
    }
}

