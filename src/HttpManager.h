#ifndef HTTPMANAGER_H
#define HTTPMANAGER_H

#include <QNetworkReply>
#include <QObject>
#include <QJsonObject>
#include <QJsonParseError>
#include <QUrlQuery>
#include "config.h"

class HttpManager : public QObject
{
    Q_OBJECT
public:
    explicit HttpManager(QObject *parent = nullptr);

signals:
    void showUpdateVersion(QString newVersion,
                           QString contentCN,
                           QString contentEN,
                           QString releaseDate,
                           QString url,
                           bool force);
public slots:
    void checkVersion();

    void requestFinished(QNetworkReply* reply);

private:
    void dealWithReply(QByteArray* reply);
};

#endif // HTTPMANAGER_H
