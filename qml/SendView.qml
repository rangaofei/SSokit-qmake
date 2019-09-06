import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Styles 1.4
import src.strings 1.0
import src.settingtool 1.0

GroupBox{
    property bool canSendMsg: false

    signal sendMsgWithHeader(string header,int lengthSize,bool bigEndian,string msg)
    signal sendMsg(string msg)

    background: Rectangle{
        radius: 5
        color:"#00000000"
        border.color: "#bdbdbd"
        border.width: 1
    }

    Item {
        anchors.fill: parent
        clip: true
        SocketHeaderView{
            id:socketView
            checkEnabled: canSendMsg
            state: showHeader.checked?"in":"out"
        }

        Rectangle{
            id:divider
            width: 1
            anchors.left: socketView.right
            anchors.leftMargin: 10
            anchors.rightMargin: 10
            color: "#bdbdbd"
            visible: false
        }
        ColumnLayout{
            anchors.left: divider.right
            anchors.right: parent.right
            RowLayout{
                Layout.fillWidth: true
                Layout.preferredHeight: 30
                Label{
                    Layout.preferredWidth: 50
                    Layout.fillHeight: false
                    Layout.preferredHeight: 30
                    text: Strings.sendBuf1
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }
                TextField{
                    id:buffer1
                    Layout.fillWidth: true
                    Layout.fillHeight: false
                    Layout.preferredHeight: 30
                    background: Rectangle {
                        color: buffer1.enabled ? "transparent" : "#00ffffff"
                        border.color: buffer1.enabled ? "#bdbdbd" : "#bdbdbd"
                        radius: 3
                    }
                }
                Image {
                    Layout.preferredHeight: 15
                    Layout.preferredWidth: 15
                    Layout.fillHeight: false
                    Layout.fillWidth: false
                    Layout.alignment: Qt.AlignHCenter
                    source: "qrc:/assets/images/ic_clear.png"
                    TapHandler{
                        onTapped: buffer1.clear()
                    }
                    visible: SettingTool.getShowSendClear()
                }
                Button{
                    enabled: canSendMsg
                    Layout.preferredWidth: 50
                    Layout.fillHeight:false
                    Layout.preferredHeight: 25
                    text: Strings.send
                    background: Rectangle{
                        border.color: enabled?"#37474f":"#cfd8dc"
                        color: "transparent"
                        border.width: 1
                        radius: parent.height/2
                    }
                    onClicked: {sendMessage(buffer1.text)}
                }
            }
            RowLayout{
                Layout.fillWidth: true
                Layout.preferredHeight: 30
                Label{
                    Layout.preferredWidth: 50
                    Layout.fillHeight: false
                    Layout.preferredHeight: 30
                    text: Strings.sendBuf2
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }
                TextField{
                    id:buffer2
                    Layout.fillWidth: true
                    Layout.fillHeight: false
                    Layout.preferredHeight: 30
                    background: Rectangle {
                        color: buffer2.enabled ? "transparent" : "transparent"
                        border.color: buffer2.enabled ? "#bdbdbd" : "#bdbdbd"
                        radius: 3
                    }
                }
                Image {
                    Layout.preferredHeight: 15
                    Layout.preferredWidth: 15
                    Layout.fillHeight: false
                    Layout.fillWidth: false
                    Layout.alignment: Qt.AlignHCenter
                    source: "qrc:/assets/images/ic_clear.png"
                    TapHandler{
                        onTapped: buffer2.clear()
                    }
                     visible: SettingTool.getShowSendClear()
                }
                Button{
                    enabled: canSendMsg
                    Layout.preferredWidth: 50
                    Layout.fillHeight:false
                    Layout.preferredHeight: 25
                    text: Strings.send
                    background: Rectangle{
                        border.color: enabled?"#37474f":"#cfd8dc"
                        color: "transparent"
                        border.width: 1
                        radius: parent.height/2
                    }
                    onClicked: {sendMessage(buffer2.text)}
                }
            }
            RowLayout{
                Layout.fillWidth: true
                Layout.preferredHeight: 30
                Label{
                    Layout.preferredWidth: 50
                    Layout.fillHeight: false
                    Layout.preferredHeight: 30
                    text: Strings.sendBuf3
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }
                TextField{
                    id:buffer3
                    Layout.fillWidth: true
                    Layout.fillHeight: false
                    Layout.preferredHeight: 30

                    background: Rectangle {
                        color: buffer3.enabled ? "transparent" : "transparent"
                        border.color: buffer3.enabled ? "#bdbdbd" : "#bdbdbd"
                        radius: 3
                    }
                }
                Image {
                    Layout.preferredHeight: 15
                    Layout.preferredWidth: 15
                    Layout.fillHeight: false
                    Layout.fillWidth: false
                    Layout.alignment: Qt.AlignHCenter
                    source: "qrc:/assets/images/ic_clear.png"
                    TapHandler{
                        onTapped: buffer3.clear()
                    }
                     visible: SettingTool.getShowSendClear()
                }
                Button{
                    enabled: canSendMsg
                    Layout.preferredWidth: 50
                    Layout.fillHeight:false
                    Layout.preferredHeight: 25
                    text: Strings.send
                    background: Rectangle{
                        border.color: enabled?"#37474f":"#cfd8dc"
                        color: "transparent"
                        border.width: 1
                        radius: parent.height/2
                    }
                    onClicked: {sendMessage(buffer3.text)}
                }
            }
            RowLayout{
                Layout.fillWidth: true
                Layout.fillHeight: false
                Layout.preferredHeight: 30
                GeneralCheckBox{
                    Layout.leftMargin: 50
                    id:showHeader
                    text: Strings.sendAdvance
                    Layout.preferredHeight: 16
                    checked: false

                    onCheckedChanged: {
                        if(checked){
                            socketView.startShow()
                        }else{
                            socketView.stopShow()
                        }
                    }
                }
                TipLabel{
                    id:errMsg
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    msg:""
                    err:true
                }
            }
        }
    }


    function sendMessage(buf){
        if(socketView.isWithHeader()){
            var headerStr=socketView.getHeader()
            var isBigEndian=socketView.isBigEndian()
            var length=socketView.getLengthSize()
            var bufWithTailer=buf+socketView.getTailer()
            sendMsgWithHeader(headerStr,length,isBigEndian,bufWithTailer)
        }else{
            sendMsg(buf)
        }
    }

    function setSendMsgState(canSend){
        canSendMsg=canSend
    }

    function setErrorMsg(msg){
        errMsg.setState(true,msg)
    }
}
