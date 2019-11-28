import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import src.settingtool 1.0
import src.strings 1.0

import "../components" as Components


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


            Components.SwitchLayout{
                text: Strings.settingEnableHovver
                checked: SettingTool.getEnableLogHover()
                onSwitchCheckedChanged: {
                    SettingTool.setEnableLogHover(checked)
                }

            }

            Rectangle{
                Layout.fillWidth: true
                Layout.leftMargin: 30
                Layout.preferredHeight:1
                color: "#bdbdbd"
            }


            Components.SwitchLayout{
                text: Strings.settingShowClear
                checked: SettingTool.getShowSendClear()

                onSwitchCheckedChanged: {
                    SettingTool.setShowSendClear(checked)
                }
            }


            Rectangle{
                Layout.topMargin: 20
                Layout.fillWidth: true
                Layout.preferredHeight:1
                color: "#bdbdbd"
            }


            Components.SwitchLayout{
                text: Strings.settingEnableReceiveSound
                checked: SettingTool.getEnableReceiveSound()
                onSwitchCheckedChanged: {
                    SettingTool.setEnableReceiveSound(checked)
                }
            }

            Rectangle{
                Layout.fillWidth: true
                Layout.leftMargin: 30
                Layout.preferredHeight:1
                color: "#bdbdbd"
            }


            Components.SwitchLayout{
                text: Strings.settingEnableSendSound
                checked: SettingTool.getEnableSendSound()
                onSwitchCheckedChanged: {
                    SettingTool.setEnableSendSound(checked)
                }
            }

            Rectangle{
                Layout.fillWidth: true
                Layout.leftMargin: 30
                Layout.preferredHeight:1
                color: "#bdbdbd"
            }


            Components.SwitchLayout{
                text: Strings.settingEnableSound
                checked: SettingTool.getEnableSysSound()
                onSwitchCheckedChanged: {
                    SettingTool.setEnableSysSound(checked)
                }
            }
        }
    }
}
