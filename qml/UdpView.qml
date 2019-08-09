import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.5

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
        TopButton {
            name:"Server"
        }
        TopButton{
            name:"Client"
        }
//        TopButton{
//            name:"UdpTransfer"
//        }
    }
    StackLayout{
        id:view
        anchors.top: serverBar.bottom
        anchors.topMargin: 15
        currentIndex: serverBar.currentIndex
        width:parent.width
        height: parent.height-serverBar.height-30
        UdpServerView{
        }
        UdpClientView{}
    }
}






