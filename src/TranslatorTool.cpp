#include "TranslatorTool.h"

#include <QLocale>
#include <QDebug>
#include <QApplication>
#include "settingtool.h"
#define LANGUAGE_DIR ":/assets/lauguage"
QTranslator *TranslatorTool::translator=nullptr;

TranslatorTool::TranslatorTool(QObject *parent) : QObject(parent)
{

}

void TranslatorTool::setLanguage(int type)
{
    SettingTool::getInstance()->setValue("language",type);
}


void TranslatorTool::initLanguage()
{
    QString fileName="";
    if(SettingTool::getInstance()->contains("language")){
        int type=SettingTool::getInstance()->value("language").toInt();
        qDebug()<<"language type::"<<type;
        if(type==0){
            fileName=QLatin1String("SSokit_en_US");
        }else if (type==1) {
            fileName=QLatin1String("SSokit_zh_CN");
        }

    }else{
        QString locale = QLocale::system().name();
        qDebug()<<"local language::"<<locale;
        fileName=QLatin1String("SSokit_")+locale;
        if(locale.contains("zh_CN")){
            setLanguage(1);
        }else {
            setLanguage(0);
        }
    }
    getInstance()->load(fileName,QLatin1String(LANGUAGE_DIR));
    QApplication::installTranslator(getInstance()); //安装翻译器
}

QTranslator *TranslatorTool::getInstance()
{
    if(translator==nullptr){
        translator=new QTranslator;
    }
    return translator;
}
