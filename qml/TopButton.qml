import QtQuick 2.0
import QtQuick.Controls 2.5

TabButton {
    property var name
    width: implicitWidth

    contentItem: Label {
        text: name
        color: "black"
        font.bold:true
        verticalAlignment: Text.AlignVCenter
    }
    background: Rectangle {
        width: parent.width
        height: parent.implicitHeight
        opacity: enabled ? 1 : 0.3
        color: checked ? "#22000000":"#00000000"
        radius: 5
    }
}
