#ifndef QMLLOGMODEL_H
#define QMLLOGMODEL_H

#include "LogMessageModel.h"
#include "toolkit.h"

#include <QObject>
#include <QTime>

class QmlLogModel : public QObject
{
    Q_OBJECT
public:

    Q_PROPERTY(qint64 revCount READ revCount WRITE setRevCount NOTIFY revCountChanged)
    Q_PROPERTY(qint64 senCount READ senCount WRITE setSenCount NOTIFY senCountChanged)
    Q_PROPERTY(LogMessageList* dataList READ dataList WRITE setDataList NOTIFY dataListChanged)

    explicit QmlLogModel(QObject *parent = nullptr);

    ~QmlLogModel();

signals:
    void revCountChanged();
    void senCountChanged();
    void dataListChanged();
    void setCurrentIndex(qint64 index);

public slots:
    qint64 revCount();
    void setRevCount(qint64 count);
    qint64 senCount();
    void setSenCount(qint64 count);
    LogMessageList* dataList();
    void setDataList(LogMessageList* dataList);
    void dumpLogMsg(bool rev, QString &host,const QByteArray& buf, qint64 length);
    void dumpLogMsg(LogMessageModel* model);
    void clearRevCount();
    void clearSenCount();
    void clearAll();

protected:
    qint64 m_revCount;
    qint64 m_senCount;
    LogMessageList* m_dataList;
};

#endif // QMLLOGMODEL_H
