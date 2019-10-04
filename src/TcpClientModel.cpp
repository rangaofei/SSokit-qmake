//
// Created by saka on 2019-02-28.
//

#include "TcpClientModel.h"
#include "toolkit.h"

bool TcpClientModel::openClient(QString &addr, quint16 port) {
    qDebug("begin to connect %s : %d",addr.toStdString().data(),port);
    connect(&m_tcp_socket, SIGNAL(readyRead()), this, SLOT(newData()));
    connect(&m_tcp_socket, SIGNAL(disconnected()), this, SLOT(closed()));
    connect(&m_tcp_socket, SIGNAL(connected()), this, SLOT(asynConn()));
    connect(&m_tcp_socket, SIGNAL(error(QAbstractSocket::SocketError)), this, SLOT(error()));
    connect(&m_tcp_socket, SIGNAL(stateChanged(QAbstractSocket::SocketState)), this,SLOT(stateChanged(QAbstractSocket::SocketState)));
    host = TK::ipstr(QHostAddress(addr), port);
    m_tcp_socket.connectToHost(addr, port);
    if (m_tcp_socket.waitForConnected(1000*10))
    {
        qDebug("Connected!");
    }
    else
        qDebug("error !");
    return true;
}

bool TcpClientModel::close() {
    host.clear();
    m_tcp_socket.close();
    m_tcp_socket.disconnect(this);
    return true;
}

void TcpClientModel::sendToDst(const QByteArray &bin) {
    const char *src = bin.constData();
    qint64 srcLen = bin.length();
    qDebug()<<"send tcp client data::"<<bin;
    qint64 writeLen = 0;
    qint64 ioLen = m_tcp_socket.write(src, srcLen);

    while (ioLen > 0) {
        writeLen += ioLen;
        ioLen = m_tcp_socket.write(src + writeLen, srcLen - writeLen);
    }

    if (writeLen != srcLen) {
        qDebug() << "send data failed!";
        emit sendErrMsg(SEND_ERR, "Send data failed", true);
        return;
    }

    dumpLogMsg(false, host, src, writeLen);

}

void TcpClientModel::asynConn() {
    qDebug() << "connect success";
    emit appendConnAddr(host);
}

void TcpClientModel::newData() {

    QTcpSocket *s = qobject_cast<QTcpSocket *>(sender());
    if (!s) return;

    qint64 bufLen = s->bytesAvailable();
    char *buf = TK::createBuffer(bufLen, MAXBUFFER);
    if (!buf) return;

    qint64 readLen = 0;
    qint64 ioLen = s->read(buf, bufLen);

    while (ioLen > 0) {
        readLen += ioLen;
        ioLen = s->read(buf + readLen, bufLen - readLen);
    }

    if (ioLen >= 0) {
        dumpLogMsg(true, host, buf, readLen);
    }

//    TK::releaseBuffer(buf);
}

void TcpClientModel::closed() {
    qDebug() << (QString("TCP connection closed!"));
    closeClient();
}

void TcpClientModel::error() {
    QTcpSocket *s = qobject_cast<QTcpSocket *>(sender());
    qDebug() << (QString("TCP socket error %1, %2").arg(s->error()).arg(s->errorString()));
    sendErrMsg(CLOSE_ERR, s->errorString(), true);
    closeClient();
}

void TcpClientModel::stateChanged(QAbstractSocket::SocketState state) {
    QString result;
    switch (state) {
    case QAbstractSocket::UnconnectedState:
        result = "UnconnectedState";
        break;
    case QAbstractSocket::HostLookupState:
        result = "HostLookupState";
        break;
    case QAbstractSocket::ConnectingState:
        result = "ConnectingState";
        break;
    case QAbstractSocket::ConnectedState:
        result = "ConnectedState";
        break;
    case QAbstractSocket::BoundState:
        result = "BoundState";
        break;
    case QAbstractSocket::ListeningState:
        result = "ListeningState";
        break;
    case QAbstractSocket::ClosingState:
        result = "ClosingState";
        break;
    }
    qDebug() << "TCP STATE CHANGED " + result;

}
