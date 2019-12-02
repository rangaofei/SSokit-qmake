#ifndef HTTPMANAGER_H
#define HTTPMANAGER_H

#include <QNetworkReply>
#include <QObject>
#include <QJsonObject>
#include <QJsonParseError>
#include "config.h"

#define BASE_URL "http://www.rangaofei.cn/ssokit/"
#define PATH_VERSION "version"

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
};

#endif // HTTPMANAGER_H
