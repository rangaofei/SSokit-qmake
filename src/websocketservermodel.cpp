#include "websocketservermodel.h"

WebSocketServerModel::WebSocketServerModel():m_websocket_server("Server",QWebSocketServer::NonSecureMode,nullptr)
{

}

void WebSocketServerModel::sendToDst(void *cookie, const QByteArray &bin){

    Conn *conn = (Conn *) cookie;

    const char *src = bin.constData();
    qint64 srcLen = bin.length();

    qint64 writeLen = 0;
//    qint64 ioLen = conn->client->write(src, srcLen);

//    while (ioLen > 0) {
//        writeLen += ioLen;
//        ioLen = conn->client->write(src + writeLen, srcLen - writeLen);
//    }

    if (writeLen != srcLen) {
//        show(QString("failed to send data to %1:%2 [%3]")
//                     .arg(addr().toString()).arg(port()).arg(writeLen));
        emit sendErrMsg(SEND_ERR, "failed to send data to", false);
        return;
    }

//    recordSend(writeLen);
//    dump(src, srcLen, true, conn->key);
    dumpLogMsg(false, conn->key, src, writeLen);
}


bool WebSocketServerModel::openServer(QString &addr,quint16 port){
    QHostAddress hostAddress(addr);
    if (m_websocket_server.listen(hostAddress, port)) {
        connect(&m_websocket_server, SIGNAL(newConnection()), this, SLOT(newConnection()));
        qDebug() << "开启成功";
        emit sendErrMsg(START_ERR, QString("start success"), false);
        return true;
    } else {
        qDebug() << (QString("%1, %2").arg(m_websocket_server.error()).arg(m_websocket_server.errorString()));
        emit sendErrMsg(START_ERR, QString("%1").arg(m_websocket_server.errorString()), true);
        return false;
    }
}

bool WebSocketServerModel::close(){
    m_websocket_server.close();
    m_websocket_server.disconnect(this);
    if (m_websocket_server.errorString() != nullptr)
        qDebug() << "关闭失败" << m_websocket_server.errorString();
    return true;

}

void WebSocketServerModel:: newConnection(){

}

void WebSocketServerModel:: newData(){

}


void WebSocketServerModel:: error(){

}

void WebSocketServerModel:: close(QObject *obj){
    Q_UNUSED(obj)
}

bool WebSocketServerModel::close(void *cookie){
    Conn *conn = (Conn *) cookie;

    if (conn->client)
        conn->client->disconnect(this);

    delete conn->client;
    delete conn;

    return true;
}
