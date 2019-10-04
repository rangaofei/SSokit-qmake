//
// Created by saka on 2019-02-28.
//

#include <QHostAddress>
#include <QNetworkInterface>
#include <QTime>
#include <QDataStream>
#include "ClientModel.h"
#include "toolkit.h"

ClientModel::ClientModel(QObject *parent) : QmlLogModel(parent)
{
}

void ClientModel::getAddr() {
    QList<QHostAddress> lst = QNetworkInterface::allAddresses();
    foreach (QHostAddress a, lst) {
        if (QAbstractSocket::IPv4Protocol == a.protocol()) {
            emit appendLocalAddr(a.toString());
        }
    }
}

void ClientModel::toggleConnect(bool checked, QString addr, QString port) {
    auto r_port = quint16(port.toUInt());
    if (checked) {
        openClient(addr, r_port);
    } else {
        closeClient();
    }
}

void ClientModel::send(const QString &data) {
    QString err;
    QByteArray bin;

    if (!TK::ascii2bin(data, bin, err)) {
        qDebug() << ("bad data format to send: " + err);
        return;
    }
    qDebug()<<"UDP model send data "<<data;

    sendToDst(bin);
}

void ClientModel::sendWithHeader(const QString header, const qint32 lengthSize, bool bigEndian, const QString &data)
{
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
    sendToDst(dataBin);
}

void ClientModel::sendMessageData(SendMessageData *data)
{
    if(data->plainText()){
        qDebug()<<"纯文本发送";
        sendToDst(data->content().toUtf8());
        return;
    }else {
        qDebug()<<"非纯文本发送";
    }
    if(!data->withHeader()){
        send(data->content());
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
    sendToDst(dataBin);
}


bool ClientModel::closeClient() {
    emit connClose(host);
    close();
    return true;
}





