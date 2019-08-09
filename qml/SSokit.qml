import QtQuick.Controls 2.5
import QtQuick 2.12
import QtQuick.Layouts 1.12
import src.settingtool 1.0

ApplicationWindow{
    property int windowW: 1000
    property int windwoH: 600
    property bool drawerOpened: false

    //关于对话框
    AboutDialog{
        id:aboutDialog
        showing: false
    }
    //帮助对话框
    HelpDialog{
        id:helpdialog
        showing:false
    }

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
            contentWidth:  parent.width
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
            TcpView{

            }

            UdpView{

            }
            //        WebSocketView{}

            //            BlueToothView{

            //            }

            NotepadView{

            }
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
                onTapped: {
                    if(!drawer.visible){
                        drawer.open()
                    }else{
                        drawer.close()
                    }
                }

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
        width: parent.width*0.5
        height: parent.height
        modal: true
        dim:false
        onDrawXChanged: {
            container.x=positionXPercent*drawer.width
//            container.scale=1-positionXPercent<0.8?0.8:1-positionXPercent
        }
    }

    onClosing: {
        settingtool.setWindowPosition(window.x,window.y)
    }

    //    Shortcut{
    //        sequence: "F1"
    //        context:Qt.ApplicationShortcut
    //        onActivated: helpdialog.toggleDialog()
    //    }

    Shortcut{
        sequences: ["shift+tab"]
        context: Qt.ApplicationShortcut
        onActivated: switchTab()
    }
    function switchTab(){
        footerBar.currentIndex++
        footerBar.currentIndex=footerBar.currentIndex % footerBar.count
    }
    function showDialog(){
        helpdialog.toggleDialog()
    }

    function toggleAboutDialog(){
        aboutDialog.toggleAboutDialog()
    }

}
