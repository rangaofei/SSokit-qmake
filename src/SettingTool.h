#ifndef SETTINGTOOL_H
#define SETTINGTOOL_H

#include <QObject>
#include <QCoreApplication>
#include <QSettings>
#include <QDebug>
#include "itemport.h"

#define LAUNCHED            "launched"
#define GROUP_WINDOW        "window"
#define WINDOW_W            "width"
#define WINDOW_H            "height"
#define POSITION_X          "postion_x"
#define POSITION_Y          "position_y"
#define LANGUAGE            "language"    //0-en，1-cn

#define REMEMBER_POSITION   "remember_position"
#define REMEMBER_SIZE       "remember_size"

#define TCP_SERVER_PORTS    "tcp_server_ports"
#define TCP_CLIENT_PORTS    "tcp_client_ports"
#define UDP_SERVER_PORTS    "udp_server_ports"
#define UDP_CLIENT_PORTS    "udp_client_ports"
#define PORT                "port"
#define SHOW_HEADER         "show_header"

#define WINDOW_DEFAULT_W 800
#define WINDOW_DEFAULT_H 600

class SettingTool : public QObject
{
    Q_OBJECT

public:
    explicit SettingTool(QObject *parent = nullptr);
    ~SettingTool();

private:
    QSettings *settings=nullptr;

signals:

public slots:
    //设置加载状态
    void setLaunched();
    //是否运行过程序
    bool isFirstLaunched();

    //设置窗口的宽度
    void setWindowWidth(int w);
    //获取窗口宽度
    int getWindowWidth();

    //设置窗口高度
    void setWindowHeight(int h);
    //获取窗口高度
    int getWindowHeight();

    //设置窗口大小
    void setWindowSize(int w,int h);
    //设置窗口位置
    void setWindowPosition(int x,int y);
    //获取窗口坐标
    int getWindowPositionX();
    int getWindowPositionY();

    //设置语言种类
    void setLanguage(QString type);
    //获取语言种类
    QString getLanguage();

    //获取端口列表
    QList<QString> getPorts(int viewType);
    //保存新端口
    void savePorts( int viewType,QList<QString> ports);

    void flush();

    //设置是否显示头信息
    void setShowHeader(bool show);
    //获取显示头信息
    bool getShowHeader();

    //记住窗口大小
    void setRememberWindowSize(bool remember);
    bool getRememberWindowSize();

    void setRememberWindowPos(bool remember);
    bool getRememberWindowPos();
};


#endif // SETTINGTOOL_H
