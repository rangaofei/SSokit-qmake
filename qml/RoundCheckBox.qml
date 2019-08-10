import QtQuick 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.13

CheckBox {
    property bool showText: false

    id: control
    checked: false

    background: Rectangle{
        border.color: enabled?"#37474f":"#cfd8dc"
        color: checked?"37474f":"transparent"
        border.width: 1
        radius: parent.height/2
    }

    indicator:Item{
        anchors.centerIn: parent
        Image {
            id:image
            width: 15
            height: 15
            anchors.centerIn: parent
            source:"qrc:/assets/images/checked.png"
            visible: control.checked
        }
        ColorOverlay{
            anchors.fill: image
            source: image
            color: "#ffffff"
        }
    }

    contentItem: Text {
        visible: showText
        text: control.text
        font: control.font
        opacity: enabled ? 1.0 : 0.3
        color: control.down ? "#17a81a" : "#21be2b"
        verticalAlignment: Text.AlignVCenter
        leftPadding: control.indicator.width + control.spacing
    }
}
