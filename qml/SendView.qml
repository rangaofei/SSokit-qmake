import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.5

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
    RowLayout{
        anchors.fill: parent
        SocketHeaderView{
            id:socketView
            checkEnabled:  canSendMsg
        }
        Rectangle{
            Layout.preferredWidth: 2
            Layout.fillHeight: true
            Layout.margins: 10
            Layout.bottomMargin: 50
            color: "#bdbdbd"
        }
        ColumnLayout{
            Layout.fillWidth: true
            Layout.fillHeight: true
            RowLayout{
                Layout.fillWidth: true
                height: 30
                Label{
                    Layout.preferredWidth: 50
                    Layout.fillHeight: true
                    text: qsTr("Buf1:")
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }
                TextField{
                    id:butffer1
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Layout.preferredHeight: 20
                    background: Rectangle {
                        color: butffer1.enabled ? "transparent" : "#00ffffff"
                        border.color: butffer1.enabled ? "#bdbdbd" : "#bdbdbd"
                        radius: 3
                    }
                }
                Button{
                    enabled: canSendMsg
                    Layout.preferredWidth: 50
                    Layout.fillHeight:false
                    Layout.preferredHeight: 25
                    text: qsTr("send")
                    background: Rectangle{
                        border.color: enabled?"#37474f":"#cfd8dc"
                        color: "transparent"
                        border.width: 1
                        radius: parent.height/2
                    }
                    onClicked: {sendMessage(butffer1.text)}
                }
            }
            RowLayout{
                Layout.fillWidth: true
                height: 30
                Label{
                    Layout.preferredWidth: 50
                    Layout.fillHeight: true
                    text: qsTr("Buf2:")
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }
                TextField{
                    id:buffer2
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Layout.preferredHeight: 20
                    background: Rectangle {
                        color: buffer2.enabled ? "transparent" : "transparent"
                        border.color: buffer2.enabled ? "#bdbdbd" : "#bdbdbd"
                        radius: 3
                    }
                }
                Button{
                    enabled: canSendMsg
                    Layout.preferredWidth: 50
                    Layout.fillHeight:false
                    Layout.preferredHeight: 25
                    text: qsTr("send")
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
                height: 30
                Label{
                    Layout.preferredWidth: 50
                    Layout.fillHeight: true
                    text: qsTr("Buf2:")
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }
                TextField{
                    id:buffer3
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Layout.preferredHeight: 20
                    background: Rectangle {
                        color: buffer3.enabled ? "transparent" : "transparent"
                        border.color: buffer3.enabled ? "#bdbdbd" : "#bdbdbd"
                        radius: 3
                    }
                }
                Button{
                    enabled: canSendMsg
                    Layout.preferredWidth: 50
                    Layout.fillHeight:false
                    Layout.preferredHeight: 25
                    text: qsTr("send")
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
                height: 20
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
            sendMsgWithHeader(headerStr,length,isBigEndian,buf)
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
