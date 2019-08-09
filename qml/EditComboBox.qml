import QtQuick 2.12
import QtQuick.Controls 2.12

ComboBox {
    property int maxLength: 32767
    property var validate
    id: control
    rightPadding: 10
    delegate: ItemDelegate {
        width: control.width
        height: 30
        contentItem: Text {
            rightPadding: control.indicator.width + control.spacing+15
            text: modelData
            color: parent.highlighted?"white":"black"
            font.bold: control.currentIndex === index
            elide: Text.ElideRight
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignRight
        }
        indicator:IconSelected{
            id:selectIndic
            x: 5
            y: (parent.height-20)/2
            visible:control.currentIndex === index
            color: parent.highlighted?"white":"black"
            Connections{
                target: control
                onHighlighted: selectIndic.requestPaint()
            }
        }
        highlighted: control.highlightedIndex === index
        background: Rectangle{
            color: control.highlightedIndex === index?"#37474f":"#eceff1"
        }
    }

    indicator: IconTriangle {
        id: canvas
        x: control.width - width - control.rightPadding
        y: control.topPadding + (control.availableHeight - height) / 2

        Connections {
            target: control
            onEnabledChanged:{
                canvas.enabled=control.enabled
                canvas.requestPaint()
            }
        }
    }

    contentItem: TextField {
        id:editText
        readOnly: !parent.editable
        x:0
        anchors.right: parent.right
        anchors.rightMargin: control.indicator.width + control.spacing+10+control.rightPadding
        width:control.availableWidth-control.indicator.width-control.spacing-10
        leftPadding: 0
        text: control.displayText
        font: control.font
        color: control.enabled ? "black" : "#bdbdbd"
        verticalAlignment: TextInput.AlignVCenter
        horizontalAlignment: TextInput.AlignRight
        maximumLength: maxLength
        selectByMouse:true
        background: Rectangle {
            color: editText.enabled ? "transparent" : "#00ffffff"
            border.color: editText.enabled ? "#00ffffff" : "transparent"
        }
    }


    background: Rectangle {
        color: "#00000000"
        border.color: "#bdbdbd"
        border.width: 1
        radius: 3
    }

    popup: Popup {
        y: control.height + 3
        width: control.width
        implicitHeight: contentItem.implicitHeight
        padding: 1

        contentItem: ListView {
            clip: true
            implicitHeight: contentHeight
            model: control.popup.visible ? control.delegateModel : null
            currentIndex: control.highlightedIndex
            ScrollIndicator.vertical: ScrollIndicator { }
        }

        background: Rectangle {
            border.color: "#bdbdbd"
            radius: 3
        }
    }

    function getEditText(){
        return editText.text
    }
}
