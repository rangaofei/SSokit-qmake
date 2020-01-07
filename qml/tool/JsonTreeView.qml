import QtQuick 2.12
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

RowLayout {
    property var jsonModel

    GroupBox{
        Layout.fillWidth: true
        Layout.fillHeight: true
        Layout.leftMargin: 20
        Layout.rightMargin: 20
        Layout.topMargin: 10
        Layout.bottomMargin: 20
        background: Rectangle{
            color: "white"
            radius: 10
        }
        TreeView {
            anchors.fill: parent

            backgroundVisible: true
            TableViewColumn {
                title: "View"
                role: "key"
            }

            model: jsonModel

            style: TreeViewStyle{

                backgroundColor: "transparent"
                textColor: "black"
                itemDelegate: Rectangle {
                    RowLayout{
                        anchors.fill: parent
                        Text {
                            Layout.alignment: Qt.AlignVCenter

                            text: styleData.value.jsonKey===null?"":styleData.value.jsonKey
                            color: styleData.selected ? "white" : "black"
                            font.bold: styleData.selected
                        }
                        Text {
                            Layout.leftMargin: 20
//                            Layout.alignment: Qt.AlignVCenter
                            text: styleData.value.jsonValue===null?"":styleData.value.jsonValue
                            color: styleData.selected ? "white" : "black"
                            font.bold: styleData.selected
                        }
                    }
                    color: "transparent"

                }
                rowDelegate:Rectangle{
                    color: styleData.selected ? "#3399FF" : "transparent";
                    height: 28
                }

            }
            sortIndicatorVisible: false
        }
    }
}
