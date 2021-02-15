import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.5
import QtGraphicalEffects 1.12

import src.settingtool 1.0
import src.strings 1.0
import src.colors 1.0

Rectangle{

    property var titleStr: ""
    property var contentStr: ""
    id: box
    width: 300
    height: layout.implicitHeight+20
    state: "HIDE"
    radius: 10
    border.color: Colors.borderSecondary
    border.width: 1
    color: Colors.bgMain
    ColumnLayout{
        id:layout
        anchors.fill: parent
        anchors.topMargin: 10
        anchors.bottomMargin: 10
        anchors.leftMargin: 20
        anchors.rightMargin: 20
        Text {
            id: title
            text: titleStr
            color: Colors.textWhite
        }
        Rectangle{
            Layout.preferredHeight: 1
            Layout.preferredWidth: parent.width
            color: Colors.borderSecondary
        }
        Text {
            id: content
            text: contentStr
            color: Colors.textWhite
        }
    }
    MouseArea{
        anchors.fill: parent
        onClicked: {
            hideNotification()
        }
    }

    states: [
        State {
            name: "HIDE"
            PropertyChanges { target:box; x: -500;y: 20}
        },
        State {
            name: "SHOW"
            PropertyChanges { target:box; x: 20;y:20}
        }
    ]

    transitions: [
        Transition {
            from: "HIDE"
            to: "SHOW"
            NumberAnimation { properties: "x"; easing.type: Easing.InOutQuad }
        },
        Transition {
            from: "SHOW"
            to: "HIDE"
            NumberAnimation { properties: "x"; easing.type: Easing.InOutQuad }
        }
    ]

    Timer{
        id:countDown
        repeat: false
        interval: 3000
        running: true
        onTriggered: {
            state = "HIDE"
        }
    }

   function showNotification(title,content){
       titleStr = title
       contentStr = content
       countDown.restart()
       state = "SHOW"
   }

   function hideNotification(){
       state="HIDE"
       countDown.stop()
   }
}
