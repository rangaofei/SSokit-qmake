import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
Item {
    ColumnLayout{
        Layout.fillHeight: true
        Layout.fillWidth: true
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

            Text { text: qsTr("Author"); font.bold: true; }
            Text {
                Layout.columnSpan: 2;
                text: "<a href=\"https://juejin.im/user/5855ebea8d6d810065a4befa\">saka</a>";
                onLinkActivated:Qt.openUrlExternally(link)
                verticalAlignment: Text.AlignVCenter
                clip: true
            }
            Text { text: qsTr("Version"); font.bold: true; }
            Text { Layout.columnSpan: 2;text: qsTr("1.0.4 - Base On Qt5.13.0"); }
            Text { text: qsTr("ReleaseDate"); font.bold: true; }
            Text { Layout.columnSpan: 2;text: "2019.8.6"; }
            Text { text: qsTr("Source"); font.bold: true }
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
