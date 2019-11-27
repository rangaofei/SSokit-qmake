#ifndef SOUNDMANAGER_H
#define SOUNDMANAGER_H

#include "SettingTool.h"

#include <QObject>
#include<QSound>

#define WAV_SLIDE_OPEN      "qrc:/assets/rings/slide_open.wav"
#define WAV_SLIDE_CLOSE     "qrc:/assets/rings/slide_close.wav"
#define WAV_RECEIVE         "qrc:/assets/rings/receive.wav"
#define WAV_SEND            "qrc:/assets/rings/send.wav"


class SoundManager : public QObject
{
    Q_OBJECT
public:
    explicit SoundManager(QObject *parent = nullptr);
    ~SoundManager();

signals:

public slots:

    //播放声音
    static void playSound(int type);

    //播放滑动打开音效
    static void playSlideOpen();
    //播放滑动关闭音效
    static void playSlideClose();
    //播放接收消息音效
    static void playReceive();
    //播放发送消息音效
    static void playSend();
private:
};

#endif // SOUNDMANAGER_H
