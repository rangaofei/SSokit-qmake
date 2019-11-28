#include "BroadcastModel.h"
#include "SoundManager.h"

BroadcastModel::BroadcastModel(QObject *parent) : ServerModel(parent)
{

}

BroadcastModel::~BroadcastModel()
{
    qDebug()<<"~UdpServerModel()";
    closeServer();
}

bool BroadcastModel::openServer(QString &addr, quint16 port)
{
    Q_UNUSED(addr)
    if (m_udp_scoket.bind( port, QUdpSocket::ShareAddress)) {
        connect(&m_udp_scoket, SIGNAL(readyRead()), this, SLOT(newData()));
        connect(&m_udp_scoket, SIGNAL(error(QAbstractSocket::SocketError)), this, SLOT(error()));
        connect(&m_timer, SIGNAL(timeout()), this, SLOT(check()));
        m_timer.start(2000);
        qDebug()<<"启动成功";
        emit sendErrMsg(START_ERR, QString("start success"), false);
        return true;
    } else {
        qDebug() << QString("%1, %2").arg(m_udp_scoket.error()).arg(m_udp_scoket.errorString());
        emit sendErrMsg(START_ERR, QString("%1").arg(m_udp_scoket.errorString()),true);
        return false;
    }

}

bool BroadcastModel::close()
{
    m_udp_scoket.close();
    m_udp_scoket.disconnect(this);
    m_timer.stop();
    m_timer.disconnect(this);
    return false;
}

bool BroadcastModel::close(void *cookie)
{
    qDebug() << "关闭连接 " << ((Conn *) cookie)->key;
    delete (Conn *) cookie;

    return true;
}

void BroadcastModel::sendToDst(void *cookie, const QByteArray &bin)
{
    Conn *conn = (Conn *) cookie;

    const char *src = bin.constData();
    qint64 srcLen = bin.length();

    qint64 writeLen = 0;
    qint64 ioLen = m_udp_scoket.writeDatagram(src, srcLen, QHostAddress::Broadcast, 1235);

    while (ioLen > 0) {
        writeLen += ioLen;

        ioLen = (writeLen >= srcLen) ? 0 :
                m_udp_scoket.writeDatagram(src + writeLen, srcLen - writeLen, conn->addr, conn->port);
    }

    if (writeLen != srcLen) {
        qDebug() << (QString("failed to send data to %1:%2 [%3]")
                .arg(conn->addr.toString()).arg(conn->port).arg(writeLen));
        emit sendErrMsg(2, (QString("failed to send data to %1:%2 [%3]")
                .arg(conn->addr.toString()).arg(conn->port).arg(writeLen)),true);
        return;
    }
    SoundManager::playSend();
    dumpLogMsg(false, conn->key, src, writeLen);
}

void BroadcastModel::newData()
{
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
        SoundManager::playReceive();
        dumpLogMsg(true, conn->key, buf, readLen);
    }
    TK::releaseBuffer(buf);
}

void BroadcastModel::error()
{
    QUdpSocket *s = qobject_cast<QUdpSocket *>(sender());

    qDebug() << QString("UDP socket error %1, %2").arg(s->error()).arg(s->errorString());
    emit sendErrMsg(3, QString("UDP socket error %1, %2").arg(s->error()).arg(s->errorString()),true);
}

void BroadcastModel::check()
{
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
