import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.5


ColumnLayout{
    Rectangle{
        id: rectangle
        Layout.fillWidth:true
        Layout.preferredHeight: title.height
        color:"green"
        Text {
            id:title
            anchors.horizontalCenter: parent.horizontalCenter
            text: qsTr("Server")
            font.bold:true
        }
    }
    Rectangle {
        Layout.fillHeight:true
        Layout.fillWidth: true
//        gradient: Gradient {
//            GradientStop { position: 0.0; color: "#ffffff" }
//            GradientStop { position: 1.0; color: "#cfd8dc" }
//        }
        color: "green"
    }
}

