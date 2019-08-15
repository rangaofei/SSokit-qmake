pragma Singleton

import QtQuick 2.12

QtObject {

    //程序名称
    property var applicationTitle: qsTr("SSokit")
    property var headerServer: qsTr("Server")
    property var headerClient: qsTr("Client")
    property var headerTransfer:qsTr("Transfer")

    //主页底部按钮
    property var mainTabTcp: qsTr("TCP")
    property var mainTabUdp: qsTr("UDP")
    property var mainTabNotePad: qsTr("NotePad")
    property var mainTabWebSocket: qsTr("WebSocket")
    property var mainTabBlueTooth: qsTr("BlueTooth")
    property var mainTabCOM: qsTr("COM")

    //AboutDialog和AboutSettingView
    property var aboutDialogTitle: qsTr("About SSokit")
    property var author: qsTr("Author")
    property var version: qsTr("Version")
    property var versionValue: qsTr("1.0.6 - Base On Qt5.13.0")
    property var releaseDate: qsTr("ReleaseDate")
    property var releaseDateValue: "2019.8.15"
    property var source: qsTr("Source")

    //SettingView
    property var setting: qsTr("Setting")

    //GeneralSettingView
    property var settingGeneral: qsTr("General")
    property var settingFunction: qsTr("Function")
    property var settingShortCut: qsTr("ShortCut")
    property var settingAbout: qsTr("About")
    property var settingLanguage: qsTr("Language")
    property var settingLanguageValues: [qsTr("English"),qsTr("Chinese")]
    property var settingLanguageTip: qsTr("Effective after restart")
    property var settingRememberPort: qsTr("RememberPort")
    property var settingWindow: qsTr("Window")
    property var settingRememberPos: qsTr("Remember Window Position")
    property var settingRememberSize: qsTr("Remember Window Size")

    //ShortCutSettingView
    property var settingSwtichTab: qsTr("SwitchTab")

    //LogView
    property var logRecv: qsTr("Recv")
    property var logSend: qsTr("Send")
    property var logClear: qsTr("Clear")
    property var logTime:qsTr("Time")
    property var logIP: qsTr("IP")
    property var logLength: qsTr("Length")

    //SendView
    property var send: qsTr("Send")
    property var sendBuf1: qsTr("Buf1")
    property var sendBuf2: qsTr("Buf2")
    property var sendBuf3: qsTr("Buf3")
    property var sendAdvance: qsTr("Advance")

    //ServerControlView
    property var controlCenter: qsTr("ControlCenter")
    property var controlAddr: qsTr("ADDR")
    property var controlPort: qsTr("PORT")
    property var controlConnect: qsTr("Connect")
    property var controlTime: qsTr("Time")
    property var controlDisconnect: qsTr("Disconnect")
    property var controlDisable: qsTr("Disable")
    property var controlPortTip: qsTr("Port must be between 1024-63365")

    //SocketHeaderView
    property var header: qsTr("Header")
    property var tailer: qsTr("Tailer")
    property var headerLengthType: qsTr("Length")
    property var headerLengthValue: [qsTr("None"),qsTr("Short"),qsTr("Int")]
    property var headerEndian: qsTr("Endian")
    property var headerEndianValue: [qsTr("Big"),qsTr("Little")]
    property var headerEnable: qsTr("Enable")
}
