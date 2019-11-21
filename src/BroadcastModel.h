#ifndef BORADCASTMODEL_H
#define BORADCASTMODEL_H

#include "ServerModel.h"

#include <QObject>

class BroadcastModel : public ServerModel
{
    Q_OBJECT
    typedef struct _Conn {
        QHostAddress addr;
        quint16 port;
        QDateTime stamp;
        QString key;
    } Conn;
public:
    explicit BroadcastModel(QObject *parent = nullptr);
    ~BroadcastModel();

signals:

public slots:

    // ServerModel interface
protected:
    bool openServer(QString &addr, quint16 port);
    bool close();
    bool close(void *cookie);
    void sendToDst(void *cookie, const QByteArray &bin);

private slots:

    void newData();

    void error();

    void check();

private:
    QUdpSocket m_udp_scoket;
    QTimer m_timer;
};

#endif // BORADCASTMODEL_H
