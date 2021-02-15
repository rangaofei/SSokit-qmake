import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import src.strings 1.0
import src.settingtool 1.0

Dialog {
    property int defaultW: 400
    property int defaultH: 400

    property var newVersion:""
    property var content:""
    property var downloadUrl:""
    property var date:""

    id:dialog

    modal: true
    width: defaultW
    height: defaultH
    anchors.centerIn: Overlay.overlay
    background: Rectangle {
        radius: 5
        color: "#ffffff"
    }
    ColumnLayout{
        Layout.fillHeight: true
        Layout.fillWidth: true
        anchors.fill: parent
        Text {
            Layout.alignment: Qt.AlignHCenter
            font.pixelSize: 20
            font.bold: true
            text: Strings.newVersionTitle
        }
        Image{
            Layout.preferredHeight: 100
            Layout.preferredWidth: 100
            Layout.alignment: Qt.AlignHCenter
            source: "qrc:/assets/images/ic_update.png"
            TapHandler{
                onTapped: close()
            }
        }
        Text {
            Layout.fillWidth: true
            Layout.leftMargin: 20
            Layout.rightMargin: 20
            text: content
            wrapMode: Text.Wrap
            verticalAlignment: Text.AlignVCenter
            clip: true
            font.pixelSize: 15

        }

        GridLayout {
            columns: 3
            rowSpacing: 10
            columnSpacing: 15
            Layout.leftMargin: 20
            Layout.rightMargin: 20


            Text { text: Strings.newVersion; font.bold: true; }
            Text { Layout.columnSpan: 2;text:newVersion; }
            Text { text: Strings.releaseDate; font.bold: true; }
            Text { Layout.columnSpan: 2;text:date; }
        }


        Button{
            text: Strings.download
            Layout.alignment: Qt.AlignCenter
            Layout.fillWidth: true
            Layout.leftMargin: 50
            Layout.rightMargin: 50
            topPadding: 5
            bottomPadding: 5
            onClicked: Qt.openUrlExternally(downloadUrl)
            background: Rectangle {
                opacity: enabled ? 1 : 0.3
                border.color:  "#37474f"
                border.width: 1
                radius: width/2
                color: parent.checked?"#37474f":"#00ffffff"
            }
        }

    }

    enter: Transition {
        NumberAnimation { property: "opacity"; from: 0.0; to:1;}
    }

    exit: Transition {
        NumberAnimation { property: "opacity"; from: 1; to: 0.0 }
    }

    function toggleUpdateDialog(){
        if(visible){
            close()
        }else{
            open()
        }
    }
    function showDialog(newVersion,contentCN,contentEN,releaseDate,downloadUrl,force){
        dialog.newVersion=newVersion
        dialog.content=SettingTool.getLanguage()===1?contentCN:contentEN
        dialog.downloadUrl=downloadUrl
        dialog.date=releaseDate

        if(force){
            dialog.closePolicy=Popup.NoAutoClose
        }
        dialog.open()
    }
}

