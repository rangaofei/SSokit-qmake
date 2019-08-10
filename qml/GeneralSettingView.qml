import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import src.strings 1.0

Item{
    anchors.fill:parent
    anchors.topMargin: 50

    RowLayout{
        id:layout_language
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        Text {
            Layout.fillWidth: true
            Layout.maximumWidth: parent.width/3
            id: language
            text: Strings.settingLanguage
        }
        EditComboBox {
            id:language_box
            editable: false
            Layout.fillWidth: true
            Layout.maximumHeight: parent.width*2/3
            currentIndex:settingTool.getLanguage()
            model: ListModel {
                id: model
                Component.onCompleted: {
                    append({ text: Strings.settingLanguageValues[0] })
                    append({ text: Strings.settingLanguageValues[1] })
                }
            }
            onActivated: {
                settingTool.setLanguage(index)
            }
        }
    }
    RowLayout{
        id:layout_language_tip
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.topMargin: 10
        anchors.top: layout_language.bottom
        Item {
            Layout.alignment: Qt.AlignVCenter
            Layout.maximumWidth: parent.width/3
            Layout.fillWidth: true
            //                        Image{
            //                            width: 15
            //                            height: 15
            //                            anchors.right: parent.right
            //                            source: "qrc:/assets/images/about.png"
            //                        }
        }
        Item {

            Layout.alignment: Qt.AlignHCenter|Qt.AlignRight
            Layout.maximumWidth: parent.width*2/3
            Layout.fillWidth: true
            Text{
                text: Strings.settingLanguageTip
                font.bold: false
                font.pixelSize: 10
                color: "#000000"
            }
        }
    }

    Rectangle{
        id:divider1
        anchors.top: layout_language_tip.bottom
        anchors.topMargin: 20
        anchors.left: parent.left
        anchors.right: parent.right
        height:1
        color: "#bdbdbd"
    }
    RowLayout{
        id:layout_port
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: divider1.bottom
        anchors.topMargin: 20
        visible: false
        Text {
            Layout.fillWidth: true
            Layout.maximumWidth: parent.width/3
            id: port
            text: Strings.settingRememberPort
        }
        CheckBox{
        }
    }
}
