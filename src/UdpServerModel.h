//
// Created by 冉高飞 on 2019-02-24.
//

#ifndef SSOKIT_UDPSERVERMODEL_H
#define SSOKIT_UDPSERVERMODEL_H


#include "ServerModel.h"


class UdpServerModel : public ServerModel {
Q_OBJECT

    typedef struct _Conn {
        QHostAddress addr;
        quint16 port;
        QDateTime stamp;
        QString key;
    } Conn;

public:
    UdpServerModel();

    ~UdpServerModel() override;

protected:
    void sendToDst(void *cookie, const QByteArray &bin) override;

    bool openServer(QString &addr, quint16 port) override;

    bool close() override;

    bool close(void *cookie) override;

private slots:

    void newData();

    void error();

    void check();

private:
    QUdpSocket m_udp_server;
    QTimer m_timer;
};


#endif //SSOKIT_UDPSERVERMODEL_H
