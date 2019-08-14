cmake_minimum_required(VERSION 3.1.0)

set(PROJECT_NAME SSokit)

project(SSokit-qmake LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CMAKE_PREFIX_PATH $ENV{QTDIR})

if (CMAKE_VERSION VERSION_LESS "3.7.0")
    set(CMAKE_INCLUDE_CURRENT_DIR ON)
endif ()

set(SOURCES
        src/SettingTool.cpp
        src/TranslatorTool.cpp
        src/itemport.cpp
        src/main.cpp
        src/logger.cpp
        src/toolkit.cpp
        src/notepadmodel.cpp
        src/ServerModel.cpp
        src/bluetoothmodel.cpp
        src/logmodel.cpp
        src/logtreemodel.cpp
        src/TcpServerModel.cpp
        src/UdpServerModel.cpp
        src/StringListModel.cpp
        src/ClientModel.cpp
        src/TcpClientModel.cpp
        src/UdpClientModel.cpp
        src/websocketservermodel.cpp
        src/websocketclientmodel.cpp
        src/sqlitetool.cpp
        )

set(HEADERS
        src/bluetoothmodel.h
        src/SettingTool.h
        src/TranslatorTool.h
        src/itemport.h
        src/logmodel.h
        src/TcpServerModel.h
        src/UdpServerModel.h
        src/notepadmodel.h
        src/TcpClientModel.h
        src/UdpClientModel.h
        src/ClientModel.h
        src/ServerModel.h
        src/Logger.h
        src/StringListModel.h
        src/websocketservermodel.h
        src/websocketclientmodel.h
        src/sqlitetool.h
        src/logger.h
        )

set(RESOURCES
        qml.qrc
        )

set(QMLS
        qml/AboutDialog.qml
        qml/AboutSettingView.qml
        qml/BlueToothView.qml
        qml/BottomButton.qml
        qml/ColorList.qml
        qml/EditComboBox.qml
        qml/FunctionSettingView.qml
        qml/GeneralCheckBox.qml
        qml/GeneralSettingView.qml
        qml/IconDownArrow.qml
        qml/IconSelected.qml
        qml/IconTriangle.qml
        qml/IconUpArrow.qml
        qml/ImageButton.qml
        qml/LogListModel.qml
        qml/LogView.qml
        qml/LogViewDelegate.qml
        qml/MessageLabel.qml
        qml/NotepadView.qml
        qml/RoundCheckBox.qml
        qml/SendView.qml
        qml/ServerControlView.qml
        qml/SettingView.qml
        qml/ShortCutSettingView.qml
        qml/SocketHeaderView.qml
        qml/SSokit.qml
        qml/TcpClientView.qml
        qml/TcpServerView.qml
        qml/TcpView.qml
        qml/TipLabel.qml
        qml/TopButton.qml
        qml/TransferView.qml
        qml/UdpClientView.qml
        qml/UdpServerView.qml
        qml/UdpView.qml
        qml/WebSocketClientView.qml
        qml/WebSocketServerView.qml
        qml/WebSocketView.qml
        assets/images/about.png
        assets/images/about_selected.png
        assets/images/about_unselected.png
        assets/images/catalogue.png
        assets/images/catalogue_white.png
        assets/images/checked.png
        assets/images/close_black.png
        assets/images/function.png
        assets/images/header_setting.png
        assets/images/help.png
        assets/images/logo.png
        assets/images/setting.png
        assets/images/shortcut.png
        assets/language/SSokit_en_US.ts
        assets/language/SSokit_zh_CN.ts
        assets/language/SSokit_en_US.qm
        assets/language/SSokit_zh_CN.qm
        assets/language/Strings.qml
        assets/Colors.qml
        )

#find_package(Qt5 COMPONENTS Core Gui Qml Quick REQUIRED)
find_package(Qt5Qml REQUIRED)
find_package(Qt5Gui REQUIRED)
find_package(Qt5Core REQUIRED)
find_package(Qt5Quick REQUIRED)
find_package(Qt5Bluetooth REQUIRED)
find_package(Qt5WebSockets REQUIRED)
find_package(Qt5Widgets REQUIRED)
find_package(Qt5LinguistTools REQUIRED)

add_executable(${PROJECT_NAME} ${SOURCES} ${RESOURCES} )
target_compile_definitions(${PROJECT_NAME} PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)

target_link_libraries(${PROJECT_NAME} Qt5::Core Qt5::Qml Qt5::Quick)
target_link_libraries(${PROJECT_NAME} Qt5::Gui)
target_link_libraries(${PROJECT_NAME} Qt5::Bluetooth)
target_link_libraries(${PROJECT_NAME} Qt5::WebSockets)
target_link_libraries(${PROJECT_NAME} Qt5::Widgets)