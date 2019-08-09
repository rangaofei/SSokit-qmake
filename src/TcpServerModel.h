//
// Created by 冉高飞 on 2019-02-24.
//

#ifndef SSOKIT_TCPSERVERMODEL_H
#define SSOKIT_TCPSERVERMODEL_H


#include "ServerModel.h"
#include "StringListModel.h"


class TcpServerModel : public ServerModel {
Q_OBJECT
    typedef struct _Conn
    {
        QTcpSocket* client;
        QString key;
    } Conn;
public:
    TcpServerModel();

    virtual ~TcpServerModel() override;

protected:
    void sendToDst(void *cookie, const QByteArray &bin) override;

protected:

    bool openServer(QString &addr,quint16 port) override;

    bool close() override;

public slots:
    void newConnection();

    void newData();
private slots:
    void error();

    void close(QObject *obj);

    bool close(void *cookie) override;


private:
    QTcpServer m_tcp_server;

};


#endif //SSOKIT_TCPSERVERMODEL_H
