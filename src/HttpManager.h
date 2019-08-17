#ifndef HTTPMANAGER_H
#define HTTPMANAGER_H

#include <QNetworkReply>
#include <QObject>

class HttpManager : public QObject
{
    Q_OBJECT
public:
    explicit HttpManager(QObject *parent = nullptr);

signals:

public slots:
    void checkVersion();

    void requestFinished(QNetworkReply* reply);
};

#endif // HTTPMANAGER_H
