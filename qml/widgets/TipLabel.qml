import QtQuick 2.0
import QtQuick.Controls 2.5
Item{
    property bool err: false
    property string msg: ""
    Label{
        id:label
        anchors.centerIn: parent
        horizontalAlignment: Text.AlignHCenter
        visible: true
        color:err ? "red" : "black"
        text: msg
    }
    Timer {
        id:timer
        interval: 2000
        repeat: false
        onTriggered: {
            msg=""
        }
    }


    function setState(isErr,message){
        err=isErr
        msg=message
        timer.stop()
        timer.start()
    }
}
