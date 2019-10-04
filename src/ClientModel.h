//
// Created by saka on 2019-02-28.
//

#ifndef SSOKIT_CLIENTMODEL_H
#define SSOKIT_CLIENTMODEL_H


#include "LogMessageModel.h"
#include "QmlLogModel.h"
#include "SendMessageData.h"

#include <QObject>

class ClientModel : public QmlLogModel {

    Q_OBJECT

#define START_ERR 1
#define CLOSE_ERR 2
#define SEND_ERR 3
#define RECV_ERR 4

#define MAXBUFFER 1024*1024
#define PROP_CONN  "CONN"

public:


    explicit ClientModel(QObject *parent = nullptr);

signals:

    /**
     * qml信号
     * 添加本机地址
     * @param addr
     */
    void appendLocalAddr(QString addr);

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

public slots:

    /**
     * qml槽
     * 获取本机ip地址
     */
    void getAddr();

    /**
     * 打开或者关闭连接
     * @param checked
     * @param addr
     * @param port
     */
    void toggleConnect(bool checked, QString addr, QString port);

    /**
     * qml槽
     * 发送信息
     * @param key
     * @param data
     */
    void send(const QString &data);

    void sendWithHeader(const QString header,const qint32 lengthSize,bool bigEndian, const QString &data);

    void sendMessageData(SendMessageData *data);

protected:

    virtual bool openClient(QString &addr, quint16 port) = 0;

    virtual bool close() = 0;

    virtual void sendToDst(const QByteArray &bin) = 0;

    bool closeClient();


protected:

    QString host;

};


#endif //SSOKIT_CLIENTMODEL_H
