import QtQuick 2.12
import QtQuick.Layouts 1.12
Rectangle{
    color: "#cfd8dc"
    RowLayout {
        SideButton{
            id:singleCast
            text: "单播"
        }
        SideButton{
            //        Layout.: singleCast.bottom
            id:broadCast
            text: "广播"
        }
        SideButton{
            //        Layout.top: broadCast.bottom
            id:multiCast
            text: "组播"
        }
    }
}
