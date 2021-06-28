#include "HttpManager.h"
#include "Util.h"


HttpManager::HttpManager(QObject *parent) : QObject(parent)
{

}

/**
 * @brief HttpManager::checkVersion
 * 检查版本
 */
void HttpManager::checkVersion()
{
#ifdef QT_NO_DEBUG
    QNetworkRequest request;
    QNetworkAccessManager* naManager = new QNetworkAccessManager(this);
    QMetaObject::Connection connRet = QObject::connect(naManager, SIGNAL(finished(QNetworkReply*)), this, SLOT(requestFinished(QNetworkReply*)));
    Q_ASSERT(connRet);
    QUrl url=QUrl("http://www.rangaofei.cn/ssokit/api/version");
    QUrlQuery query;
    request.setUrl(url);
    request.setRawHeader(QByteArray("uuid"),Util::getUUID().toUtf8());
    request.setRawHeader(QByteArray("version"),Config::getVersionName().toUtf8());
    request.setRawHeader(QByteArray("sys-type"),Util::getSystemType().toUtf8());
    request.setRawHeader(QByteArray("sys-version"),Util::getSystemVersion().toUtf8());
    naManager->get(request);
#else
    qDebug() << "debug mode,checkVersion disabled";
#endif
}

/**
 * @brief HttpManager::requestFinished
 * @param reply
 * 请求结束
 */
void HttpManager::requestFinished(QNetworkReply *reply)
{
    // 获取http状态码
    QVariant statusCode = reply->attribute(QNetworkRequest::HttpStatusCodeAttribute);

    if(!statusCode.isValid())
    {
        return;
    }
    qDebug() << "status code=" << statusCode.toInt();

    QVariant reason = reply->attribute(QNetworkRequest::HttpReasonPhraseAttribute).toString();
    if(reason.isValid())
        qDebug() << "reason=" << reason.toString();

    QNetworkReply::NetworkError err = reply->error();

    if(err != QNetworkReply::NoError)
    {
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
        QJsonObject wrapperObj=jsonDoc.object();
        int code = wrapperObj.value("code").toInt();
        if(code!=200){
            qDebug()<<"error::"<<wrapperObj.value("msg").toString();
            return;
        }
        QJsonObject rootObj=wrapperObj.value("data").toObject();
        int version=rootObj.value("version_code").toInt();
        if(version<=Config::getVersionCode()){
            return;
        }
        int32_t sys=Config::getSystem();
        QString url="";
        switch (sys) {
        case 0:
            break;
        case 1:
            url=rootObj.value("win_url").toString();
            break;
        case 2:
            url=rootObj.value("linux_url").toString();
            break;
        case 3:
            url=rootObj.value("mac_url").toString();
            break;
        }
        emit showUpdateVersion(
                    rootObj.value("version_name").toString(),
                    rootObj.value("content_cn").toString(),
                    rootObj.value("content_en").toString(),
                    rootObj.value("release_date").toString(),
                    url,
                    rootObj.value("force_update").toBool()
                    );
    }
}
