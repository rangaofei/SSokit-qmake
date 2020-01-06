import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

Item {
    property var jsonModel
    TreeView {
        anchors.fill: parent
        backgroundVisible: false
        TableViewColumn {
            title: "Name"
            role: "key"
        }
        TableViewColumn {
            title: "Obj"
            role: "Value"
        }
        model: jsonModel

        style: TreeViewStyle{
            backgroundColor: "#00000000"
            textColor: "green"
            itemDelegate: Rectangle {
                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    text: styleData.value.itemData
                    color: styleData.selected ? "white" : "black"
                    font.bold: styleData.selected

                }
                color: "transparent"

            }
            indentation: 4
            rowDelegate:Rectangle{
                color: styleData.selected ? "#3399FF" : "transparent";
                height: 28
            }

        }
        sortIndicatorVisible: false
    }

}
