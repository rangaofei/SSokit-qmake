import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import src.strings 1.0

ColumnLayout{
    id:logView
    property var w
    property var h
    property int recvC: 0
    property int sendC: 0
    property bool canSend
    width: w
    height: h

    signal sendMsg(string msg)
    signal sendMsgWithHeader(string header,int lengthSize,bool bigEndian,string msg)

    LogViewDelegate{
        id:logViewDelegate
    }

    SendView{
        id:sendView
        Layout.preferredHeight:160
        Layout.fillWidth: true
        canSendMsg: canSendMsg
        onSendMsg: {
            logView.sendMsg(msg)
        }
        onSendMsgWithHeader: {
            logView.sendMsgWithHeader(header,lengthSize,bigEndian,msg)
        }
    }

    GridLayout{
        columns: 3
        rows: 1
        Layout.fillWidth: true
        Layout.preferredHeight: 15
        Layout.fillHeight: false
        Label{
            Layout.fillWidth: true
            Layout.fillHeight: true

            text: Strings.logRecv+" : "+recvC
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }

        Label{
            Layout.fillWidth: true
            Layout.fillHeight: true
            text: Strings.logSend+" : "+sendC
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }

        Button{
            Layout.fillWidth: true
            Layout.preferredWidth: 20
            Layout.fillHeight: true
            background: Rectangle{
                color: "#00000000"
                radius: parent.height/2
                border.width: 1
                border.color: "#37474f"

            }
            text: Strings.logClear
            onClicked: clearData()
        }
    }

    ListView{
        id:logListView
        Layout.fillHeight: true
        Layout.fillWidth: true
        orientation: ListView.Vertical
        clip: true
        model: LogListModel{
            id:model
        }

        delegate: logViewDelegate
        focus: true
        onCurrentIndexChanged: {
            detail.text=model.count>0 ? model.get(logListView.currentIndex).ascData : ""
        }
    }


    GroupBox{
        Layout.fillWidth: true
        Layout.preferredHeight: 50
        background: Rectangle{radius: 5;color:"#00000000";border.color: "#bdbdbd";border.width: 1}
        ColumnLayout{
            width: parent.width
            height: parent.height
            Text {
                id:detail
                Layout.fillWidth: true
                Layout.preferredWidth: parent.implicitWidth
                text: ""
                wrapMode: Text.WordWrap
            }
        }
    }
    Item {
        width: parent.width
        height: 10
    }

    function appendData(time,isRev,host,ascData,hexData,length){
        if(isRev){
            recvC+=1
        }else{
            sendC+=1
        }
        model.append({
                         time:time,
                         isRev:isRev,
                         host:host,
                         ascData:ascData,
                         hexData:hexData,
                         length:length
                     })
        logListView.currentIndex=model.count-1
    }

    function clearData(){
        model.clear()
        recvC=sendC=model.count
    }

    function setSendMsgState(canSendMsg){
        sendView.setSendMsgState(canSendMsg)
    }

    function setErrMsg(msg){
        sendView.setErrorMsg(msg)
    }
}

