import QtQuick 2.12
import QtQuick.Controls 2.12
import src.colors 1.0
//通用的半圆形button
Button {
    property var checkedColor: "white"
    property var unCheckedColor: "black"

    id: buttonRoot
    contentItem: Text {
        text: buttonRoot.text
        font: buttonRoot.font
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
        color: !buttonRoot.enabled? Colors.disableMain : buttonRoot.checked ? checkedColor : unCheckedColor
    }

    background: Rectangle {
        opacity: enabled ? 1 : 0.3
        border.color:  Colors.main
        border.width: 1
        radius: buttonRoot.width/2
        color: parent.checked ? Colors.main : Colors.transparent
    }

}
