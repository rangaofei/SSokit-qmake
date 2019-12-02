#ifndef JSONFORMAT_H
#define JSONFORMAT_H

#include <QObject>
#include <QJsonDocument>

class JsonFormat :public QObject
{
    Q_OBJECT
public:
    explicit JsonFormat();

    ~JsonFormat();

signals:
    void formattedJson(QString data);
public slots:

    void checkJonsStr(QString jsonStr);

    void formatJson();

private:
    QJsonDocument *m_jsonDocument;
    QJsonParseError m_error;
};

#endif // JSONFORMAT_H
