import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.13

ColumnLayout{
    property bool checked: false
    property alias source: image.source
    property alias text: t.text
    property string checkedColor: "#ffffff"
    property string uncheckedColor: "#bdbdbd"

    //    signal checkedStatedChanged(bool checked)
    id:container
    spacing: 10
    Item {
        Layout.preferredWidth: 20
        Layout.preferredHeight: 20
        Layout.alignment: Qt.AlignHCenter
        Image{
            width: parent.width
            height: parent.height
            id:image
            visible: false
        }

        ColorOverlay{
            anchors.fill: image
            source: image
            color: checked?checkedColor:uncheckedColor
        }
    }

    Text{
        id:t
        color: checked?checkedColor:uncheckedColor
        Layout.alignment: Qt.AlignHCenter
        font.pixelSize: 12
        font.bold: true
    }
    TapHandler {
        onTapped: {
            if(checked){
                return
            }
            checked=!checked
        }
    }
}
