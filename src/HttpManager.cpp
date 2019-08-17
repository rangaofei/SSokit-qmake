#include "HttpManager.h"
#include <QJsonObject>
#include <QJsonParseError>

HttpManager::HttpManager(QObject *parent) : QObject(parent)
{

}

void HttpManager::checkVersion()
{
    QNetworkRequest request;
    QNetworkAccessManager* naManager = new QNetworkAccessManager(this);
    QMetaObject::Connection connRet = QObject::connect(naManager, SIGNAL(finished(QNetworkReply*)), this, SLOT(requestFinished(QNetworkReply*)));
    Q_ASSERT(connRet);
    qDebug()<<"start check version";
    request.setUrl(QUrl("http://www.rangaofei.cn/ssokit/version.json"));
    QNetworkReply* reply = naManager->get(request);
}

void HttpManager::requestFinished(QNetworkReply *reply)
{
    // 获取http状态码
    QVariant statusCode = reply->attribute(QNetworkRequest::HttpStatusCodeAttribute);
    if(statusCode.isValid())
        qDebug() << "status code=" << statusCode.toInt();

    QVariant reason = reply->attribute(QNetworkRequest::HttpReasonPhraseAttribute).toString();
    if(reason.isValid())
        qDebug() << "reason=" << reason.toString();

    QNetworkReply::NetworkError err = reply->error();
    if(err != QNetworkReply::NoError) {
        qDebug() << "Failed: " << reply->errorString();
    }
    else {
        // 获取返回内容
//        qDebug() << reply->readAll();
        QJsonParseError json_error;
        QJsonDocument jsonDoc(QJsonDocument::fromJson(reply->readAll(), &json_error));
        if(json_error.error != QJsonParseError::NoError)
        {
            qDebug() << "json error!";
            return;
        }
        if(!jsonDoc.isObject()){
            return;
        }
        QJsonObject rootObj = jsonDoc.object();
        QStringList keys = rootObj.keys();
        for(int i = 0; i < keys.size(); i++)
        {
            qDebug() << "key" << i << " is:" << keys.at(i);
        }
    }
}
