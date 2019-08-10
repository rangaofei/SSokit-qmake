import QtQuick 2.12
import QtQuick.Controls 2.12

TabButton {
    property int topRadius: 5
    property int bottomRadius: 5
    property double pi: 3.1415926
    font.bold: true
    background: Canvas{
        id:canvas
        width: parent.width
        height: parent.height
        onPaint: {
            var ctx = getContext("2d")
            ctx.fillStyle = checked ?  "#cfd8dc":"#37474f"
            ctx.strokeStyle = checked ?  "#00000000":"#37474f"
            ctx.lineWidth=0
            ctx.beginPath()
            ctx.moveTo(0, 0)
            ctx.arc(0,topRadius,topRadius,1.5*pi,2*pi,false) //左上角
            ctx.lineTo(topRadius,height-bottomRadius)
            ctx.arc(topRadius+bottomRadius,height-bottomRadius,bottomRadius,pi,0.5*pi,true)  //左下角
            ctx.lineTo(width-bottomRadius-topRadius,height)
            ctx.arc(width-topRadius-bottomRadius,height-bottomRadius,bottomRadius,1.5*pi,2*pi,true)
            ctx.lineTo(width-topRadius,topRadius)
            ctx.arc(width,topRadius,topRadius,pi,1.5*pi,false)
            ctx.lineTo(0,0)
            ctx.stroke()
            ctx.closePath()
            ctx.fill()
        }
    }
    onCheckedChanged: {
       canvas.requestPaint()
    }
}
