#include "SoundManager.h"

SoundManager::SoundManager(QObject *parent) : QObject(parent)
{

}

SoundManager::~SoundManager()
{
}

void SoundManager::playSound(int type)
{

}

void SoundManager::playSlideOpen()
{
    if(SettingTool::getEnableSysSound())
    {
        QSound::play("qrc:/assets/rings/slide_open.wav");
    }
}

void SoundManager::playSlideClose()
{
    if(SettingTool::getEnableSysSound())
    {
        QSound::play("qrc:/assets/rings/slide_close.wav");
    }
}

void SoundManager::playReceive()
{
    if(SettingTool::getEnableReceiveSound())
    {
        QSound::play("qrc:/assets/rings/receive.wav");
    }
}

void SoundManager::playSend()
{
    if(SettingTool::getEnableSendSound())
    {
        QSound::play("qrc:/assets/rings/send.wav");
    }
}

