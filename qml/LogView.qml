import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

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
        Layout.preferredHeight:150
        Layout.fillWidth: true
        canSendMsg: canSendMsg
        onSendMsg: {
            console.log("logview sendMsg")
            logView.sendMsg(msg)
        }
        onSendMsgWithHeader: {
            console.log("logview sendMsgWithHeader")
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

            text: qsTr("Recv : ")+recvC
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }

        Label{
            Layout.fillWidth: true
            Layout.fillHeight: true
            text: qsTr("Send : ")+sendC
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
            text: qsTr("Clear")
            onClicked: clearData()
        }
    }
    Component{
        id:listViewItem
        ItemDelegate{
            id:delegate
            width: parent.width
            height: 50
            background: Rectangle{
                color: delegate.highlighted?"#37474f":"#00000000"
                radius:4
            }
            onHighlightedChanged: {
                downArrow.requestPaint()
                upArrow.requestPaint()
            }

            highlighted: logListView.currentIndex==index
            Column{
                width:parent.width
                spacing: 5
                Row{
                    leftPadding: 10
                    rightPadding: 10
                    width:parent.width
                    topPadding: 5
                    IconUpArrow{
                        id:upArrow
                        y:5
                        hightlighted: delegate.highlighted
                        visible: !isRev
                    }
                    IconDownArrow{
                        id:downArrow
                        y:5
                        hightlighted: delegate.highlighted
                        visible:isRev}
                    Text {
                        width: 50
                        height: 20
                        verticalAlignment: Text.AlignVCenter
                        maximumLineCount: 1
                        textFormat: Text.PlainText
                        clip :true
                        wrapMode: Text.NoWrap
                        color:delegate.highlighted?"white":"#37474f"
                        text: qsTr("Time:")
                    }
                    Text {
                        height: 20
                        text: time
                        width: 100
                        elide: Text.ElideRight
                        verticalAlignment: Text.AlignVCenter
                        maximumLineCount: 1
                        textFormat: Text.PlainText
                        clip :true
                        wrapMode: Text.NoWrap
                        color:delegate.highlighted?"white":"#37474f"

                    }
                    Text {
                        height: 20
                        width: 50
                        verticalAlignment: Text.AlignVCenter

                        maximumLineCount: 1
                        textFormat: Text.PlainText
                        clip :true
                        wrapMode: Text.NoWrap
                        color:delegate.highlighted?"white":"#37474f"
                        text: qsTr("Ip:")
                        rightPadding: 10
                    }
                    Text {
                        width: 140
                        height: 20
                        text: host
                        elide: Text.ElideRight
                        verticalAlignment: Text.AlignVCenter
                        maximumLineCount: 1
                        textFormat: Text.PlainText
                        clip :true
                        wrapMode: Text.NoWrap
                        color:delegate.highlighted?"white":"#37474f"

                    }
                    Text {
                        height: 20
                        width: 50
                        verticalAlignment: Text.AlignVCenter

                        maximumLineCount: 1
                        textFormat: Text.PlainText
                        clip :true
                        wrapMode: Text.NoWrap
                        color:delegate.highlighted?"white":"#37474f"
                        text: qsTr("Length:")
                        rightPadding: 10
                    }
                    Text {
                        height: 20
                        text: length
                        elide: Text.ElideRight
                        verticalAlignment: Text.AlignVCenter
                        maximumLineCount: 1
                        textFormat: Text.PlainText
                        clip :true
                        wrapMode: Text.NoWrap
                        color:delegate.highlighted?"white":"#37474f"

                    }
                }

                Row{
                    width:parent.width
                    leftPadding: 10
                    rightPadding: 10
                    //                    Text {
                    //                        text:qsTr("HEXDATA")
                    //                    }
                    Text {
                        width: parent.width
                        height: 20
                        text: hexData
                        elide: Text.ElideRight
                        maximumLineCount: 1
                        textFormat: Text.PlainText
                        clip :true
                        wrapMode: Text.NoWrap
                        color:delegate.highlighted?"white":"#37474f"
                    }
                }


                //                Rectangle{
                //                    height: 1
                //                    width: parent.width
                //                    color: "#bdbdbd"
                //                }
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    logListView.currentIndex=index
                }
            }
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
        console.log("LogView: ascData="+ascData)
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

