import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
GridLayout {
    columns: 5
    rowSpacing: 5
    Rectangle{
        Layout.fillHeight: true
        Layout.fillWidth: true
        Text {
            text: qsTr("tabbar bg: #37474f")
            color: "white"
        }
        color: {"#37474f"}
    }
    Rectangle{
        Layout.fillHeight: true
        Layout.fillWidth: true
        Text {
            text: qsTr("tabbar selected: #cfd8dc")
            color: "black"
        }
        color: {"#cfd8dc"}
    }

    Rectangle{
        Layout.fillHeight: true
        Layout.fillWidth: true
        Text {
            text: qsTr("dialog bg:#ffffff - #cfd8dc")
            color: "black"
        }
        gradient: Gradient{
            GradientStop { position: 0.0; color: "#ffffff" }
            GradientStop { position: 1.0; color: "#cfd8dc" }
        }
    }
    Rectangle{
        Layout.fillHeight: true
        Layout.fillWidth: true
        Text {
            text: qsTr("group box line bg:#bdbdbd")
            color: "black"
        }
      color: "#bdbdbd"
    }
}
