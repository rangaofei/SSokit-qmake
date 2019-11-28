import QtQuick 2.12
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.5
import src.broadcastmodel 1.0

import "./components" as Components


Row{
    property bool canSendMsg: false

    BroadcastModel{
        id:broadcastModel
    }
    leftPadding:10
    rightPadding: 10

    spacing:10

    Components.ServerControlView {
        id:serverControl
        viewType: 3
        onStartConnect: {
            broadcastModel.toggleConnect(checked,addr,port)
        }
        onDisconnectConn: {
            broadcastModel.kill(addr)
        }
        onConnectState: {
            console.log("change state "+state)
            udpLog.setSendMsgState(state)
        }
    }

    Components.LogView{
        id:udpLog
        w: parent.width-serverControl.width-parent.spacing-parent.rightPadding-parent.leftPadding
        h:parent.height
        recvC: broadcastModel.revCount
        sendC: broadcastModel.senCount
        modelList: broadcastModel.dataList
        onSendMsg:{
            if(!serverControl.getCurrentConn()){
                console.log("无法发送信息")
                return
            }
            if(!data){
                console.log("信息无内容")
                return
            }
            broadcastModel.sendMessageData(serverControl.getCurrentConn(),data)
        }
    }

    function setCurrentIndex(index){
        udpLog.setCurrentIndex(index)
    }

    function appendConnec(msg){
        serverControl.appendHistoryConnect(msg)
    }

    function appendLocalAddr(msg){
        serverControl.appendLocalAddr(msg)
    }


    function connClose(addr){
        serverControl.connClose(addr)
    }

    function setSendErrMsg(type,msg,isErr){
        console.log("error type "+type+"||||"+msg+"||||"+isErr)
        if(type===1||type===2){
            serverControl.setErrMsg(type,msg,isErr)
        }else if(type===3){
            udpLog.setErrMsg(msg)
        }else if(type===4){
            console.log(msg)
        }
    }

    Component.onCompleted: {
        broadcastModel.appendLocalAddr.connect(appendLocalAddr)
        broadcastModel.setCurrentIndex.connect(setCurrentIndex)
        broadcastModel.appendConnAddr.connect(appendConnec)
        broadcastModel.connClose.connect(connClose)
        broadcastModel.sendErrMsg.connect(setSendErrMsg)
        broadcastModel.getAddr()
    }

    Component.onDestruction: {
        broadcastModel.appendLocalAddr.disconnect(appendLocalAddr)
        broadcastModel.setCurrentIndex.disconnect(setCurrentIndex)
        broadcastModel.appendConnAddr.disconnect(appendConnec)
        broadcastModel.connClose.disconnect(connClose)
        broadcastModel.sendErrMsg.disconnect(setSendErrMsg)
    }

}


