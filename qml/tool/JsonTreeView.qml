import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.12

RowLayout {
    property var jsonModel

    TreeView {
        anchors.fill: parent
        TableViewColumn {
            title: "Name"
            role: "key"
            width: 300
        }

        model: jsonModel
        itemDelegate: Item {
            Text {
                anchors.verticalCenter: parent.verticalCenter
                text: styleData.value
            }
        }
        sortIndicatorVisible: true
    }

}
