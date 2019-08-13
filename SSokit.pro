QT += quick
CONFIG += c++11

# The following define makes your compiler emit warnings if you use
# any Qt feature that has been marked deprecated (the exact warnings
# depend on your compiler). Refer to the documentation for the
# deprecated API to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        src/SettingTool.cpp \
        src/TranslatorTool.cpp \
        src/itemport.cpp \
        src/main.cpp \
        src/logger.cpp \
        src/toolkit.cpp \
        src/notepadmodel.cpp \
        src/ServerModel.cpp \
        src/bluetoothmodel.cpp \
        src/logmodel.cpp \
        src/logtreemodel.cpp \
        src/TcpServerModel.cpp \
        src/UdpServerModel.cpp \
        src/StringListModel.cpp \
        src/ClientModel.cpp \
        src/TcpClientModel.cpp \
        src/UdpClientModel.cpp \
        src/websocketservermodel.cpp \
        src/websocketclientmodel.cpp \
        src/sqlitetool.cpp

HEADERS +=  src/bluetoothmodel.h \
            src/SettingTool.h \
            src/TranslatorTool.h \
            src/itemport.h \
            src/logmodel.h \
            src/TcpServerModel.h \
            src/UdpServerModel.h \
            src/notepadmodel.h \
            src/TcpClientModel.h \
            src/UdpClientModel.h \
            src/ClientModel.h \
            src/ServerModel.h \
            src/Logger.h \
            src/StringListModel.h \
            src/websocketservermodel.h \
            src/websocketclientmodel.h \
            src/sqlitetool.h
            src/logger.h

RESOURCES += qml.qrc

macx{
RC_FILE += Icon.icns
}
win32{
RC_ICONS += SSOkit.ico
}

TRANSLATIONS += assets/language/SSokit_zh_CN.ts \
                assets/language/SSokit_en_US.ts

CONFIG(debug,debug|release) {


} else {

DEFINES+= QT_NO_DEBUG_OUTPUT


}

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =


QT += widgets \
      bluetooth \
      websockets \
#      sql


# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target


