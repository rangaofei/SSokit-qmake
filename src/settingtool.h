#ifndef SETTINGTOOL_H
#define SETTINGTOOL_H

#include <QObject>
#include <QCoreApplication>
#include <QSettings>
#include <QDebug>
#include "itemport.h"

#define LAUNCHED "launched"
#define GROUP_WINDOW "window"
#define WINDOW_W "width"
#define WINDOW_H "height"
#define POSITION_X "postion_x"
#define POSITION_Y "position_y"
#define LANGUAGE "language"    //0-en，1-cn

#define TCP_SERVER_PORTS "tcp_server_ports"
#define TCP_CLIENT_PORTS "tcp_client_ports"
#define UDP_SERVER_PORTS "udp_server_ports"
#define UDP_CLIENT_PORTS "udp_client_ports"
#define PORT "port"


#define WINDOW_DEFAULT_W 800
#define WINDOW_DEFAULT_H 600

class SettingTool : public QObject
{
    Q_OBJECT
protected:
    explicit SettingTool(QObject *parent = nullptr);
    ~SettingTool();

private:
    static SettingTool *instance;
    static QSettings *settings;

public:
    static QSettings *getInstance();


signals:

public slots:
    void setLaunched();
    bool isFirstLaunched();

    void setWindowWidth(int w);
    int getWindowWidth();

    void setWindowHeight(int h);
    int getWindowHeight();

    void setWindowSize(int w,int h);

    void setWindowPosition(int x,int y);

    int getWindowPositionX();
    int getWindowPositionY();

    void setLanguage(QString type);
    QString getLanguage();


    QList<QString> getPorts(int viewType);

    void savePorts( int viewType,QList<QString> ports);

    void flush();

};


#endif // SETTINGTOOL_H
