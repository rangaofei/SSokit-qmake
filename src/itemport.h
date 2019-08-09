#ifndef ITEMPORT_H
#define ITEMPORT_H

#include <QObject>

class ItemPort : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString port READ port)
public:
    explicit ItemPort(QObject *parent = nullptr);
    ItemPort(QString port);
    QString port() const;//READ 接口
signals:

public slots:

private:
    QString m_port;
};

#endif // ITEMPORT_H
