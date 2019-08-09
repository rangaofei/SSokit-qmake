//
// Created by saka on 2019-02-28.
//

#ifndef SSOKIT_UDPCLIENTMODEL_H
#define SSOKIT_UDPCLIENTMODEL_H


#include <QUdpSocket>
#include "ClientModel.h"


class UdpClientModel : public ClientModel {
Q_OBJECT

protected:
    bool openClient(QString &addr, quint16 port) override;

    bool close() override;

    void sendToDst(const QByteArray &bin) override;

private slots:

    void asynConn();

    void newData();

    void closed();

    void error();

    void stateChanged(QAbstractSocket::SocketState state);

private:
    QUdpSocket m_udp_socket;

};


#endif //SSOKIT_UDPCLIENTMODEL_H
