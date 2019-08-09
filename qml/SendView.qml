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

    ColumnLayout{
        width: parent.width
        //这个地方做成包头的形式
        RowLayout{
            Layout.fillWidth: true
            height: 30
            Label{
                Layout.preferredWidth: 50
                Layout.fillHeight: true
                text: qsTr("Header:")
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }
            TextField{
                id:header
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.preferredHeight: 20
                background: Rectangle {
                    color: enabled ? "transparent" : "#00ffffff"
                    border.color: enabled ? "#bdbdbd" : "#bdbdbd"
                    radius: 3
                }
            }
            Text{
                Layout.preferredWidth:50
                Layout.preferredHeight: 25
                text: qsTr("长度类型")
            }
            EditComboBox{
                id:lengthSizeBox
                Layout.preferredWidth: 100
                Layout.preferredHeight: 25
                editable: false
                //                enabled: canSendMsg
                model: ListModel {
                    id: model
                    ListElement { text: qsTr("none") }
                    ListElement { text: qsTr("short") }
                    ListElement { text: qsTr("int") }
                }

            }
            Text{
                Layout.preferredWidth: 50
                Layout.preferredHeight: 25
                text: qsTr("内存模式")
            }
            EditComboBox{
                id:endianBox
                Layout.preferredWidth: 100
                Layout.preferredHeight: 25
                editable: false
                //                enabled: canSendMsg
                currentIndex: 0
                model: ListModel {
                    ListElement { text: qsTr("BigEndian") }
                    ListElement { text: qsTr("LittileEndian") }
                }
            }
            RoundCheckBox{
                id:withHeader
                enabled: canSendMsg
                Layout.preferredWidth: 50
                Layout.fillHeight:false
                Layout.preferredHeight: 25
                checked: false
                showText: false
                text: qsTr("添加")
            }
        }

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

    function sendMessage(buf){
        if(withHeader.checked){
            var isBigEndian=endianBox.currentIndex==0
            var length=lengthSizeBox.currentIndex*2
            console.log(length+"____")
            sendMsgWithHeader(header.text,length,isBigEndian,buf)
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
