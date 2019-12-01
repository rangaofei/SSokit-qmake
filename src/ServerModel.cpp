//
// Created by saka on 2019-02-22.
//

#include <QNetworkInterface>
#include <QDataStream>
#include "ServerModel.h"
#include "toolkit.h"

ServerModel::ServerModel(QObject *parent) : QmlLogModel(parent)
{

}

ServerModel::~ServerModel() = default;


void ServerModel::initConfig() {

}

void ServerModel::saveConfig() {

}


void ServerModel::kill(QStringList &list) {
    Q_UNUSED(list)
}


void ServerModel::getAddr() {
    QList<QHostAddress> lst = QNetworkInterface::allAddresses();
    foreach (QHostAddress a, lst) {
        if (QAbstractSocket::IPv4Protocol == a.protocol()) {
            emit appendLocalAddr(a.toString());
        }
    }
}

void ServerModel::toggleConnect(bool checked, QString addr, QString port) {

    auto r_port = quint16(port.toUInt());
    if (checked) {
        m_conns.clear();
        openServer(addr, r_port);
    } else {
        closeServer();
    }
}

bool ServerModel::closeServer() {
    OBJMAP::const_iterator i;
    for (i = m_conns.constBegin(); i != m_conns.constEnd(); ++i)
    {
        QString k = i.key();
        void* v = i.value();

        if (close(v))
            emit connClose(k);
    }

    m_conns.clear();
    close();
    emit sendErrMsg(CLOSE_ERR,"Close Server",false);
    return true;
}

void ServerModel::getKeys(QStringList &res) {
    res = m_conns.keys();
}

void ServerModel::setCookie(const QString &k, void *v) {
    void *o = m_conns.value(k);
    if (o) {
        if (close(o))
            emit connClose(k);
    }
    m_conns.insert(k, v);
    emit appendConnAddr(k);
}

void ServerModel::unsetCookie(const QString &k) {
    m_conns.remove(k);
    emit connClose(k);
}

void *ServerModel::getCookie(const QString &k) {
    return m_conns.value(k);
}


void ServerModel::kill(const QString &key) {
    void *v = m_conns.value(key);
    if (v) {
        if (close(v))
            unsetCookie(key);
    } else {
        unsetCookie(key);
    }
}
void ServerModel::send(const QString &key, const QString &data) {
    void *v = m_conns.value(key);
    if (v) {
        QString err;
        QByteArray bin;

        if (!TK::ascii2bin(data, bin, err))
            qDebug() << ("bad data format to send: " + err);
        else
            qDebug()<<bin<<"==bin";
            sendToDst(v, bin);
    }
}

void ServerModel::sendWithHeader(const QString &key,const QString header, const qint32 lengthSize, bool bigEndian, const QString &data)
{
    void *v = m_conns.value(key);
    if(!v){
        return;
    }
    QString err;
    QByteArray dataBin;
    QByteArray headerBin;

    if (!TK::ascii2bin(header, headerBin, err)) {
        qDebug() << ("bad data format to send: " + err);
        return;
    }

    if (!TK::ascii2bin(data, dataBin, err)) {
        qDebug() << ("bad data format to send: " + err);
        return;
    }
    QByteArray length;
    length.resize(lengthSize);
    QDataStream sendData(&length,QIODevice::WriteOnly);
    sendData.setByteOrder(bigEndian? QDataStream::BigEndian: QDataStream::LittleEndian);
    switch (lengthSize) {
    case 0:
        break;
    case 2:
        sendData<<quint16(dataBin.size());
        break;
    case 4:
        sendData<<quint32(dataBin.size());
        break;
    }
    dataBin.prepend(length);
    dataBin.prepend(headerBin);
    sendToDst(v,dataBin);
}

void ServerModel::sendMessageData(const QString &key,SendMessageData *data)
{
    if(!data->withHeader()){
        send(key,data->content());
        return;
    }
    void *v = m_conns.value(key);
    if(!v){
        return;
    }
    QString err;
    QByteArray dataBin;
    QByteArray headerBin;

    if (!TK::ascii2bin(data->header(), headerBin, err)) {
        qDebug() << ("bad data format to send: " + err);
        return;
    }

    if (!TK::ascii2bin(data->getTargetMsg(), dataBin, err)) {
        qDebug() << ("bad data format to send: " + err);
        return;
    }
    QByteArray length;
    length.resize(data->lengthSize());
    QDataStream sendData(&length,QIODevice::WriteOnly);
    sendData.setByteOrder(data->endian()? QDataStream::BigEndian: QDataStream::LittleEndian);
    switch (data->lengthSize()) {
    case 0:
        break;
    case 2:
        sendData<<quint16(dataBin.size());
        break;
    case 4:
        sendData<<quint32(dataBin.size());
        break;
    }
    dataBin.prepend(length);
    dataBin.prepend(headerBin);
    sendToDst(v,dataBin);
}




