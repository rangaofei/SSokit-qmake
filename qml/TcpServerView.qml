import QtQuick 2.12
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.5
import src.tcpservermodel 1.0

Row{
    leftPadding:10
    rightPadding: 10
    TcpServerModel{
        id:tcpModel
    }
    spacing:10

    ServerControlView{
        id:serverControl
        viewType: 1
        onStartConnect: {
            tcpModel.toggleConnect(checked,addr,port)
        }

        onDisconnectConn: {
            tcpModel.kill(addr)
        }
        onConnectState: {
            tcpLog.setSendMsgState(state)
        }
    }

    LogView{
        id:tcpLog
        w: parent.width-serverControl.width-parent.spacing-parent.rightPadding-parent.leftPadding
        h:parent.height
        recvC: tcpModel.revCount
        sendC: tcpModel.senCount
        modelList: tcpModel.dataList
        onSendMsg:{
            if(!serverControl.getCurrentConn()){
                console.log("无法发送信息")
                return
            }
            if(!data){
                console.log("信息无内容")
                return
            }
            console.log("send messageData")
            tcpModel.sendMessageData(serverControl.getCurrentConn(),data)
        }
        onClearData: {
            tcpModel.clearAll(true)
        }
    }

    function setCurrentIndex(index){
        tcpLog.setCurrentIndex(index)
    }

    function appendLocalAddr(msg){
        serverControl.appendLocalAddr(msg)
    }

    function appendConnec(msg){
        serverControl.appendHistoryConnect(msg)
    }

    function appendLogMsg(time,type,host,ascData,hexData,length){
        tcpLog.appendData(time,type,host,ascData,hexData,length)
    }


    function connClose(addr){
        serverControl.connClose(addr)
    }

    function setSendErrMsg(type,msg,isErr){
        if(type===1||type===2){
            if(serverControl){
                serverControl.setErrMsg(type,msg,isErr)}
        }else if(type===3){
            udpLog.setErrMsg(msg)
        }else if(type===4){
        }
    }

    Component.onCompleted: {
        tcpModel.appendLocalAddr.connect(appendLocalAddr)
        tcpModel.appendConnAddr.connect(appendConnec)
        tcpModel.setCurrentIndex.connect(setCurrentIndex)
        tcpModel.connClose.connect(connClose)
        tcpModel.sendErrMsg.connect(setSendErrMsg)
        tcpModel.getAddr()
    }

    Component.onDestruction: {
        tcpModel.appendLocalAddr.disconnect(appendLocalAddr)
        tcpModel.setCurrentIndex.disconnect(setCurrentIndex)
        tcpModel.appendConnAddr.disconnect(appendConnec)
        tcpModel.connClose.disconnect(connClose)
        tcpModel.sendErrMsg.connect(setSendErrMsg)
    }

}
