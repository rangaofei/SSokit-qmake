import QtQuick 2.0
import QtQuick.Controls 2.12

Switch {
    property color checkedColor: "#0ACF97"
    property color uncheckedColor: "#D5D5D5"
    property var swidth:40
    property var sheight: 20

    id: switchRoot

    indicator: Rectangle{
        width: swidth
        height: sheight
        radius: height/2
        color: switchRoot.checked?checkedColor:uncheckedColor
        border.width: 2
        border.color: switchRoot.checked?checkedColor:"#E5E5E5"

        Rectangle{
            x: switchRoot.checked?parent.width-width-2:2
            width: switchRoot.checked?parent.height-4:parent.height-4
            height: width
            radius: width/2
            anchors.verticalCenter: parent.verticalCenter
            color: "white"
            border.color: "#D5D5D5"

            Behavior on x {
                NumberAnimation {duration: 200}
            }
        }
    }

}
