import QtQuick 2.13
import QtQuick.Controls 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.13
import QtGraphicalEffects 1.12

import src.settingtool 1.0
import src.strings 1.0
import src.soundmanager 1.0

import "../widgets" as Widgets

Drawer {
    property bool isOpened: false
    signal drawXChanged(var positionXPercent)

    id: drawer
    clip: true
    edge: Qt.LeftEdge
    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

    background: Rectangle{
        color: "#ffffff"
    }

    onClosed: {
        SoundManager.playSlideCloseSound()
    }

    onOpened: {
        SoundManager.playSlideOpenSound()
    }

    Rectangle{
        id:menuBar;
        width: 60;
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        color: "#37474f"
        ColumnLayout{
            id:container_header
            width: parent.width;
            anchors.top: parent.top
            anchors.topMargin: 20
            spacing: 10
            Image{
                Layout.preferredWidth: 20
                Layout.preferredHeight: 20
                id:img_header
                Layout.alignment: Qt.AlignHCenter
                source: "qrc:/assets/images/catalogue_white.png"

            }
            Text{
                id:setting
                text: Strings.setting
                color: "#ffffff"
                Layout.alignment: Qt.AlignHCenter
                font.pixelSize: 12
                font.bold: true
            }
            Rectangle {
                Layout.preferredWidth: parent.width
                Layout.preferredHeight: 1
                color: "#ffffff"
            }

        }

        Widgets.ImageButton{
            id:container_general
            width: parent.width;
            anchors.top: container_header.bottom
            anchors.topMargin: 20
            text: Strings.settingGeneral
            checked: true
            source: "qrc:/assets/images/setting.png"
            onCheckedChanged: {
                if(!checked){
                    return
                }
                container_about.checked=false
                container_shortcut.checked=false
                container_function.checked=false
                tabView.currentIndex=0
            }
        }

        Widgets.ImageButton{
            id:container_function
            width: parent.width;
            anchors.top: container_general.bottom
            anchors.topMargin: 20
            text: Strings.settingFunction
            checked: false
            source: "qrc:/assets/images/function.png"
            onCheckedChanged: {
                if(!checked){
                    return
                }
                container_about.checked=false
                container_general.checked=false
                container_shortcut.checked=false
                tabView.currentIndex=1
            }
            visible: true
        }
        Widgets.ImageButton{
            id:container_shortcut
            width: parent.width
            anchors.top: container_function.bottom
            anchors.topMargin: 20
            source: "qrc:/assets/images/shortcut.png"
            text: Strings.settingShortCut
            onCheckedChanged: {
                if(!checked){
                    return
                }
                container_about.checked=false
                container_general.checked=false
                container_function.checked=false
                tabView.currentIndex=2
            }
        }
        Widgets.ImageButton{
            id:container_about
            width: parent.width
            anchors.top: container_shortcut.bottom
            anchors.topMargin: 20
            source: "qrc:/assets/images/about_selected.png"
            text: Strings.settingAbout
            onCheckedChanged: {
                if(!checked){
                    return
                }
                container_general.checked=false
                container_shortcut.checked=false
                container_function.checked=false
                tabView.currentIndex=3
            }
        }
    }

    DropShadow {
        anchors.fill: menuBar
        horizontalOffset: 3
        verticalOffset: 0
        radius: 8.0
        samples: 16
        color: "#80000000"
        source: menuBar
    }

//    Rectangle{
//        id:divider
//        anchors.left: menuBar.right
//        anchors.leftMargin: 2
//        height: parent.height
//        width: 2
//        color: "#bdbdbd"
//    }

    TabView{
        id:tabView;
        anchors.left: menuBar.right;
        anchors.top:parent.top
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.leftMargin: 20
        anchors.rightMargin: 20
        frameVisible: false
        tabsVisible: false
        Tab{
            GeneralSettingView{
            }
        }
        Tab{
            FunctionSettingView{}
        }
        Tab{
            ShortCutSettingView{
            }
        }
        Tab{
            AboutSettingView{}
        }
    }
    onXChanged: {
        drawXChanged((drawer.x+drawer.width)/drawer.width)
    }

    function toggleDrawer(){
        if(visible){
            close()
        }else{
            open()
        }
    }
}
