#include "settingtool.h"

QSettings *SettingTool::settings=nullptr;

SettingTool::SettingTool(QObject *parent) : QObject(parent)
{

}

SettingTool::~SettingTool()
{
    qDebug()<<"destroy settingtool";
    if( SettingTool::settings!=nullptr){
        delete  SettingTool::settings;
        settings=nullptr;
    }
}

QSettings *SettingTool::getInstance()
{
    if( SettingTool::settings==nullptr)
    {
        SettingTool::settings=new QSettings;
        if(!settings->contains(LAUNCHED))
        {
            qDebug()<<"first launch";
            settings->clear();
            settings->setValue(LAUNCHED,true);
        }
        qDebug()<<"init settings::"<<settings->fileName();
    }
    return SettingTool::settings;
}


void SettingTool::setLaunched()
{
    getInstance()->setValue(LAUNCHED,true);
    flush();

}

bool SettingTool::isFirstLaunched()
{
    return getInstance()->contains(LAUNCHED);
}



void SettingTool::setWindowWidth(int w)
{
    getInstance()->setValue(WINDOW_W,w);
    flush();
}

int SettingTool::getWindowWidth()
{
    return getInstance()->value(WINDOW_W,WINDOW_DEFAULT_W).toInt();
}

void SettingTool::setWindowHeight(int h)
{
    getInstance()->setValue(WINDOW_H,h);
    flush();
}

int SettingTool::getWindowHeight()
{
    return getInstance()->value(WINDOW_H,WINDOW_DEFAULT_H).toInt();
}

void SettingTool::setWindowSize(int w, int h)
{
    getInstance()->setValue(WINDOW_W,w);
    getInstance()->setValue(WINDOW_H,h);
    flush();
}

void SettingTool::setWindowPosition(int x, int y)
{
    getInstance()->setValue(POSITION_X,x);
    getInstance()->setValue(POSITION_Y,y);
    flush();
}

int SettingTool::getWindowPositionX()
{
    return getInstance()->value(POSITION_X,100).toInt();
}

int SettingTool::getWindowPositionY()
{
    return getInstance()->value(POSITION_Y,100).toInt();
}

void SettingTool::setLanguage(QString type)
{
    getInstance()->setValue(LANGUAGE,type);
    flush();
}

QString SettingTool::getLanguage()
{
    return getInstance()->value(LANGUAGE,0).toString();
}

/*1是tcpserver,2是tcpclient,3是udpserver,4是udpclient*/

QList<QString> SettingTool::getPorts(int viewType)
{
    int size=0;
    switch(viewType){
    case 1:
        size = getInstance()->beginReadArray(TCP_SERVER_PORTS);
        break;
    case 2:
        size=getInstance()->beginReadArray(TCP_CLIENT_PORTS);
        break;
    case 3:
        size=getInstance()->beginReadArray(UDP_SERVER_PORTS);
        break;
    case 4:
        size=getInstance()->beginReadArray(UDP_CLIENT_PORTS);
        break;
    }
    QList<QString> result;
    for (int i = 0; i < size; ++i) {
        getInstance()->setArrayIndex(i);
        QString port=getInstance()->value(PORT).toString();
        result.append(port);
    }
    getInstance()->endArray();
    flush();
    return result;
}

void SettingTool::savePorts(int viewType,QList<QString> ports)
{
    switch (viewType) {
    case 1:
        getInstance()->beginWriteArray(TCP_SERVER_PORTS);
        break;
    case 2:
        getInstance()->beginWriteArray(TCP_CLIENT_PORTS);
        break;
    case 3:
        getInstance()->beginWriteArray(UDP_SERVER_PORTS);
        break;
    case 4:
        getInstance()->beginWriteArray(UDP_CLIENT_PORTS);
        break;
    }
    qDebug()<<"size of ports::"<<ports.size();
    for (int i = 0; i < ports.size(); ++i) {
        getInstance()->setArrayIndex(i);
        qDebug()<<ports.at(i);
        getInstance()->setValue(PORT,ports.at(i));
    }
    getInstance()->endArray();
    flush();
}

void SettingTool::flush()
{
    getInstance()->sync();
}

void SettingTool::setShowHeader(bool show)
{
    getInstance()->setValue(SHOW_HEADER,show);
    flush();
}

bool SettingTool::getShowHeader()
{
    return getInstance()->value(SHOW_HEADER,false).toBool();
}
