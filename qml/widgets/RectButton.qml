import QtQuick 2.12
import QtQuick.Controls 2.12
import src.colors 1.0
//通用的矩形button
Button {
    property var checkedColor: "white"
    property var unCheckedColor: "black"
    property var buttonRadius: 5

    id: buttonRoot
    contentItem: Text {
        text: buttonRoot.text
        font: buttonRoot.font
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
        color: getButtonTextColor()
    }

    background: Rectangle {
        opacity: enabled ? 1 : 0.3
        border.color:  Colors.main
        border.width: 1
        radius: buttonRadius
        color: getBackgroundColor()
    }

    function getButtonTextColor(){
        if(!buttonRoot.enabled){
            return Colors.disableMain
        }
        if(buttonRoot.pressed){
            return Colors.white
        }
        if(buttonRoot.checked){
           return Colors.white
        }
        return Colors.black
    }

    function getBackgroundColor(){
        if(!buttonRoot.enabled){
            return Colors.transparent
        }
        if(buttonRoot.pressed){
            return Colors.main
        }
        if(buttonRoot.checked){
           return Colors.main
        }
        return Colors.transparent
    }

}
