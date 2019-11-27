import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import src.settingtool 1.0
import src.strings 1.0

import "./widget" as Widget

Item {
    anchors.fill:parent
    anchors.topMargin: 50
    GroupBox{
        id:layout_window
        anchors.topMargin: 20
        implicitWidth: parent.width
        background: Rectangle{
            color: "#00000000"
        }
        ColumnLayout{
            anchors.left: parent.left
            anchors.right: parent.right
            GeneralCheckBox{
                Layout.alignment: Qt.AlignRight
                 text: Strings.settingEnableHovver
                checked: SettingTool.getEnableLogHover()
                onCheckStateChanged: {
                    SettingTool.setEnableLogHover(checked)
                }

            }
            Widget.SwitchButton{
                Layout.alignment: Qt.AlignRight
                text: Strings.settingShowClear
                checked: SettingTool.getShowSendClear()

                onCheckedChanged: {
                    SettingTool.setShowSendClear(checked)
                }

            }
            Rectangle{
                Layout.topMargin: 20
                Layout.fillWidth: true
                Layout.preferredHeight:1
                color: "#bdbdbd"
            }

            GeneralCheckBox{
                Layout.alignment: Qt.AlignRight
                text: Strings.settingEnableReceiveSound
                checked: SettingTool.getEnableReceiveSound()
                onCheckStateChanged: {
                    SettingTool.setEnableReceiveSound(checked)
                }
            }
            GeneralCheckBox{
                Layout.alignment: Qt.AlignRight
                text: Strings.settingEnableSendSound
                checked: SettingTool.getEnableSendSound()
                onCheckStateChanged: {
                    SettingTool.setEnableSendSound(checked)
                }
            }
            GeneralCheckBox{
                Layout.alignment: Qt.AlignRight
                text: Strings.settingEnableSound
                checked: SettingTool.getEnableSysSound()
                onCheckStateChanged: {
                    SettingTool.setEnableSysSound(checked)
                }
            }
        }
    }
}
