import QtQuick 2.12
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.5
import src.tcpclientmodel 1.0

Row{
    id:tcpClientView
    leftPadding:10
    rightPadding: 10
    TcpClientModel{
        id:tcpModel
    }
    spacing:10

    LogView{
        id:tcpLog
        w: parent.width-serverControl.width-parent.spacing-parent.rightPadding-parent.leftPadding
        h:parent.height

        onSendMsg:{
            if(!serverControl.getCurrentConn()){
                console.log("TCP Client View:当前连接为空 无法发送信息")
                return
            }
            if(!msg){
                console.log("信息无内容")
                return
            }
            tcpModel.send(msg)
        }
        onSendMsgWithHeader: {
            if(!serverControl.getCurrentConn()){
                console.log("UDP Client View : 当前无连接信息,无法发送信息")
                return
            }
            if(!msg){
                console.log("信息无内容")
                return
            }
            console.log("TCP client 发送信息"+msg+",size:"+lengthSize)
            tcpModel.sendWithHeader(header,lengthSize,bigEndian,msg)
        }
    }

    ServerControlView{
        id:serverControl
        viewType: 2
        onStartConnect: {
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
        console.log("close connection "+addr)
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
        tcpModel.appendLocalAddr.connect(appendLocalAddr)
        tcpModel.sendLogMsg.connect(appendLogMsg)
        tcpModel.appendConnAddr.connect(appendConnec)
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
