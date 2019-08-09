import QtQuick 2.0
import QtWebSockets 1.1

Item {
    WebSocket{
        active: true
        url:"ws://121.40.165.18:8800"
        onBinaryMessageReceived: {
            console.log("binary message:"+message)
        }
        onTextMessageReceived: {
            console.log("text message:"+message)
        }

        onStatusChanged: {
            console.log("status change :"+status)
        }
    }

}
