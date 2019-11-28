import QtQuick 2.12

Canvas {
    property string enableColor: "#37474f"
    property string disableColor: "#bdbdbd"
    property bool enabled: true
    width: 12
    height: 8
    contextType: "2d"

    onPaint: {
        var context=getContext("2d")
        context.reset();
        context.moveTo(0, 0);
        context.lineTo(width, 0);
        context.lineTo(width / 2, height);
        context.closePath();
        context.fillStyle = enabled ?enableColor :disableColor ;
        context.fill();
    }
}
