#include "TranslatorTool.h"

#include <QSettings>


QTranslator *TranslatorTool::translator=nullptr;

TranslatorTool::TranslatorTool(QObject *parent) : QObject(parent)
{

}




void TranslatorTool::initLanguage()
{
    QSettings settings;
    QString fileName="";
    if(settings.contains("language")){
        int type=settings.value("language").toInt();
        if(type==0){
            fileName=QLatin1String("SSokit_en_US");
        }else if (type==1) {
            fileName=QLatin1String("SSokit_zh_CN");
        }
    }else{
        QString locale = QLocale::system().name();
        fileName=QLatin1String("SSokit_")+locale;
        if(locale.contains("zh_CN")){
            settings.setValue("language",1);
        }else {
            settings.setValue("language",0);
        }
    }
    qDebug()<<"language type::"<<fileName;
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
