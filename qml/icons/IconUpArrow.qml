import QtQuick 2.12

Canvas {
    property bool hightlighted:false
    width: 20
    height: 10
    onPaint: {
        var ctx = getContext("2d");
        ctx.strokeStyle = hightlighted ? "#03a9f4" : "#00bcd4";
        ctx.lineWidth=2;
        ctx.lineCap="round";
        ctx.beginPath();
        ctx.moveTo(5,height/2);
        ctx.lineTo(10,1);
        ctx.lineTo(15,height/2);
        ctx.moveTo(10,1);
        ctx.lineTo(10,height);
        ctx.stroke();
    }
}
