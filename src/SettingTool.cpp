#include "SettingTool.h"


SettingTool::SettingTool(QObject *parent) : QObject(parent)
{
    qDebug()<<"constructor settingtool";
    settings=new QSettings;
}

SettingTool::~SettingTool()
{
    qDebug()<<"destroy settingtool";
    if( settings!=nullptr){
        delete  SettingTool::settings;
        settings=nullptr;
    }
}

void SettingTool::setLaunched()
{
    settings->setValue(LAUNCHED,true);
    flush();

}

bool SettingTool::isFirstLaunched()
{
    return settings->contains(LAUNCHED);
}



void SettingTool::setWindowWidth(int w)
{
    settings->setValue(WINDOW_W,w);
    flush();
}

int SettingTool::getWindowWidth()
{
    return settings->value(WINDOW_W,WINDOW_DEFAULT_W).toInt();
}

void SettingTool::setWindowHeight(int h)
{
    settings->setValue(WINDOW_H,h);
    flush();
}

int SettingTool::getWindowHeight()
{
    return settings->value(WINDOW_H,WINDOW_DEFAULT_H).toInt();
}

void SettingTool::setWindowSize(int w, int h)
{
    settings->setValue(WINDOW_W,w);
    settings->setValue(WINDOW_H,h);
    flush();
}

void SettingTool::setWindowPosition(int x, int y)
{
    settings->setValue(POSITION_X,x);
    settings->setValue(POSITION_Y,y);
    flush();
}

int SettingTool::getWindowPositionX()
{
    return settings->value(POSITION_X,100).toInt();
}

int SettingTool::getWindowPositionY()
{
    return settings->value(POSITION_Y,100).toInt();
}

void SettingTool::setLanguage(QString type)
{
    settings->setValue(LANGUAGE,type);
    flush();
}

QString SettingTool::getLanguage()
{
    return settings->value(LANGUAGE,0).toString();
}

/*1是tcpserver,2是tcpclient,3是udpserver,4是udpclient*/

QList<QString> SettingTool::getPorts(int viewType)
{
    int size=0;
    switch(viewType){
    case 1:
        size = settings->beginReadArray(TCP_SERVER_PORTS);
        break;
    case 2:
        size=settings->beginReadArray(TCP_CLIENT_PORTS);
        break;
    case 3:
        size=settings->beginReadArray(UDP_SERVER_PORTS);
        break;
    case 4:
        size=settings->beginReadArray(UDP_CLIENT_PORTS);
        break;
    }
    QList<QString> result;
    for (int i = 0; i < size; ++i) {
        settings->setArrayIndex(i);
        QString port=settings->value(PORT).toString();
        result.append(port);
    }
    settings->endArray();
    flush();
    return result;
}

void SettingTool::savePorts(int viewType,QList<QString> ports)
{
    switch (viewType) {
    case 1:
        settings->beginWriteArray(TCP_SERVER_PORTS);
        break;
    case 2:
        settings->beginWriteArray(TCP_CLIENT_PORTS);
        break;
    case 3:
        settings->beginWriteArray(UDP_SERVER_PORTS);
        break;
    case 4:
        settings->beginWriteArray(UDP_CLIENT_PORTS);
        break;
    }
    qDebug()<<"size of ports::"<<ports.size();
    for (int i = 0; i < ports.size(); ++i) {
        settings->setArrayIndex(i);
        qDebug()<<ports.at(i);
        settings->setValue(PORT,ports.at(i));
    }
    settings->endArray();
    flush();
}

void SettingTool::flush()
{
    settings->sync();
}

void SettingTool::setShowHeader(bool show)
{
    settings->setValue(SHOW_HEADER,show);
    flush();
}

bool SettingTool::getShowHeader()
{
    return settings->value(SHOW_HEADER,false).toBool();
}
