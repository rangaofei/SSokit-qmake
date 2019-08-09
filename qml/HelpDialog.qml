import QtQuick 2.12
import QtQuick.Controls 2.12

Dialog {
    id:helpdialog
    property bool showing: false
    modal: true
    width: 440
    height: 400
    padding: 0
    anchors.centerIn: Overlay.overlay
    background: Rectangle {
        radius: 5
        gradient: Gradient{
            GradientStop { position: 0.0; color: "#ffffff" }
            GradientStop { position: 1.0; color: "#cfd8dc" }
        }
    }

    header: ToolBar{
        id:header
        background: Rectangle{
            color: "#00000000"
        }
        topPadding: 5
        bottomPadding: 5
        Text {
            anchors.centerIn: parent
            text: qsTr("SSokit Help")
            font.bold: true
        }
    }

    contentItem:ScrollView{
        id: scrollView
        anchors.top:header.bottom
        height:parent.height-implicitHeaderHeight
        width: parent.width
        rightPadding: 10
        leftPadding: 10
        contentWidth: 400
        enabled: true
        ScrollBar.vertical: ScrollBar { id: scrollBar
            policy:ScrollBar.AlwaysOff}
        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
        clip: true
        Text {
            id:help
            width: parent.width
            height: implicitHeight
            wrapMode:Text.WordWrap
            textFormat:Text.RichText
            text: '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0//EN" "http://www.w3.org/TR/REC-html40/strict.dtd">
                      <html><head><meta name="qrichtext" content="1" /><style type="text/css">
                      p, li { white-space: pre-wrap; }
                      </style></head><body style=" font-family:".SF NS Text""; font-size:13pt; font-weight:400; font-style:normal;">
                      <p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-weight:600;">sokit</span></p>
                      <p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><br /></p>
                      <p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;">freeware version: 1.3.1 (GPLv3)</p>
                      <p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;">website: https://github.com/sinpolib/sokit/</p>
                      <p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;">email: sinpowei@gmail.com</p>
                      <p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><br /></p>
                      <p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;">this is a TCP / UDP package send &amp; receive &amp; transfer tool</p>
                      <p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><br /></p>
                      <p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><br /></p>
                      <p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;">--------------------------------------------------------------</p>
                      <p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><br /></p>
                      <p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-weight:600;">Send buffer syntax:</span></p>
                      <p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><br /></p>
                      <p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;">all characters in a send buf is traited  as it is (or UTF8 for multibyte char) , if you want send a hexdecimal characters, you should put those sub string in [ ], etc, [FF AB CD 12 12], space and [ ] will be trimmed when send out. (double [[ for a normal [ character)</p>
                      <p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><br /></p>
                      <p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-weight:600;">Keyboard Shortcuts:</span></p>
                      <p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; font-weight:600;"><br /></p>
                      <p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-weight:600;">F1</span>	show/hide this window</p>
                      <p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-weight:600;">F10</span>	set/unset main windows at top of desktop</p>
                      <p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><br /></p>
                      <p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-weight:600;">Esc</span>	focus on first input control</p>
                      <p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-weight:600;">F2</span>	focus on connects list (if exist)</p>
                      <p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-weight:600;">F3</span>	focus on logs list</p>
                      <p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-weight:600;">F4</span>	focus on logs entry details</p>
                      <p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><br /></p>
                      <p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-weight:600;">Alt-0</span>	focus on data in buf 0 (if exist)</p>
                      <p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-weight:600;">Alt-1</span>	focus on data in buf 1</p>
                      <p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-weight:600;">Alt-2</span>	focus on data in buf 2</p>
                      <p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-weight:600;">Alt-3</span>	focus on data in buf 3</p>
                      <p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><br /></p>
                      <p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-weight:600;">Ctr-Shf-1</span>	focus on data in dir-combobox 1 (if exist)</p>
                      <p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-weight:600;">Ctr-Shf-2</span>	focus on data in dir-combobox 2 (if exist)</p>
                      <p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-weight:600;">Ctr-Shf-3</span>	focus on data in dir-combobox 3 (if exist)</p>
                      <p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><br /></p>
                      <p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-weight:600;">Ctrl-0</span>	send data in buf 0 (if exist)</p>
                      <p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-weight:600;">Ctrl-1</span>	send data in buf 1</p>
                      <p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-weight:600;">Ctrl-2</span>	send data in buf 2</p>
                      <p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-weight:600;">Ctrl-3</span>	send data in buf 3</p>
                      <p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><br /></p>
                      <p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-weight:600;">Ctrl-T</span>	trig TCP button or combobox</p>
                      <p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-weight:600;">Ctrl-U</span>	trig UDP button or combobox</p>
                      <p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-weight:600;">Ctrl-S</span>	trig START button</p>
                      <p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><br /></p>
                      <p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-weight:600;">F5</span>	trig dir-combobox 1 (if exist)</p>
                      <p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-weight:600;">F6</span>	trig dir-combobox 2 (if exist)</p>
                      <p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-weight:600;">F7</span>	trig dir-combobox 3 (if exist)</p>
                      <p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><br /></p>
                      <p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-weight:600;">Ctrl-W</span>	trig write log to file</p>
                      <p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-weight:600;">Ctrl-D</span>	clear log window</p>
                      <p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><br /></p>
                      <p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-weight:600;">Alt-A</span>	select all connects (if exist)</p>
                      <p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-weight:600;">Ctrl-K</span>	kill all selected connects (if exist)</p>
                      <p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><br /></p>
                      <p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-weight:600;">Ctrl-A</span>	select all in current input control</p>
                      <p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-weight:600;">Ctrl-C</span>	copy selected content in current input control</p>
                      <p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-weight:600;">Ctrl-V</span>	paste into current input control</p>
                      <p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-weight:600;">Ctrl-X</span>	cut&amp;copy selected content in current input control</p>
                      <p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><br /></p></body></html>'
            fontSizeMode: Text.Fit
            transformOrigin: Item.Center
            elide: Text.ElideNone
            clip: true
        }
    }

    enter: Transition {
        NumberAnimation { property: "height"; from: 0.0; to: helpdialog.width ;}
        NumberAnimation { property: "opacity"; from: 0.0; to:1;}
    }

    exit: Transition {
        NumberAnimation { property: "height"; from: helpdialog.width; to: 0 ;}
        NumberAnimation { property: "opacity"; from: 1; to: 0.0 }
    }


    Shortcut{
        sequence: StandardKey.MoveToPreviousLine
        onActivated: {
            scrollBar.decrease()
        }
    }
    Shortcut{
        sequence: StandardKey.MoveToNextLine
        onActivated: {
            scrollBar.increase()
        }
    }

    function toggleDialog(){
        if(showing){
            close()
        }else{
            open()
        }
    }

    onOpened: {
        width=440
        height=400
        showing=true
    }

    onClosed: {
        width=440
        height=400
        showing=false
    }

}
