import QtQuick 2.12

Canvas {
    property bool hightlighted:false
    width: 20
    height: 10
    onPaint: {
        var ctx = getContext("2d");
        ctx.strokeStyle = hightlighted ? "#8bc34a" : "#009688";
        ctx.lineWidth=2;
        ctx.lineCap="round";
        ctx.beginPath();
        ctx.moveTo(5,height/2);
        ctx.lineTo(10,height-1);
        ctx.lineTo(15,height/2);
        ctx.moveTo(10,0);
        ctx.lineTo(10,height-1);
        ctx.stroke();
    }
}
