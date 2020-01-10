import QtQuick 2.0
import QtQuick.Controls 1.4

Item {
    property var treeModel
    TreeView{
        model: treeModel
        itemDelegate: TextTreeItemDelegate{}
    }

}
