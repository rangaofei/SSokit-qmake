import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import src.jsonformat 1.0

import "../widgets" as Widgets


ColumnLayout{
    JsonFormat{
        id:jsonFormat
    }
    TabBar {
        id: tabBar
        width: parent.width
        currentIndex: contentLayout.currentIndex
        Layout.alignment: Qt.AlignHCenter
        Widgets.TopButton {
            name:"格式化"
        }
        Widgets.TopButton{
            name:"视图"
        }

    }
    StackLayout{
        id:contentLayout

        currentIndex: tabBar.currentIndex
        JsonFormatView{
            id:jsonFormatView
        }
        JsonTreeView{
            jsonModel: jsonFormat.jsonModel
        }
    }
    RowLayout{
        Layout.preferredHeight: 50
        Layout.leftMargin: 20
        Layout.rightMargin: 20

        Button{
            text: "格式化"
            background: Rectangle {
                implicitWidth: 100
                implicitHeight: 40
                opacity: enabled ? 1 : 0.3
                border.color: "#37474f"
                border.width: 1
                radius: parent.width/2
                color: "transparent"
            }
            onClicked: {
                formattedClick()
            }
        }
        Text{
            font.pixelSize: 15
            color: "red"
            id:errTxt
        }
    }

    Shortcut{
        sequences: ["Ctrl+F"]
        onActivated: {
            formattedClick()
        }

    }

    function formattedClick(){

        var json=jsonFormatView.getText()
        if(json===null||json===""){
            errTxt.text="请填写需要格式化的内容"
            return
        }
        jsonFormat.checkJonsStr(json)
        jsonFormat.convertJsonToTreeModel(json)
    }


    function formattedError(errMsg){
        errTxt.text=errMsg
    }

    Component.onCompleted: {
        jsonFormat.formattedJson.connect(jsonFormatView.formattedJson)
        jsonFormat.formattedError.connect(formattedError)
    }

    Component.onDestruction: {
        jsonFormat.formattedJson.disconnect(jsonFormatView.formattedJson)
        jsonFormat.formattedError.disconnect(formattedError)

    }

}
