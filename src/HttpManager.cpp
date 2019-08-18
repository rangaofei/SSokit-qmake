#include "HttpManager.h"


HttpManager::HttpManager(QObject *parent) : QObject(parent)
{

}

void HttpManager::checkVersion()
{
    QNetworkRequest request;
    QNetworkAccessManager* naManager = new QNetworkAccessManager(this);
    QMetaObject::Connection connRet = QObject::connect(naManager, SIGNAL(finished(QNetworkReply*)), this, SLOT(requestFinished(QNetworkReply*)));
    Q_ASSERT(connRet);
    request.setUrl(QUrl("http://www.rangaofei.cn/ssokit/version.json"));
    naManager->get(request);
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
        int version=rootObj.value("version_code").toInt();
        if(version<=Config::getVersionCode()){
            return;
        }
        emit showUpdateVersion(
                    rootObj.value("version_name").toString(),
                    rootObj.value("content_cn").toString(),
                    rootObj.value("content_en").toString(),
                    rootObj.value("release_date").toString(),
                    rootObj.value("url").toString(),
                    rootObj.value("force_update").toBool()
                    );
    }
}
