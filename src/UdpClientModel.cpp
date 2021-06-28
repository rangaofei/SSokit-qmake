//
// Created by saka on 2019-02-28.
//

#include "SoundManager.h"
#include "UdpClientModel.h"
#include "toolkit.h"

#include <QThread>

bool UdpClientModel::openClient(QString &addr, quint16 port) {
    qDebug("begin to connect %s : %d",addr.toStdString().data(),port);
    connect(&m_udp_socket, SIGNAL(readyRead()), this, SLOT(newData()));
    connect(&m_udp_socket, SIGNAL(disconnected()), this, SLOT(closed()));
    connect(&m_udp_socket, SIGNAL(connected()), this, SLOT(asynConn()));
    connect(&m_udp_socket, SIGNAL(error(QAbstractSocket::SocketError)), this, SLOT(error()));
    connect(&m_udp_socket, SIGNAL(stateChanged(QAbstractSocket::SocketState)), this,
            SLOT(stateChanged(QAbstractSocket::SocketState)));
    host = TK::ipstr(QHostAddress(addr), port);
    m_udp_socket.connectToHost(QHostAddress(addr),port);
    if (m_udp_socket.waitForConnected(1000))
        qDebug("Connected!");
    else
        qDebug("error !");
    return true;
}

bool UdpClientModel::close() {
    host.clear();
    m_udp_socket.close();
    m_udp_socket.disconnect(this);
    return true;
}

void UdpClientModel::sendToDst(const QByteArray &bin) {
    if (m_udp_socket.errorString() != nullptr)
        qDebug() << "发送udp发生错误+++" << m_udp_socket.error();
    qint64 srcLen = bin.length();
    char * src=TK::createBuffer(srcLen,MAXBUFFER);
    qDebug()<<bin<<"+++++"<<src;
    memcpy(src,bin.data(),srcLen);
    qint64 writeLen = 0;
    qint64 ioLen = m_udp_socket.write(src, srcLen);
    qDebug()<<m_udp_socket.peerAddress()<<"---"<<m_udp_socket.peerPort();
    while (ioLen > 0) {
        writeLen += ioLen;
        ioLen = (writeLen >= srcLen) ? 0 :
                m_udp_socket.write(src+writeLen, srcLen-writeLen);
    }

    if (writeLen != srcLen) {
        qDebug() << "send data failed!";
        sendErrMsg(SEND_ERR,"Send data error",true);
        return;
    }
    SoundManager::playSendMsgSound();
    dumpLogMsg(false, host, src, writeLen);

}

void UdpClientModel::asynConn() {
    qDebug() << "connect success";
    emit appendConnAddr(host);
}

void UdpClientModel::newData() {
    QUdpSocket *s = qobject_cast<QUdpSocket *>(sender());
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
        SoundManager::playReceiveMsgSound();
        dumpLogMsg(true, host, QByteArray::fromRawData(buf,readLen), readLen);
    }

//    TK::releaseBuffer(buf);
}

void UdpClientModel::closed() {
    qDebug() << "UDP connection closed!";
    closeClient();
}

void UdpClientModel::error() {
    QUdpSocket *s = qobject_cast<QUdpSocket *>(sender());
    qDebug() << QString("UDP socket error %1, %2").arg(s->error()).arg(s->errorString());
    sendErrMsg(CLOSE_ERR, s->errorString(), true);
    closeClient();
}

void UdpClientModel::stateChanged(QAbstractSocket::SocketState state) {
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
    qDebug() << "UDP STATE CHANGED " + result;

}
