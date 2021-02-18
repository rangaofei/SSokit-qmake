import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.5
import QtGraphicalEffects 1.12

import src.settingtool 1.0
import src.strings 1.0
import src.colors 1.0

import "../widgets" as Widgets

Column {
    //1-tcpserver,2-tcpclient,3-udpserver,4-udpclient
    property int viewType: 1
    //标题
    property string title: Strings.controlCenter
    //地址标签
    property string labelAddr: Strings.controlAddr
    //端口标签
    property string labelPort: Strings.controlPort
    //连接标签
    property string btnConnect: Strings.controlConnect
    //断开连接标签
    property string btnDisconnect: Strings.controlDisconnect
    //连接不可用标签
    property string btnDisable: Strings.controlDisable
    //端口提示
    property string portTip: Strings.controlPortTip
    //连接时间
    property string labelTime: Strings.controlTime
    //窗口宽度
    property int windowW: 250
    property int windowH:parent.height

    //开启/关闭连接
    signal startConnect(bool checked,string addr,string port)
    //断开指定ip的连接
    signal disconnectConn(string addr)
    //当前连接状态
    signal connectState(bool state)

    //端口列表，存储在本地文件
    ListModel{
        id:portListModel
    }

    id: column
    width: windowW
    height: windowH

    GroupBox{
        id:groupBox
        width: parent.width
        background: Widgets.BgStrokeR5{
        }
//标题
        label: Label{
            x: groupBox.leftPadding
            width: groupBox.availableWidth
            text: title
            color: "black"
            font.bold: true
            topPadding: 10
            font.pixelSize:14
            elide: Text.ElideRight
        }

        ColumnLayout{
            width:parent.width
            //IP地址
            RowLayout{
                Layout.fillWidth: true
                Layout.preferredHeight: 30
                Label{
                    Layout.preferredWidth: 50
                    text: labelAddr
                    font.bold: true
                }
                Widgets.EditComboBox{
                    id:addrBox
                    Layout.fillWidth: true
                    Layout.preferredHeight: 30
                    editable: viewType===2||viewType===4
                    textRole:"addr"
                    enabled: !toggleConnect.checked
                    model: ListModel{ id:addrListModel }
                }
            }
            //空白占位
            Item {
                height: 10
            }
            //端口
            RowLayout{
                Layout.fillWidth: true
                Layout.preferredHeight: 30
                Label{
                    Layout.preferredWidth: 50
                    text:labelPort
                    font.bold: true
                }
                Widgets.EditComboBox{
                    id:portBox
                    Layout.fillWidth: true
                    Layout.preferredHeight: 30
                    editable: true
                    textRole:"port"
                    enabled: !toggleConnect.checked
                    model: portListModel
                    validate: IntValidator{
                        top:65535
                        bottom:0
                    }
                    maxLength:5
                }

            }


            Item {
                height: 10
            }

            Button {
                id: toggleConnect
                Layout.preferredHeight: 30
                Layout.fillWidth: true
                Layout.leftMargin: 20
                Layout.rightMargin: 20
                text: checked?btnDisconnect:btnConnect
                checkable: true
                contentItem: Text {
                    text: toggleConnect.text
                    font: toggleConnect.font
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    elide: Text.ElideRight
                    color: toggleConnect.checked?"white":"black"
                }

                background: Rectangle {
                    opacity: enabled ? 1 : 0.3
                    border.color:  "#37474f"
                    border.width: 1
                    radius: toggleConnect.width/2
                    color: parent.checked?"#37474f":"#00ffffff"
                }

                onToggled: {
                    if(!isAccectablePort(portBox.getEditText())){
                        toggleConnect.checked=false
                        showMsg(viewType,portTip)
                        return
                    }
                    startConnect(checked,addrBox.editText,portBox.editText)
                    connectState(historyConnect.count>0&&checked)
                    if(!checked){
                        return
                    }
                    for(var j=0;j<portListModel.count;j++){
                        var p=portListModel.get(j).port;
                        if(p===portBox.editText){
                            return;
                        }
                    }
                    portListModel.append({"port":portBox.editText})
                    portBox.currentIndex=portListModel.count-1
                    var ports=[];
                    for(var i=0;i<portListModel.count;i++){
                        ports.push(portListModel.get(i).port)
                    }
                    SettingTool.savePorts(viewType,ports)
                }
            }
        }
    }
    Item{
        height: 20
        width: parent.width
    }

    Component {
        id: contactDelegate
        ItemDelegate {
            width: connectList.width
            height: c.implicitHeight
            Column {
                id: c
                anchors.verticalCenter: parent.verticalCenter
                anchors.topMargin: 5
                anchors.bottomMargin: 5
                Text {
                    x:10
                    verticalAlignment: Text.AlignVCenter
                    height: 20
                    text:addr
                    font.pixelSize: 13
                    color:parent.parent.highlighted ? "white" : "black"
                }
                Text {
                    x:10
                    verticalAlignment: Text.AlignVCenter
                    height: 20
                    font.pixelSize: 10
                    color:parent.parent.highlighted ? "#cfd8dc" : "#424242"
                    text: labelTime + " : " + time
                }
//                RowLayout{
//                    width:parent.width
//                    Button{
//                        width: parent.width*0.5
////                        height: 20
//                        text: btnDisable
//                        font.pixelSize: 10
//                        background: Rectangle{
//                            color: "#FFFFFF"
//                            border.color:"#37474f"
//                            border.width: 1
//                            radius: parent.height/2
//                        }

//                        onClicked:{
////                            if(connectList.currentIndex<0){
////                                console.log("当前无连接")
////                                return
////                            }
////                            disconnectConn(historyConnect.get(connectList.currentIndex).addr)
//                        }
//                    }
//                    Button{
//                        width: parent.width*0.5
////                        height: 20
//                        text: btnDisable
//                        font.pixelSize: 10
//                        background: Rectangle{
//                            color: "#FFFFFF"
//                            border.color:"#37474f"
//                            border.width: 1
//                            radius: parent.height/2
//                        }

//                        onClicked:{
////                            if(connectList.currentIndex<0){
////                                console.log("当前无连接")
////                                return
////                            }
////                            disconnectConn(historyConnect.get(connectList.currentIndex).addr)
//                        }
//                    }
//                }

            }
            background: Rectangle{
                color:highlighted?"#37474f":"#00000000"
                radius: 4
            }
            highlighted: connectList.currentIndex==index
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    connectList.currentIndex=index
                }
            }
        }
    }


    ListView {
        id:connectList
        visible: true
        width: parent.width
        height: parent.height-260
        clip:true
        model: ListModel {
            id:historyConnect
        }
        delegate: contactDelegate
        focus: true
    }

    //作为服务端时断开某个连接按钮
    Rectangle{
        width: parent.width
        height: 30
        visible: viewType===1||viewType===3
        color: "#00000000"
        Button{
            anchors.centerIn: parent
            width: parent.width*0.5
            height: 30
            text: btnDisable
            background: Rectangle{
                color: "#00000000"
                border.color:"#37474f"
                border.width: 1
                radius: parent.height/2
            }

            onClicked:{
                if(connectList.currentIndex<0){
                    console.log("当前无连接")
                    return
                }
                disconnectConn(historyConnect.get(connectList.currentIndex).addr)
            }
        }
    }

    Component.onCompleted: {
        initPortView()
    }

    //检测端口是否在可用范围内
    function isAccectablePort(port){
        if(port > 1024 && port < 65535){
            return true
        }
        return false
    }

    function appendLocalAddr(msg){
        addrListModel.append({addr:msg})
        addrBox.currentIndex=0
    }

    function appendHistoryConnect(msg){
        historyConnect.append({time:(new Date().toLocaleString(Qt.locale("de_DE"),"yyyy-MM-dd hh:mm:ss")),addr:msg})
        connectState(historyConnect.count>0&&toggleConnect.checked)
    }


    function connClose(addr){
        console.log("Server Contorl View close "+addr)
        for(var i=historyConnect.count-1;i>=0;i--){
            if(addr===historyConnect.get(i).addr){
                historyConnect.remove(i)}
        }
        connectState(historyConnect.count>0&&toggleConnect.checked)
    }

    function getCurrentConn(){
        if(!toggleConnect.checked){
            console.log("当前无连接")
            return
        }

        if(connectList.currentIndex<0){
            console.log("index  is smaller than 0")
            return
        }
        return historyConnect.get(connectList.currentIndex).addr
    }

    //初始化端口view
    function initPortView(){
        var ports=SettingTool.getPorts(viewType)
        for(var i=0;i<ports.length;i++){
            portListModel.append({port:ports[i]})
        }
        portBox.currentIndex=0
    }

    function setErrMsg(type,msg,isErr){
        if(type===1){
            toggleConnect.checked=!isErr
        }else if(type===2){
            toggleConnect.checked=false
        }
        showMsg(type,msg)
    }

    function showMsg(type,msg){
        var title = "TCPServer"
        if(viewType==1){
            title = "TCPServer"
        }else if(viewType==2){
            title = "TCPClient"
        }else if(viewType ==3){
            title = "UDPServer"
        }else if(viewType==4){
            title = "UDPClient"
        }
        showNotification(title,msg)
    }
}
