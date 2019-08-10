import QtQuick.Layouts 1.12
import QtQuick 2.12
import QtQuick.Controls 2.12
import src.strings 1.0
Dialog {
    property int defaultW: 400
    property int defaultH: 400

    modal: false
    width: defaultW
    height: defaultH
    anchors.centerIn: Overlay.overlay
    background: Rectangle {
        radius: 5
        color: "#ffffff"
    }
    header: ToolBar{
        background: Rectangle{
            color: "#00000000"
        }
        RowLayout {
            anchors.fill: parent
            //标题
            Text {
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
                text: Strings.aboutDialogTitle
                font.bold: true
                Layout.fillWidth: true
                Layout.topMargin: 10
                font.pixelSize: 20
            }
            //关闭按钮,暂不显示
            Image{
                Layout.preferredHeight: 15
                Layout.preferredWidth: 15
                Layout.fillHeight: false
                Layout.fillWidth: false
                Layout.rightMargin: 10
                Layout.topMargin: 10
                horizontalAlignment: Qt.AlignRight
                verticalAlignment: Qt.AlignHCenter
                source: "qrc:/assets/images/close_black.png"
                TapHandler{
                    onTapped: close()
                }
                visible: false
            }
        }
    }

    ColumnLayout{
        Layout.fillHeight: true
        Layout.fillWidth: true
        anchors.fill: parent
        Image{
            Layout.preferredHeight: 100
            Layout.preferredWidth: 100
            Layout.fillHeight: false
            Layout.fillWidth: false
            Layout.alignment: Qt.AlignHCenter
            source: "qrc:/assets/images/logo.png"
            TapHandler{
                onTapped: close()
            }
        }
        GridLayout {
            columns: 3
            rowSpacing: 10
            columnSpacing: 15
            Layout.leftMargin: 20
            Layout.rightMargin: 20

            Text { text: Strings.author; font.bold: true; }
            Text {
                Layout.columnSpan: 2;
                text: "<a href=\"https://juejin.im/user/5855ebea8d6d810065a4befa\">saka</a>";
                onLinkActivated:Qt.openUrlExternally(link)
                verticalAlignment: Text.AlignVCenter
                clip: true
            }
            Text { text: Strings.version; font.bold: true; }
            Text { Layout.columnSpan: 2;text: Strings.versionValue; }
            Text { text: Strings.releaseDate; font.bold: true; }
            Text { Layout.columnSpan: 2;text: Strings.releaseDateValue; }
            Text { text: Strings.source; font.bold: true }
            Text {
                Layout.columnSpan: 2
                Layout.fillWidth: true
                text: "<a href=\"https://github.com/rangaofei/SSokit-qmake\">https://github.com/rangaofei/SSokit-qmake</a>"
                verticalAlignment: Text.AlignVCenter
                clip: true
                onLinkActivated:Qt.openUrlExternally(link)
            }
        }
    }

    enter: Transition {
        NumberAnimation { property: "opacity"; from: 0.0; to:1;}
    }

    exit: Transition {
        NumberAnimation { property: "opacity"; from: 1; to: 0.0 }
    }

    function toggleAboutDialog(){
        if(visible){
            close()
        }else{
            open()
        }
    }
}
