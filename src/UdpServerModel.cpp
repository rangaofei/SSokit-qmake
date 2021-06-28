//
// Created by 冉高飞 on 2019-02-24.
//

#include "SoundManager.h"
#include "UdpServerModel.h"
#include "toolkit.h"

UdpServerModel::UdpServerModel() = default;

UdpServerModel::~UdpServerModel() {
    qDebug()<<"~UdpServerModel()";
    closeServer();
};

bool UdpServerModel::openServer(QString &addr, quint16 port) {
    QHostAddress hostAddress(addr);
    if (m_udp_server.bind(hostAddress, port, QUdpSocket::ShareAddress)) {
        connect(&m_udp_server, SIGNAL(readyRead()), this, SLOT(newData()));
        connect(&m_udp_server, SIGNAL(error(QAbstractSocket::SocketError)), this, SLOT(error()));
        connect(&m_timer, SIGNAL(timeout()), this, SLOT(check()));
        m_timer.start(2000);
        qDebug()<<"启动成功";
        emit sendErrMsg(START_ERR, QString("start success"), false);
        return true;
    } else {
        qDebug() << QString("%1, %2").arg(m_udp_server.error()).arg(m_udp_server.errorString());
        emit sendErrMsg(START_ERR, QString("%1").arg(m_udp_server.errorString()),true);
        return false;
    }

}

bool UdpServerModel::close() {
    m_udp_server.close();
    m_udp_server.disconnect(this);
    m_timer.stop();
    m_timer.disconnect(this);
    return false;
}

void UdpServerModel::check() {
    QStringList list;
    getKeys(list);

    while (!list.isEmpty()) {
        QString k = list.takeFirst();

        void *c = getCookie(k);

        if (c && (((Conn *) c)->stamp.addSecs(120) < QDateTime::currentDateTime())) {
            close(c);
            unsetCookie(k);
        }
    }
}

void UdpServerModel::newData() {
    QUdpSocket *s = qobject_cast<QUdpSocket *>(sender());
    if (!s) return;

    qint64 bufLen = s->pendingDatagramSize();
    if (bufLen < 0) {
        qDebug() << "there is no available data";
    }
    char *buf = TK::createBuffer(bufLen, MAXBUFFER);
    if (!buf) return;

    QHostAddress addr;
    quint16 port(0);

    qint64 readLen = 0;
    qint64 ioLen = s->readDatagram(buf, bufLen, &addr, &port);

    readLen += ioLen;


    if (ioLen >= 0) {
        Conn *conn = (Conn *) getCookie(TK::ipstr(addr, port));
        if (!conn) {
            conn = new Conn;
            conn->key = TK::ipstr(addr, port);
            conn->addr = addr;
            conn->port = port;
            setCookie(conn->key, conn);
        }
        conn->stamp = QDateTime::currentDateTime();
//        dump(buf, readLen, false, conn->key);
        SoundManager::playReceiveMsgSound();
        dumpLogMsg(true, conn->key, buf, readLen);
    }
//    TK::releaseBuffer(buf);
}

bool UdpServerModel::close(void *cookie) {
    qDebug() << "关闭连接 " << ((Conn *) cookie)->key;
    delete (Conn *) cookie;

    return true;
}

void UdpServerModel::error() {
    QUdpSocket *s = qobject_cast<QUdpSocket *>(sender());

    qDebug() << QString("UDP socket error %1, %2").arg(s->error()).arg(s->errorString());
    emit sendErrMsg(3, QString("UDP socket error %1, %2").arg(s->error()).arg(s->errorString()),true);
}

void UdpServerModel::sendToDst(void *cookie, const QByteArray &bin) {
    Conn *conn = (Conn *) cookie;
    qint64 srcLen = bin.length();
    char * src=TK::createBuffer(srcLen,MAXBUFFER);
    qDebug()<<bin<<"+++++"<<src;
    memcpy(src,bin.data(),srcLen);
    qint64 writeLen = 0;
    qint64 ioLen = m_udp_server.writeDatagram(src, srcLen, conn->addr, conn->port);

    while (ioLen > 0) {
        writeLen += ioLen;

        ioLen = (writeLen >= srcLen) ? 0 :
                m_udp_server.writeDatagram(src + writeLen, srcLen - writeLen, conn->addr, conn->port);
    }

    if (writeLen != srcLen) {
        qDebug() << (QString("failed to send data to %1:%2 [%3]")
                .arg(conn->addr.toString()).arg(conn->port).arg(writeLen));
        emit sendErrMsg(2, (QString("failed to send data to %1:%2 [%3]")
                .arg(conn->addr.toString()).arg(conn->port).arg(writeLen)),true);
        return;
    }
    SoundManager::playSendMsgSound();
    dumpLogMsg(false, conn->key, src, writeLen);
}


