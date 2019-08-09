#ifndef WEBSOCKETSERVERMODEL_H
#define WEBSOCKETSERVERMODEL_H

#include "ServerModel.h"

#include <QWebSocketServer>
#include <QWebSocket>


class WebSocketServerModel : public ServerModel
{
    Q_OBJECT

    typedef struct _Conn
    {
        QWebSocket* client;
        QString key;
    } Conn;
public:
    WebSocketServerModel();

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
    QWebSocketServer m_websocket_server;
};

#endif // WEBSOCKETSERVERMODEL_H
