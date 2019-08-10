import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Styles 1.4
import src.strings 1.0
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
                    id:butffer1
                    Layout.fillWidth: true
                    Layout.fillHeight: false
                    Layout.preferredHeight: 30
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
                    text: Strings.send
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
                CheckBox{
                    Layout.leftMargin: 50
                    id:showHeader
                    text: Strings.sendAdvance
                    Layout.preferredHeight: 16
                    checked: true
                    indicator: Rectangle{
                        implicitWidth: 14;
                        implicitHeight: 14;
                        border.color: "gray";
                        border.width: 1;
                        color: "#00000000"
                        Canvas{
                            anchors.fill: parent;
                            anchors.margins: 3;
                            visible: showHeader.checked;
                            onPaint: {
                                var ctx = getContext("2d");
                                ctx.save();
                                ctx.strokeStyle = "#37474f";
                                ctx.lineWidth = 2;
                                ctx.fillStyle = "#00000000"
                                ctx.lineCap="round";
                                ctx.beginPath();
                                ctx.moveTo(2,5);
                                ctx.lineTo(4,7);
                                ctx.lineTo(7,2);
                                ctx.stroke();
                            }
                        }
                    }



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

    Component{


        id: checkStyle;
        CheckBoxStyle{


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
