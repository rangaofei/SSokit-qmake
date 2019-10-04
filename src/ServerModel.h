//
// Created by saka on 2019-02-22.
//

#ifndef SSOKIT_SERVERMODEL_H
#define SSOKIT_SERVERMODEL_H


#include <QObject>
#include "serverskt.h"
#include "StringListModel.h"
#include "SendMessageData.h"
#include "LogMessageModel.h"
#include "QmlLogModel.h"


class ServerModel : public QmlLogModel {
    Q_OBJECT
#define START_ERR 1
#define CLOSE_ERR 2
#define SEND_ERR 3
#define RECV_ERR 4

#define MAXBUFFER 1024*1024
#define PROP_CONN  "CONN"
    typedef QHash<QString, void *> OBJMAP;

public:


    explicit ServerModel(QObject *parent = nullptr);

    virtual ~ServerModel();


signals:

    /**
     * qml信号
     * 添加本机地址
     * @param addr
     */
    void appendLocalAddr(QString addr);

    /**
     * qml信号
     * 添加新加入的连接地址
     * @param addr
     */
    void appendConnAddr(QString addr);

    /**
     * qml信号
     * 连接断开时发送信号
     * @param key
     */
    void connClose(const QString &key);

    /**
     * qml信号
     * 发送接收到的客户端发送的信息
     * @param time
     * @param type
     * @param host
     * @param msg
     * @param hexData
     * @param length
     */
    void sendLogMsg(QString time, bool type, QString host, QString msg, QString hexData, quint64 length);

    /**
     * qml信号
     * 发送错误信息
     * @param type
     * @param msg
     */
    void sendErrMsg(int type, QString msg, bool isErr);


public slots:

    /**
     * qml槽
     * 获取本机ip地址
     */
    void getAddr();

    /**
     * 打开或者关闭监听端口
     * @param checked
     * @param addr
     * @param port
     */
    void toggleConnect(bool checked, QString addr, QString port);

    /**
     * qml槽
     * 主动关闭客户端的连接
     * @param key
     */
    void kill(const QString &key);

    /**
     * qml槽
     * 发送信息
     * @param key
     * @param data
     */
    void send(const QString &key, const QString &data);

    void sendWithHeader(const QString &key,const QString header,const qint32 lengthSize,bool bigEndian, const QString &data);

    void sendMessageData(const QString &key,SendMessageData *data);
protected:

    virtual bool openServer(QString &addr, quint16 port) = 0;

    virtual bool close() = 0;

    virtual bool close(void *cookie) = 0;

    virtual void sendToDst(void *cookie, const QByteArray &bin) = 0;

    bool closeServer();

    void getKeys(QStringList &res);

    void setCookie(const QString &k, void *v);

    void unsetCookie(const QString &k);

    void *getCookie(const QString &k);

    virtual void initConfig();

    virtual void saveConfig();

    virtual void kill(QStringList &list);


private:
    OBJMAP m_conns;

};


#endif //SSOKIT_SERVERMODEL_H
