#include <QObject>

#ifndef CONFIG_H
#define CONFIG_H

#define MAJOR_VERSION 1
#define MINOR_VERSION 0
#define PATCH_VERSION 8

#define YEAR 2019
#define MONTH 9
#define DAY 6

class Config : public QObject
{
    Q_OBJECT

public:

signals:

public slots:
    static int getVersionCode(){
        return MAJOR_VERSION*1000+MINOR_VERSION*100+PATCH_VERSION;
    }

    static QString getVersionName(){
        QString versionName;
        versionName.sprintf("%d.%d.%d",MAJOR_VERSION,MINOR_VERSION,PATCH_VERSION);
        return versionName;
    }

    static QString getDate(){
        QString date;
        date.sprintf("%d-%d-%d",YEAR,MONTH,DAY);
        return date;
    }
};

#endif // CONFIG_H
