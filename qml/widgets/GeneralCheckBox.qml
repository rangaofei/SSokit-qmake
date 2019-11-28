import QtQuick 2.12
import QtQuick.Controls 2.12
import src.colors 1.0

CheckBox {
    id: control
    property var cbChecked: Colors.cbChecked
    property var cbUnChecked: Colors.cbUnChecked
    property var cbWidth: 14
    property var cbHeight: 14
    indicator: Rectangle {
        implicitWidth: cbWidth
        implicitHeight: cbHeight
        x: control.leftPadding
        y: parent.height / 2 - height / 2
        radius: 3
        border.color: Colors.cbBorder
        color: control.checked?cbChecked:cbUnChecked
        Canvas{
            anchors.fill: parent;
            anchors.margins: 3;
            visible: control.checked;
            onPaint: {
                var ctx = getContext("2d");
                ctx.save();
                ctx.strokeStyle = "white";
                ctx.lineWidth = 2;
                ctx.lineCap="round";
                ctx.beginPath();
                ctx.moveTo(2,5);
                ctx.lineTo(4,7);
                ctx.lineTo(7,2);
                ctx.stroke();
            }
        }
    }
    contentItem: Text {
        text: control.text
        font: control.font
        opacity: enabled ? 1.0 : 0.5
        color: control.checked ? cbChecked : cbChecked
        verticalAlignment: Text.AlignVCenter
        leftPadding: control.indicator.width + control.spacing
    }
}
