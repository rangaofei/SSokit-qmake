#ifndef RECEIVEMESSAGEDATA_H
#define RECEIVEMESSAGEDATA_H

#include <QObject>

class ReceiveMessageData : public QObject
{
    Q_OBJECT
public:
    explicit ReceiveMessageData(QObject *parent = nullptr);

signals:

public slots:

    //lab, rev, host, ascData, hexData, static_cast<uint>(length)
private:
    QString m_time;
    bool m_isRev;
    QString m_host;
    QString m_hexData;
    QString m_convertData;
    int m_length;

};

#endif // RECEIVEMESSAGEDATA_H
