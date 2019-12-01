#ifndef QMLLOGMODEL_H
#define QMLLOGMODEL_H

#include "LogMessageModel.h"
#include "toolkit.h"

#include <QObject>
#include <QTime>

//qml日志模型
class QmlLogModel : public QObject
{
    Q_OBJECT
public:

    enum ClearType{
        RECEIVE,
        SEND,
        ALL,
    };

    Q_PROPERTY(qint64 revCount READ revCount WRITE setRevCount NOTIFY revCountChanged)
    Q_PROPERTY(qint64 senCount READ senCount WRITE setSenCount NOTIFY senCountChanged)
    Q_PROPERTY(LogMessageList* dataList READ dataList WRITE setDataList NOTIFY dataListChanged)

    explicit QmlLogModel(QObject *parent = nullptr);

    ~QmlLogModel();

signals:

    //接收到的数据个数变化
    void revCountChanged();

    //发送的数据个数变化
    void senCountChanged();

    //数据列表变化
    void dataListChanged();

    //设置当前选中的数据
    void setCurrentIndex(qint64 index);

public slots:

    //接收到的数据getter方法
    qint64 revCount();

    //接收到的数据setter方法
    void setRevCount(qint64 count);

    //发送的数据getter方法
    qint64 senCount();

    //发送的数据的setter方法
    void setSenCount(qint64 count);

    //数据列表getter方法
    LogMessageList* dataList();

    //数据列表setter方法
    void setDataList(LogMessageList* dataList);

    //输出日志
    void dumpLogMsg(bool rev, QString &host,const char* buf, qint64 length);

    //输出日志的重载方法
    void dumpLogMsg(LogMessageModel* model);

    //清空接收的数据
    void clearRevCount(bool clearData);

    //清空发送的数据
    void clearSenCount(bool clearData);

    //清除所有
    void clearAll();

private:
    void clearData(ClearType type);

protected:
    qint64 m_revCount;
    qint64 m_senCount;
    LogMessageList* m_dataList;

};

#endif // QMLLOGMODEL_H
