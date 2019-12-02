import QtQuick 2.0
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12

import "../widgets" as Widgets
import src.strings 1.0

Rectangle{
    Layout.fillWidth: true
    Layout.fillHeight: true

    gradient: Gradient {
        GradientStop { position: 0.0; color: "#ffffff" }
        GradientStop { position: 1.0; color: "#cfd8dc" }
    }

    TabBar {
        id:serverBar
        width: implicitWidth
        height: implicitHeight
        anchors.top: parent.top
        anchors.topMargin: 15
        anchors.horizontalCenter: parent.horizontalCenter
        currentIndex: view.currentIndex
        Widgets.TopButton {
            name:Strings.toolNotePad
        }
        Widgets.TopButton{
            name:Strings.toolJsonFormat
        }
    }
    StackLayout{
        id:view
        anchors.top: serverBar.bottom
        anchors.topMargin: 15
        currentIndex: serverBar.currentIndex
        width:parent.width
        height: parent.height-serverBar.height-30

        NotepadView{}
        JsonFormat{}
    }
}
