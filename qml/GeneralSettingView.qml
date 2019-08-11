import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import src.strings 1.0

Item{
    anchors.fill:parent
    anchors.topMargin: 50
    GroupBox{
        id:layout_language
        title: Strings.settingLanguage
        implicitWidth: parent.width
        background: Rectangle{
            color: "#00000000"
        }
        ColumnLayout{

            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right

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
            RowLayout{
                Layout.alignment: Qt.AlignRight
                Image{
                    Layout.preferredWidth: 12
                    Layout.preferredHeight: 12
                    source: "qrc:/assets/images/about.png"
                }
                Text{
                    text: Strings.settingLanguageTip
                    font.bold: false
                    font.pixelSize: 10
                    color: "#000000"
                }
            }
            Rectangle{
                Layout.topMargin: 20
                Layout.fillWidth: true
                Layout.preferredHeight:1
                color: "#bdbdbd"
            }
        }
    }

    GroupBox{
        id:layout_window
        anchors.top: layout_language.bottom
        anchors.topMargin: 20
        implicitWidth: parent.width
        background: Rectangle{
            color: "#00000000"
        }
        title: "Window"
        ColumnLayout{
            anchors.left: parent.left
            anchors.right: parent.right
            GeneralCheckBox{
                text: "记住窗口位置"
            }
            GeneralCheckBox{
                text: "记住窗口大小"
            }
            Rectangle{
                Layout.topMargin: 20
                Layout.fillWidth: true
                Layout.preferredHeight:1
                color: "#bdbdbd"
            }
        }
    }
}
