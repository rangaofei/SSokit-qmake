//
// Created by saka on 2019-02-28.
//

#ifndef SSOKIT_TCPCLIENTMODEL_H
#define SSOKIT_TCPCLIENTMODEL_H


#include <QTcpSocket>
#include "ClientModel.h"
#include "LogMessageModel.h"


class TcpClientModel : public ClientModel {
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
    QTcpSocket m_tcp_socket;
    LogMessageList *logMessageList;
};


#endif //SSOKIT_TCPCLIENTMODEL_H
