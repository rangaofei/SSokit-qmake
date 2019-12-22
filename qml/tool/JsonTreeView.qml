import QtQuick 2.0
import QtQuick.Controls 1.4


Item {
    property var jsonModel

    TreeView {
        anchors.fill: parent
        TableViewColumn {
            title: "Name"
            role: "fileName"
            width: 300
        }

        model: jsonModel
        itemDelegate: Item {
            Button {
                anchors.verticalCenter: parent.verticalCenter
                text: styleData.value
               onClicked: {
//                   console.log("onClicked:", index)
//                   console.log("isExpanded:",isExpanded(index))
                   console.log(styleData.value)
               }
            }
        }


    }

}
