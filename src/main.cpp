//
// Created by 冉高飞 on 2019-02-20.
//

#include <QQmlApplicationEngine>
#include <QWindow>
#include <QApplication>
#include <QTranslator>
#include <QLibraryInfo>
#include <QThread>
#include <QHostInfo>
#include <QNetworkInterface>

#include "bluetoothmodel.h"
#include "TcpServerModel.h"
#include "UdpServerModel.h"
#include "notepadmodel.h"
#include "TcpClientModel.h"
#include "UdpClientModel.h"
#include "SettingTool.h"
#include "TranslatorTool.h"
#include "HttpManager.h"
#include "sqlitetool.h"
#include "SendMessageData.h"
#include "LogMessageModel.h"
#include "SoundManager.h"
#include "JsonFormat.h"


/**
 * @brief initSettings
 * 初始化配置文件信息
 */
void initSettings(){
    QCoreApplication::setOrganizationName("rangaofei");
    QCoreApplication::setOrganizationDomain("rangaofei.cn");
    QCoreApplication::setApplicationName("SSokit");
}

/**
 * @brief registerQml
 * 注册所有的qml文件
 */
void registerQml(){
    qmlRegisterType<NotepadModel>("src.notepadmodel", 1, 0, "NotepadModel");
    qmlRegisterType<BlueToothModel>("src.bluetoothmodel", 1, 0, "BlueToothModel");
    qmlRegisterType<TcpServerModel>("src.tcpservermodel", 1, 0, "TcpServerModel");
    qmlRegisterType<UdpServerModel>("src.udpservermodel", 1, 0, "UdpServerModel");
    qmlRegisterType<TcpClientModel>("src.tcpclientmodel", 1, 0, "TcpClientModel");
    qmlRegisterType<UdpClientModel>("src.udpclientmodel", 1, 0, "UdpClientModel");
    qmlRegisterType<SendMessageData>("src.sendmessagedata",1, 0, "SendMessageData");
    qmlRegisterType<JsonFormat>("src.jsonformat",1,0,"JsonFormat");
    qmlRegisterUncreatableType<LogMessageModel>("src.logmessagedata",1,0,"LogMessageData","Reference only");
    qmlRegisterType<NoteBook>("src.notebook",1,0,"NoteBook");
    qmlRegisterSingletonType<SQLiteTool>("src.sqlitetool",1,0,"SqliteTool",[](QQmlEngine *engine, QJSEngine *scriptEngine) -> QObject * {
        Q_UNUSED(engine)
        Q_UNUSED(scriptEngine)
        SQLiteTool *sqliteTool = new SQLiteTool();
        return sqliteTool;
    });
    qmlRegisterType<ItemPort>("src.itemport", 1, 0, "ItemPort");
    qmlRegisterSingletonType(QUrl("qrc:/assets/language/Strings.qml"), "src.strings", 1, 0, "Strings");
    qmlRegisterSingletonType(QUrl("qrc:/assets/Colors.qml"),"src.colors",1,0,"Colors");

    qmlRegisterSingletonType<SettingTool>("src.settingtool",1,0,"SettingTool",
                                          [](QQmlEngine *engine, QJSEngine *scriptEngine) -> QObject * {
        Q_UNUSED(engine)
        Q_UNUSED(scriptEngine)
        return SettingTool::getInstance();
    });
    qmlRegisterSingletonType<HttpManager>("src.httpmanager",1,0,"HttpManager", [](QQmlEngine *engine, QJSEngine *scriptEngine) -> QObject * {
        Q_UNUSED(engine)
        Q_UNUSED(scriptEngine)
        HttpManager *httpManager = new HttpManager();
        return httpManager;
    });
    qmlRegisterSingletonType<Config>("src.config",1,0,"Config", [](QQmlEngine *engine, QJSEngine *scriptEngine) -> QObject * {
        Q_UNUSED(engine)
        Q_UNUSED(scriptEngine)
        Config *config = new Config();
        return config;
    });
    qmlRegisterSingletonType<SoundManager>("src.soundmanager",1,0,"SoundManager", [](QQmlEngine *engine, QJSEngine *scriptEngine) -> QObject * {
        Q_UNUSED(engine)
        Q_UNUSED(scriptEngine)
        SoundManager *manager = new SoundManager();
        return manager;
    });
    qmlRegisterUncreatableType<TreeItem>("src.treeitem",1,0,"TreeItem","Reference only");
}


/**
 * 程序入口
 */
int main(int argc, char *argv[]) {
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QApplication app(argc, argv);
    initSettings();
    TranslatorTool::getInstance().initLanguage();
    qDebug()<<"translatorTool.initLanguage end";
    registerQml();
    qDebug()<<"registerQml end";
    QQmlApplicationEngine engine;
    qDebug()<<"QQmlApplicationEngine end";
    engine.load(QUrl(QStringLiteral("qrc:/qml/SSokit.qml")));
    qDebug()<<"engine.load end";
    if (engine.rootObjects().isEmpty())
        return -1;
    return QApplication::exec();
}
