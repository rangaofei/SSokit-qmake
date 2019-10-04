import QtQuick 2.12
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.5
import src.udpclientmodel 1.0

Row{
    leftPadding:10
    rightPadding: 10
    UdpClientModel{
        id:udpModel
    }
    spacing:10

    LogView{
        id:udpLog
        w: parent.width-serverControl.width-parent.spacing-parent.rightPadding-parent.leftPadding
        h:parent.height
        recvC: udpModel.revCount
        sendC: udpModel.senCount
        modelList: udpModel.dataList
        onSendMsg:{
            if(!serverControl.getCurrentConn()){
                console.log("UDP Client View : 当前无连接信息,无法发送信息")
                return
            }
            if(!data){
                console.log("信息无内容")
                return
            }
            udpModel.sendMessageData(data)
        }

    }

    ServerControlView{
        id:serverControl
        viewType: 4
        onStartConnect: {
            udpModel.toggleConnect(checked,addr,port)
        }

        onDisconnectConn: {
            udpModel.kill(addr)
        }
        onConnectState: {
            udpLog.setSendMsgState(state)
        }
    }

    function setCurrentIndex(index){
        udpLog.setCurrentIndex(index)
    }

    function appendLocalAddr(msg){
        serverControl.appendLocalAddr(msg)
    }

    function appendConnec(msg){
        serverControl.appendHistoryConnect(msg)
    }


    function connClose(addr){
        serverControl.connClose(addr)
    }

    function setSendErrMsg(type,msg,isErr){
        if(type===1||type===2){
            serverControl.setErrMsg(type,msg,isErr)
        }else if(type===3){
            udpLog.setErrMsg(msg)
        }else if(type===4){
            console.log(msg)
        }
    }

    Component.onCompleted: {
        udpModel.appendLocalAddr.connect(appendLocalAddr)
        udpModel.setCurrentIndex.connect(setCurrentIndex)
        udpModel.appendConnAddr.connect(appendConnec)
        udpModel.connClose.connect(connClose)
        udpModel.sendErrMsg.connect(setSendErrMsg)
        udpModel.getAddr()
    }

    Component.onDestruction: {
        udpModel.appendLocalAddr.disconnect(appendLocalAddr)
        udpModel.setCurrentIndex.disconnect(setCurrentIndex)
        udpModel.appendConnAddr.disconnect(appendConnec)
        udpModel.connClose.disconnect(connClose)
        udpModel.sendErrMsg.connect(setSendErrMsg)
    }

}
