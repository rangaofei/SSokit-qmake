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
        onStartConnect: {
            console.log("打开开关:"+checked)
            tcpModel.toggleConnect(checked,addr,port)
        }

        onDisconnectConn: {
            tcpModel.kill(addr)
        }
        onConnectState: {
            console.log("change state "+state)
            tcpLog.setSendMsgState(state)
        }
    }

    LogView{
        id:tcpLog
        w: parent.width-serverControl.width-parent.spacing-parent.rightPadding-parent.leftPadding
        h:parent.height

        onSendMsg:{
            if(!serverControl.getCurrentConn()){
                console.log("无法发送信息")
                return
            }
            if(!msg){
                console.log("信息无内容")
                return
            }
            tcpModel.send(serverControl.getCurrentConn(),msg)
        }

        onSendMsgWithHeader: {
            if(!serverControl.getCurrentConn()){
                console.log("无法发送信息")
                return
            }
            if(!msg){
                console.log("信息无内容")
                return
            }
            tcpModel.sendWithHeader(serverControl.getCurrentConn(),header,lengthSize,bigEndian,msg)
        }
    }

    function appendLocalAddr(msg){
        serverControl.appendLocalAddr(msg)
    }

    function appendConnec(msg){
        serverControl.appendHistoryConnect(msg)
    }

    function appendLogMsg(time,type,host,ascData,hexData,length){
        console.log("TcpServer:ascData="+ascData)
        tcpLog.appendData(time,type,host,ascData,hexData,length)
    }


    function connClose(addr){
        serverControl.connClose(addr)
    }

    function setSendErrMsg(type,msg,isErr){
        console.log("error type "+type+"||||"+msg+"||||"+isErr)
        if(type===1||type===2){
            if(serverControl){
                serverControl.setErrMsg(type,msg,isErr)}
        }else if(type===3){
            udpLog.setErrMsg(msg)
        }else if(type===4){
            console.log(msg)
        }
    }

    Component.onCompleted: {
        tcpModel.appendLocalAddr.connect(appendLocalAddr)
        tcpModel.appendConnAddr.connect(appendConnec)
        tcpModel.sendLogMsg.connect(appendLogMsg)
        tcpModel.connClose.connect(connClose)
        tcpModel.sendErrMsg.connect(setSendErrMsg)
        tcpModel.getAddr()
    }

    Component.onDestruction: {
        tcpModel.appendLocalAddr.disconnect(appendLocalAddr)
        tcpModel.sendLogMsg.disconnect(appendLogMsg)
        tcpModel.appendConnAddr.disconnect(appendConnec)
        tcpModel.connClose.disconnect(connClose)
        tcpModel.sendErrMsg.connect(setSendErrMsg)
    }

}
