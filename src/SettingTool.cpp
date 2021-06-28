#include "SettingTool.h"


SettingTool::SettingTool(QObject *parent) : QObject(parent)
{
    settings=new QSettings;
}

SettingTool::~SettingTool()
{
    if( settings!=nullptr){
        delete SettingTool::settings;
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
    return settings->value(WINDOW_W, WINDOW_DEFAULT_W).toInt();
}

void SettingTool::setWindowHeight(int h)
{
    settings->setValue(WINDOW_H,h);
    flush();
}

int SettingTool::getWindowHeight()
{
    return settings->value(WINDOW_H, WINDOW_DEFAULT_H).toInt();
}

void SettingTool::setWindowSize(int w, int h)
{
    if(!getRememberWindowSize()){
        return;
    }
    settings->setValue(WINDOW_W,w);
    settings->setValue(WINDOW_H,h);
    flush();
}

void SettingTool::setWindowPosition(int x, int y)
{
    if(!getRememberWindowPos()){
        return;
    }
    settings->setValue(POSITION_X,x);
    settings->setValue(POSITION_Y,y);
    flush();
}

int SettingTool::getWindowPositionX()
{
    return settings->value(POSITION_X, 100).toInt();
}

int SettingTool::getWindowPositionY()
{
    return settings->value(POSITION_Y, 100).toInt();
}

void SettingTool::setLanguage(QString type)
{
    settings->setValue(LANGUAGE,type);
    flush();
}

int SettingTool::getLanguage()
{
    return settings->value(LANGUAGE,0).toInt();
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

void SettingTool::setRememberWindowSize(bool remember)
{
    settings->setValue(REMEMBER_SIZE,remember);
}

bool SettingTool::getRememberWindowSize()
{
    return settings->value(REMEMBER_SIZE,false).toBool();
}

void SettingTool::setRememberWindowPos(bool remember)
{
    settings->setValue(REMEMBER_POSITION,remember);
}

bool SettingTool::getRememberWindowPos()
{
    return settings->value(REMEMBER_POSITION,false).toBool();
}

void SettingTool::setShowSendClear(bool clear)
{
    settings->setValue(SHOW_SEND_CLEAR,clear);
}

bool SettingTool::getShowSendClear()
{
    return settings->value(SHOW_SEND_CLEAR,false).toBool();
}

void SettingTool::setEnableLogHover(bool enable)
{
    settings->setValue(LOG_ENABLE_HOVER,enable);
}

bool SettingTool::getEnableLogHover()
{
    return settings->value(LOG_ENABLE_HOVER,false).toBool();
}

void SettingTool::setEnableSendSound(bool enable)
{
    settings->setValue(PLAY_SEND_SOUND,enable);
}

bool SettingTool::getEnableSendSound()
{
    return settings->value(PLAY_SEND_SOUND,false).toBool();
}

void SettingTool::setEnableReceiveSound(bool enable)
{
    settings->setValue(PLAY_RECEIVE_SOUND,enable);
}

bool SettingTool::getEnableReceiveSound()
{
    return settings->value(PLAY_RECEIVE_SOUND,false).toBool();
}

void SettingTool::setEnableSysSound(bool enable)
{
    settings->setValue(PLAY_SYSTEM_SOUND,enable);
}

bool SettingTool::getEnableSysSound()
{
    return settings->value(PLAY_SYSTEM_SOUND,false).toBool();
}

