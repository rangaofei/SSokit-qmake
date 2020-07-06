import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import src.jsonformat 1.0

RowLayout {
    GroupBox{
        Layout.fillWidth: true
        Layout.fillHeight: true
        Layout.leftMargin: 20
        Layout.rightMargin: 20
        Layout.topMargin: 10
        Layout.bottomMargin: 10
        background: Rectangle{
            color: "white"
            radius: 10
        }
        ScrollView {
            id: view
            clip: true
            anchors.fill: parent
            Row{
                ColumnLayout{
                    Layout.fillHeight: true
                    Repeater{
                        model: originData.lineCount
                        Text {
                            id: lineNumer
                            text: qsTr(index+1+"")
                            font.pointSize: 15
                        }
                    }

                }
                TextArea{
//                    Layout.fillHeight: true
//                    Layout.fillWidth: true
                    cursorVisible: true
                    id: originData
                    wrapMode: Text.Wrap
                    text: qsTr("")
                    placeholderText: "请输入json数据"
                    selectByMouse: true
                    selectedTextColor: "white"
                    selectionColor: "#3399FF"
                    font.pointSize: 15
                }
            }
        }
    }

    function formattedJson( formattedJsonData){
        originData.text=formattedJsonData
    }

    function getText(){
        return originData.text.toString()
    }

}
