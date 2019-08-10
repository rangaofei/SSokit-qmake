import QtQuick.Controls 2.5
import QtQuick 2.12
import QtQuick.Layouts 1.12
import src.settingtool 1.0

ApplicationWindow{
    property int windowW: 900
    property int windwoH: 600

    //关于对话框
    AboutDialog{
        id:aboutDialog
        showing: false
    }
    //帮助对话框
    HelpDialog{
        id:helpDialog
        showing:false
    }

    //设置工具
    SettingTool{
        id:settingtool
    }

    id:window
    visible: true
    title: qsTr("SSokit")
    width: windowW
    height: windwoH
    minimumWidth: windowW
    minimumHeight:windwoH
    x:settingtool.getWindowPositionX()
    y:settingtool.getWindowPositionY()

    Item {
        id:container
        width: parent.width
        anchors.top:  parent.top
        anchors.bottom: parent.bottom
        TabBar {
            id: footerBar
            contentWidth: parent.width
            currentIndex: view.currentIndex
            anchors.bottom: parent.bottom
            leftPadding: 50
            rightPadding: 50
            background: Rectangle {
                color: "#37474f"
            }


            BottomButton {
                name:qsTr("Tcp")
            }
            BottomButton {
                name:qsTr("Udp")
            }
            //        BottomButton {
            //            name:qsTr("WebSocket")
            //        }
            //        BottomButton {
            //            name:qsTr("BlueTooth")
            //        }
            //        BottomButton{
            //            name:qsTr("COM")
            //        }
            BottomButton{
                id:notepad
                name:qsTr("Notepad")
            }
            //        BottomButton{
            //            id:peltte
            //            name:"Plette"
            //        }

        }
        SwipeView{
            id: view
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: footerBar.top
            currentIndex: footerBar.currentIndex
            clip: true
            interactive:false
            TcpView{}

            UdpView{}
            //        WebSocketView{}

            //            BlueToothView{

            //            }

            NotepadView{}
            //            ColorList{

            //            }
        }
        Image {
            source: "qrc:/assets/images/catalogue.png"
            smooth: true
            width: 18
            height: 18
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.margins:15
            TapHandler {
                onTapped: toggleDrawer()
            }
            visible: true
        }

        Image {
            source: "qrc:/assets/images/about.png"
            smooth: true
            width: 18
            height: 18
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.margins:15
            TapHandler {
                onTapped: toggleAboutDialog()
            }
            visible: true
        }
    }


    SettingView {
        id: drawer
        width: 400
        height: parent.height
        modal: true
        dim:false
        onDrawXChanged: {
            container.x=positionXPercent*drawer.width
        }
    }
    //关闭时保存当前窗口位置
    onClosing: {
        settingtool.setWindowPosition(window.x,window.y)
    }
    //切换tab的快捷键
    Shortcut{
        sequences: ["shift+tab"]
        context: Qt.ApplicationShortcut
        onActivated: switchTab()
    }
    //切换tab
    function switchTab(){
        footerBar.currentIndex++
        footerBar.currentIndex=footerBar.currentIndex % footerBar.count
    }
    //开关关于对话框
    function toggleAboutDialog(){
        aboutDialog.toggleAboutDialog()
    }
    //开关设置抽屉
    function toggleDrawer(){
        if(!drawer.visible){
            drawer.open()
        }else{
            drawer.close()
        }
    }
}
