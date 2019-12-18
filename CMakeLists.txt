cmake_minimum_required(VERSION 3.1.0)
set(CMAKE_OSX_SYSROOT "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.15.sdk")
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
        src/HttpManager.cpp
        src/QmlLogModel.cpp
        src/SoundManager.cpp
        src/LogMessageModel.cpp
        src/config.h
        src/SendMessageData.cpp
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
        src/HttpManager.h
        src/QmlLogModel.h
        src/SoundManager.h
        src/LogMessageModel.h
        src/SendMessageData.h
        )

set(RESOURCES
        qml.qrc
        )

set(QMLS
        qml/bluetooth/BlueToothView.qml

        qml/components/LogDetailView.qml
        qml/components/LogView.qml
        qml/components/LogViewDelegate.qml
        qml/components/MessageLabel.qml
        qml/components/SendView.qml
        qml/components/ServerControlView.qml
        qml/components/SocketHeaderView.qml
        qml/components/SwitchLayout.qml

        qml/dialogs/AboutDialog.qml
        qml/dialogs/UpdateDialog.qml

        qml/icons/IconDownArrow.qml
        qml/icons/IconSelected.qml
        qml/icons/IconTriangle.qml
        qml/icons/IconUpArrow.qml

        qml/notepad/NotepadView.qml

        qml/setting/AboutSettingView.qml
        qml/setting/FunctionSettingView.qml
        qml/setting/GeneralSettingView.qml
        qml/setting/SettingView.qml
        qml/setting/ShortCutSettingView.qml

        qml/tcp/TcpClientView.qml
        qml/tcp/TcpServerView.qml
        qml/tcp/TcpView.qml

        qml/udp/UdpClientView.qml
        qml/udp/UdpServerView.qml
        qml/udp/UdpView.qml

        qml/websocket/WebSocketClientView.qml
        qml/websocket/WebSocketServerView.qml
        qml/websocket/WebSocketView.qml

        qml/widgets/BottomButton.qml
        qml/widgets/EditComboBox.qml
        qml/widgets/GeneralCheckBox.qml
        qml/widgets/ImageButton.qml
        qml/widgets/RoundCheckBox.qml
        qml/widgets/SwitchButton.qml
        qml/widgets/TipLabel.qml
        qml/widgets/TopButton.qml

        qml/ColorList.qml


        qml/TransferView.qml

        assets/images/about.png
        assets/images/about_selected.png
        assets/images/about_unselected.png
        assets/images/add.png
        assets/images/catalogue.png
        assets/images/catalogue_white.png
        assets/images/checked.png
        assets/images/clear.png
        assets/images/close_black.png
        assets/images/function.png
        assets/images/header_setting.png
        assets/images/help.png
        assets/images/ic_clear.png
        assets/images/ic_update.png
        assets/images/logo.png
        assets/images/save.png
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
find_package(Qt5Sql REQUIRED)
find_package(Qt5LinguistTools REQUIRED)
find_package(Qt5Multimedia REQUIRED)

get_target_property(_qmake_executable Qt5::qmake IMPORTED_LOCATION)
get_filename_component(_qt_bin_dir "${_qmake_executable}" DIRECTORY)
find_program(DEPLOYQT_EXECUTABLE NAMES windeployqt macdeployqt HINTS "${_qt_bin_dir}")


if(APPLE)
    add_executable(${PROJECT_NAME} MACOSX_BUNDLE ${SOURCES} ${RESOURCES})
    configure_file(${CMAKE_SOURCE_DIR}/Info.plist.in ${CMAKE_BINARY_DIR}/Info.plist)
    set_target_properties(${PROJECT_NAME} PROPERTIES MACOSX_BUNDLE_INFO_PLIST ${CMAKE_BINARY_DIR}/Info.plist)
    add_custom_command(TARGET ${PROJECT_NAME}
            POST_BUILD
            COMMAND ${DEPLOYQT_EXECUTABLE} "$<TARGET_BUNDLE_DIR:${PROJECT_NAME}>" -qmldir=${CMAKE_SOURCE_DIR}
            )
elseif(WIN32)
    add_executable(${PROJECT_NAME} WIN32 ${SOURCES} ${RESOURCES})
    add_custom_command(TARGET ${PROJECT_NAME}
            POST_BUILD
            COMMAND ${DEPLOYQT_EXECUTABLE} "$<TARGET_FILE:${PROJECT_NAME}>"
            --$<LOWER_CASE:$<CONFIG>> --qmldir ${CMAKE_SOURCE_DIR}
            )
endif()

#add_executable(${PROJECT_NAME} ${SOURCES} ${RESOURCES} )
target_compile_definitions(${PROJECT_NAME} PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)

target_link_libraries(${PROJECT_NAME} Qt5::Core Qt5::Qml Qt5::Quick)
target_link_libraries(${PROJECT_NAME} Qt5::Gui)
target_link_libraries(${PROJECT_NAME} Qt5::Bluetooth)
target_link_libraries(${PROJECT_NAME} Qt5::WebSockets)
target_link_libraries(${PROJECT_NAME} Qt5::Widgets)
target_link_libraries(${PROJECT_NAME} Qt5::Sql)
target_link_libraries(${PROJECT_NAME} Qt5::Multimedia)