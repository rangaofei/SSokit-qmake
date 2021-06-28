#include "SoundManager.h"

SoundManager::SoundManager(QObject *parent) : QObject(parent)
{
}

SoundManager::~SoundManager()
{
}

void SoundManager::playSound(int type)
{
    Q_UNUSED(type)
}

void SoundManager::playSlideOpenSound()
{
    if(SettingTool::getInstance()->getEnableSysSound())
    {
        QSound::play(WAV_SLIDE_OPEN);
    }
}

void SoundManager::playSlideCloseSound()
{
    if(SettingTool::getInstance()->getEnableSysSound())
    {
        QSound::play(WAV_SLIDE_CLOSE);
    }
}

void SoundManager::playReceiveMsgSound()
{
    if(SettingTool::getInstance()->getEnableReceiveSound())
    {
        QSound::play(WAV_RECEIVE);
    }
}

void SoundManager::playSendMsgSound()
{
    if(SettingTool::getInstance()->getEnableSendSound())
    {
        QSound::play(WAV_SEND);
    }
}

