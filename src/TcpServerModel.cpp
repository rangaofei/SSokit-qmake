//
// Created by 冉高飞 on 2019-02-24.
//

#include <QTcpSocket>
#include "SoundManager.h"
#include "TcpServerModel.h"
#include "toolkit.h"


TcpServerModel::TcpServerModel() {

}

TcpServerModel::~TcpServerModel() {
    closeServer();
}

bool TcpServerModel::openServer(QString &addr, quint16 port) {
    QHostAddress hostAddress(addr);
    if (m_tcp_server.listen(hostAddress, port)) {
        connect(&m_tcp_server, SIGNAL(newConnection()), this, SLOT(newConnection()));
        qDebug() << "开启成功";
        emit sendErrMsg(START_ERR, QString("start success"), false);
        return true;
    } else {
        qDebug() << (QString("%1, %2").arg(m_tcp_server.serverError()).arg(m_tcp_server.errorString()));
        emit sendErrMsg(START_ERR, QString("%1").arg(m_tcp_server.errorString()), true);
        return false;
    }
}

bool TcpServerModel::close() {
    qDebug()<<"关闭 tcp 服务器";
    m_tcp_server.close();
    m_tcp_server.disconnect(this);
    if (m_tcp_server.errorString() != nullptr)
        qDebug() << "关闭失败" << m_tcp_server.errorString();
    return true;

}

bool TcpServerModel::close(void *cookie) {
    Conn *conn = (Conn *) cookie;

    if (conn->client)
        conn->client->disconnect(this);

    delete conn->client;
    delete conn;

    return true;
}

void TcpServerModel::sendToDst(void *cookie, const QByteArray &bin) {
    Conn *conn = (Conn *) cookie;
    qint64 srcLen = bin.length();
    char * src=TK::createBuffer(srcLen,MAXBUFFER);
    qDebug()<<bin<<"+++++"<<src;
    memcpy(src,bin.data(),srcLen);
    qint64 writeLen = 0;
    qint64 ioLen = conn->client->write(src, srcLen);

    while (ioLen > 0) {
        writeLen += ioLen;
        ioLen = conn->client->write(src + writeLen, srcLen - writeLen);
    }

    if (writeLen != srcLen) {
//        show(QString("failed to send data to %1:%2 [%3]")
//                     .arg(addr().toString()).arg(port()).arg(writeLen));
        emit sendErrMsg(SEND_ERR, "failed to send data to", false);
        return;
    }

//    recordSend(writeLen);
//    dump(src, srcLen, true, conn->key);
    SoundManager::playSendMsgSound();
    dumpLogMsg(false, conn->key, src, writeLen);
}

void TcpServerModel::error() {
    QTcpSocket *s = qobject_cast<QTcpSocket *>(sender());
    emit sendErrMsg(RECV_ERR, QString("TCP socket error %1, %2").arg(s->error()).arg(s->errorString()), true);
    s->deleteLater();
}

void TcpServerModel::newConnection() {
    QTcpServer *server = qobject_cast<QTcpServer *>(sender());
    if (!server) return;

    QTcpSocket *client = server->nextPendingConnection();
    while (client) {
        Conn *conn = new Conn;
        if (!conn) {
            client->deleteLater();
        } else {
            client->setProperty(PROP_CONN, qVariantFromValue((void *) conn));

            conn->client = client;
            conn->key = TK::ipstr(client->peerAddress(), client->peerPort());

            connect(client, SIGNAL(readyRead()), this, SLOT(newData()));
            connect(client, SIGNAL(destroyed(QObject * )), this, SLOT(close(QObject * )));
            connect(client, SIGNAL(disconnected()), client, SLOT(deleteLater()));
            connect(client, SIGNAL(error(QAbstractSocket::SocketError)), this, SLOT(error()));

            setCookie(conn->key, conn);
        }
        client = server->nextPendingConnection();
    }

}

void TcpServerModel::close(QObject *obj) {
    Conn *conn = (Conn *) obj->property(PROP_CONN).value<void *>();
    if (!conn) return;

    unsetCookie(conn->key);
    delete conn;
}

void TcpServerModel::newData() {
    QTcpSocket *client = qobject_cast<QTcpSocket *>(sender());
    if (!client) return;

    Conn *conn = (Conn *) client->property(PROP_CONN).value<void *>();
    if (!conn) return;

    qint64 bufLen = client->bytesAvailable();
    char *buf = TK::createBuffer(bufLen, MAXBUFFER);
    if (!buf) return;

    qint64 readLen = 0;
    qint64 ioLen = client->read(buf, bufLen);

    while (ioLen > 0) {
        readLen += ioLen;
        ioLen = client->read(buf + readLen, bufLen - readLen);
    }

    if (ioLen >= 0) {
//        recordRecv(readLen);
//        dump(buf, readLen, false, conn->key);
        SoundManager::playReceiveMsgSound();
        dumpLogMsg(true, conn->key, buf, readLen);
    }

//    TK::releaseBuffer(buf);

}



