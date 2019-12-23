import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import src.jsonformat 1.0

RowLayout {
    ScrollView {
        id: view
        Layout.fillWidth: true
        Layout.fillHeight: true
        TextArea{
            cursorVisible: true
            id: originData
            wrapMode: Text.Wrap
            text: qsTr("")
            placeholderText: "请输入json数据"
            selectByMouse: true
            selectedTextColor: "white"
            selectionColor: "#3399FF"
            font.pixelSize: 15
        }
    }


    function formattedJson( formattedJsonData){
        originData.clear()
        originData.append(formattedJsonData)
    }
    function getText(){
        return originData.text.toString()
    }

}
