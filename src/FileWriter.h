#ifndef FILEWRITER_H
#define FILEWRITER_H

#include <QObject>

class FileWriter : public QObject
{
    Q_OBJECT
public:
    explicit FileWriter(QObject *parent = nullptr);

signals:

public slots:
};

#endif // FILEWRITER_H
