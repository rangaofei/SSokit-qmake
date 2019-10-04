import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import src.strings 1.0
import src.sendmessagedata 1.0

ColumnLayout{

    property var modelList

    id:logView
    property var w
    property var h
    property int recvC: 0
    property int sendC: 0
    property bool canSend
    width: w
    height: h

    signal sendMsg(SendMessageData data)
    signal clearData()

    LogViewDelegate{
        id:logViewDelegate
    }

    SendView{
        id:sendView
        Layout.preferredHeight:160
        Layout.fillWidth: true
        canSendMsg: canSendMsg
        onSendMsg: {
            console.log(data.getTargetMsg())
            logView.sendMsg(data)
        }
    }



    Item{
        Layout.fillHeight: true
        Layout.fillWidth: true
        clip: true
        ListView{
            id:logListView
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: divider.left
            orientation: ListView.Vertical
            rightMargin: 20
            clip: true
            model:modelList
            delegate: logViewDelegate
            focus: true
            onCurrentIndexChanged: {
                logDetailView.detailLogText=getLogItemDetail(logDetailView.getTypeIndex())
                logDetailView.time=getLogItemDetail(1)
                logDetailView.isRev=getLogItemDetail(2)
                logDetailView.host=getLogItemDetail(3)
                logDetailView.length=getLogItemDetail(4)
            }
        }

        Item{
            id:divider
            width: 10
            anchors.right: logDetailView.left
        }
        LogDetailView{
            id:logDetailView
            dataWidth: parent.width*0.6-20
            state: showLogItemDetail?"in":"out"
            width: parent.width*0.6
            height: parent.height
            detailLogText: getLogItemDetail(logDetailView.getTypeIndex())
            time: getLogItemDetail(1)
            isRev: getLogItemDetail(2)
            host: getLogItemDetail(3)
            length: getLogItemDetail(4)
            onDataTypeChanged: {
                logDetailView.detailLogText=getLogItemDetail(index+5)
            }
        }
    }
    GridLayout{
        columns: 4
        rows: 1
        Layout.fillWidth: true
        Layout.preferredHeight: 15
        Layout.fillHeight: false
        Label{
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.columnSpan: 1
            text: Strings.logRecv+" : "+recvC
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }

        Label{
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.columnSpan: 1
            text: Strings.logSend+" : "+sendC
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }

        Button{
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.preferredWidth: 30
            Layout.columnSpan: 1
            background: Rectangle{
                color: "#00000000"
                radius: parent.height/2
                border.width: 1
                border.color: "#37474f"

            }
            text: Strings.logClear
            onClicked: {
                showLogItemDetail.checked=false
                clearData()
            }
        }

        GeneralCheckBox{
            id: showLogItemDetail
            Layout.columnSpan: 1
            Layout.fillWidth: true
            Layout.preferredWidth: 30
            Layout.preferredHeight: 15
            text: "详细信息"
            checked: show
            onCheckedChanged: {
                if(modelList.rowCount()<=0){
                    checked=false
                }
                if(checked){
                    logDetailView.showLogItemDetail()
                }else{
                    logDetailView.hideLogItemDetail()
                }
            }
        }
    }

    Item {
        width: parent.width
        height: 10
    }

    function setCurrentIndex(index){
        logListView.currentIndex=index
    }

    function setSendMsgState(canSendMsg){
        sendView.setSendMsgState(canSendMsg)
    }

    function setErrMsg(msg){
        sendView.setErrorMsg(msg)
    }

    function showDetail(){
        showLogItemDetail.checked=!showLogItemDetail.checked
    }

    function getLogItemDetail(index){
        if(modelList.rowCount()<=0){
            return "";
        }
        var modelIndex=modelList.index(logListView.currentIndex,0)
        return modelList.data(modelIndex,index)
    }

}

