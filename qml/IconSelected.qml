import QtQuick 2.12

Canvas {
    property string color: "#37474f"
    width: 20
    height: 20
    onPaint: {
        var ctx = getContext("2d");
        ctx.strokeStyle = color;
        ctx.fillStyle = "#00000000"
        ctx.lineWidth=2;
        ctx.lineCap="round";
        ctx.beginPath();
        ctx.moveTo(5,10);
        ctx.lineTo(9,15);
        ctx.lineTo(15,5);
        ctx.stroke();
    }
}
