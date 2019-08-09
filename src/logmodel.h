#ifndef LOGMODEL_H
#define LOGMODEL_H

#include <QObject>

class LogModel : public QObject {
Q_OBJECT
public:
    explicit LogModel(QObject *parent = nullptr);

signals:

    void sendMsg(QString msg);

public slots:

    void writeMsg(QString msg);
};

#endif // LOGMODEL_H
