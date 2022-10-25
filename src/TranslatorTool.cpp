#include "TranslatorTool.h"

#include <QSettings>



TranslatorTool::TranslatorTool(QObject *parent) : QObject(parent)
{
    translator = new QTranslator;
    qDebug()<<"TranslatorTool()";
}

TranslatorTool::~TranslatorTool()
{
    delete translator;
    qDebug()<<"~TranslatorTool()";
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
    translator->load(fileName,QLatin1String(LANGUAGE_DIR));
    QApplication::installTranslator(translator); //安装翻译器
}

TranslatorTool &TranslatorTool::getInstance()
{
    static TranslatorTool instance;
    return instance;
}
