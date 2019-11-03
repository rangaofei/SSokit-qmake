#ifndef SOUNDMANAGER_H
#define SOUNDMANAGER_H

#include "SettingTool.h"

#include <QObject>
#include<QSound>


class SoundManager : public QObject
{
    Q_OBJECT
public:
    explicit SoundManager(QObject *parent = nullptr);
    ~SoundManager();

signals:

public slots:

    void playSound(int type);

    void playSlideOpen();

    void playSlideClose();

    static void playReceive();

    static void playSend();
private:
};

#endif // SOUNDMANAGER_H
