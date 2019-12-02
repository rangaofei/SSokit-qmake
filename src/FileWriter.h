#ifndef FILEWRITER_H
#define FILEWRITER_H

#include "LogMessageModel.h"

#include <QObject>
#include<QFile>

class FileWriter : public QObject
{
    Q_OBJECT
public:
    explicit FileWriter(QObject *parent = nullptr);
    ~FileWriter();

signals:

public slots:
    void setFileName(QString& name);

    void writeData(QByteArray data);
    void writeLogMessage(LogMessageModel* model);

private:
    QFile *file;
};

#endif // FILEWRITER_H
