import QtQuick 2.0

import QtQuick.Layouts 1.3

Item{
    GridLayout{
        width: parent.width
        height: implicitHeight
        anchors.top: parent.top
        anchors.topMargin: 50
        columns: 3
        Text {
            Layout.columnSpan: 1
            text: qsTr("Switch tab")
        }
        Text {
            Layout.columnSpan: 1
            text: qsTr("shift+tab")
        }
    }
}
