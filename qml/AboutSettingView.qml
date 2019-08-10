import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import src.strings 1.0

Item {
    ColumnLayout{
        anchors.fill: parent
        Image{
            Layout.preferredHeight: 130
            Layout.preferredWidth: 130
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
}
