import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12

import src.notepadmodel 1.0
import src.strings 1.0
import src.sqlitetool 1.0
import src.notebook 1.0

ColumnLayout{
    Layout.fillWidth: true
    Layout.fillHeight: true
    NoteBook{
        id:noteBook
    }

    TabBar {
        id:notepadTopBar
        Layout.fillWidth: false
        Layout.preferredHeight: title.height
        Layout.topMargin: 15
        currentIndex: 0
        Layout.alignment: Qt.AlignHCenter
        TopButton {
            id:title
            name:Strings.mainTabNotePad
        }
    }
    RowLayout{
        spacing: 0
        Rectangle{
            Layout.fillHeight: true
            Layout.fillWidth: false
            Layout.preferredWidth: 200
            gradient: Gradient {
                GradientStop { position: 0.0; color: "#ffffff" }
                GradientStop { position: 1.0; color: "#cfd8dc" }
            }
            ListView{
                id:titleListView
                anchors.top: parent.top
                anchors.bottom: control.top
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottomMargin: 10
                orientation: ListView.Vertical
                clip: true
                spacing: 2
                model: SqliteTool.notes
                delegate: itemDelegate
                focus: true
                onCurrentIndexChanged: {
                    //                detail.text=model.count>0 ? model.get(logListView.currentIndex).ascData : ""
                }
            }
            RowLayout{
                id:control
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                anchors.margins: 10
                Image {
                    Layout.preferredWidth: 20
                    Layout.preferredHeight: 20
                    Layout.alignment: Qt.AlignRight|Qt.AlignBottom
                    Layout.rightMargin: 10
                    Layout.bottomMargin: 10
                    id: addNote
                    source: "qrc:/assets/images/add.png"
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            SqliteTool.addNewData()
                            edit_layout.visible=titleListView.currentIndex>=0
                        }
                    }
                }
                Image {
                    Layout.preferredWidth: 20
                    Layout.preferredHeight: 20
                    Layout.alignment: Qt.AlignRight|Qt.AlignBottom
                    Layout.rightMargin: 10
                    Layout.bottomMargin: 10
                    id: deleteNote
                    source: "qrc:/assets/images/delete.png"
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            SqliteTool.deleteData(titleListView.model[titleListView.currentIndex])
                            edit_layout.visible=titleListView.currentIndex>=0
                        }
                    }
                }
            }
        }
        Rectangle{
            Layout.fillHeight: true
            Layout.preferredWidth: 1
            color: "#cfd8dc"
        }
        Rectangle {
            Layout.fillHeight:true
            Layout.fillWidth: true
            ColumnLayout{
                id:edit_layout
                width: parent.width-10
                height: parent.height-10
                visible: titleListView.currentIndex>=0
                TextArea {
                    Layout.fillWidth: true
                    font.pointSize: 20
                    text: titleListView.model.length<=0?"":titleListView.model[titleListView.currentIndex].title
                    onTextChanged: {
                        if(titleListView.currentIndex==-1){
                            return
                        }
                        titleListView.model[titleListView.currentIndex].title=text
                    }

                }
                Rectangle{
                    Layout.fillWidth: true
                    Layout.preferredHeight: 2
                    color: "#cfd8dc"
                }
                RowLayout{
                    Layout.fillWidth: true
                    Layout.leftMargin: 20
                    Layout.rightMargin: 20
                    Image {
                        id: save
                        source: "qrc:/assets/images/save.png"
                        Layout.preferredHeight: 20
                        Layout.preferredWidth: 20
                        Layout.rightMargin: 10
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                if(titleListView.currentIndex<0){
                                    return
                                }
                                SqliteTool.updateData(titleListView.model[titleListView.currentIndex])
                            }
                        }
                    }

                    Image {
                        id: clear
                        source: "qrc:/assets/images/clear.png"
                        Layout.preferredHeight: 20
                        Layout.preferredWidth: 20
                        Layout.leftMargin: 10
                        Layout.rightMargin: 10
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                tv_content.clear()
                            }
                        }
                    }
                }

                Rectangle{
                    Layout.fillWidth: true
                    Layout.preferredHeight: 2
                    color: "#cfd8dc"
                }

                TextArea{
                    id: tv_content
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    focus: true
                    font.pointSize: 15
                    text: titleListView.model.length<=0?"":titleListView.model[titleListView.currentIndex].content

                    onTextChanged: {
                        titleListView.model[titleListView.currentIndex].content=text
                    }
                }

            }
            gradient: Gradient {
                GradientStop { position: 0.0; color: "#ffffff" }
                GradientStop { position: 1.0; color: "#cfd8dc" }
            }
        }
    }

    Component{
        id:itemDelegate
        ItemDelegate{
            id:delegate
            height: 50
            width: parent.width
            background: Rectangle{
                color: delegate.highlighted?"#37474f":"#00000000"
                radius:0
            }
            onClicked: {
                titleListView.currentIndex=index
            }
            highlighted: titleListView.currentIndex===index
            ColumnLayout{
                anchors.fill: parent
                anchors.leftMargin: 10
                anchors.rightMargin: 10
                Text {
                    id:text_title
                    Layout.preferredHeight: 20
                    Layout.fillWidth: true
                    text: title
                    font.pointSize: 15
                    elide: Text.ElideRight
                    verticalAlignment: Text.AlignVCenter
                    maximumLineCount: 1
                    textFormat: Text.PlainText
                    clip :true
                    wrapMode: Text.NoWrap
                    color:delegate.highlighted?"white":"#37474f"
                }
                Text {
                    Layout.preferredHeight: 15
                    Layout.fillWidth: true
                    text: updateAt
                    elide: Text.ElideRight
                    verticalAlignment: Text.AlignVCenter
                    maximumLineCount: 1
                    textFormat: Text.PlainText
                    clip :true
                    font.pointSize: 10
                    wrapMode: Text.NoWrap
                    color:delegate.highlighted?"white":"#37474f"
                }
            }

        }
    }
}
