cmake_minimum_required(VERSION 3.21)

project(QmlAppTemplate VERSION 0.6 LANGUAGES CXX)

set(APP_NAME ${CMAKE_PROJECT_NAME})
set(APP_VERSION ${CMAKE_PROJECT_VERSION})

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

################################################################################

message(STATUS "[CMAKE] CMAKE_VERSION               = ${CMAKE_VERSION}")
message(STATUS "[CMAKE] CMAKE_PREFIX_PATH           = ${CMAKE_PREFIX_PATH}")
message(STATUS "[SYSTEM] (HOST) SYSTEM NAME         = ${CMAKE_HOST_SYSTEM_NAME}")
message(STATUS "[SYSTEM] (TARGET) SYSTEM NAME       = ${CMAKE_SYSTEM_NAME}")
message(STATUS "[SYSTEM] (TARGET) SYSTEM VESRION    = ${CMAKE_SYSTEM_VERSION}")
message(STATUS "[PROJECT] SOURCE_DIR                = ${CMAKE_CURRENT_SOURCE_DIR}")
message(STATUS "[PROJECT] BUILD_TYPE                = ${CMAKE_BUILD_TYPE}")
message(STATUS "[PROJECT] TOOLCHAIN_FILE            = ${CMAKE_TOOLCHAIN_FILE}")
message(STATUS "[PROJECT] QT_HOST_PATH              = ${QT_HOST_PATH}")

################################################################################

find_package(Qt6 REQUIRED COMPONENTS Core Gui Qml Quick QuickControls2 Svg)

qt_standard_project_setup()

qt_add_executable(QmlAppTemplate
    src/SettingsManager.cpp src/SettingsManager.h
    src/main.cpp
    qml/qml.qrc
    qml/components.qrc
    i18n/i18n.qrc
    assets/assets.qrc
)

target_include_directories(QmlAppTemplate PRIVATE src/)
target_include_directories(QmlAppTemplate PUBLIC src/thirdparty/)

################################################################################

## Android
if(ANDROID)
    set(QT_ANDROID_ABIS "armeabi-v7a;arm64-v8a;x86;x86_64")
    set(QT_ANDROID_BUILD_ALL_ABIS ON)
    set(QT_ANDROID_MIN_SDK_VERSION 23)
    set(QT_ANDROID_TARGET_SDK_VERSION 34)

    set_target_properties(QmlAppTemplate PROPERTIES QT_ANDROID_PACKAGE_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/assets/android/")
    target_link_libraries(QmlAppTemplate PRIVATE Qt::CorePrivate)
endif()

## macOS
if(APPLE AND NOT IOS)
    set(CMAKE_OSX_ARCHITECTURES "x86_64;arm64")
    set(CMAKE_OSX_DEPLOYMENT_TARGET "10.15")
endif()

## iOS
if(IOS)
    set(IPHONEOS_DEPLOYMENT_TARGET "12.0")
    set(CMAKE_XCODE_ATTRIBUTE_IPHONEOS_DEPLOYMENT_TARGET 12.0)

    target_link_libraries(QmlAppTemplate PRIVATE Qt::GuiPrivate "-framework UIKit")
endif()

## Windows
if(WIN32)
    target_compile_definitions(QmlAppTemplate PRIVATE _USE_MATH_DEFINES)
endif()

################################################################################

# AppUtils
add_subdirectory(src/thirdparty/AppUtils)
target_link_libraries(QmlAppTemplate PRIVATE AppUtils)

# MobileUI
add_subdirectory(src/thirdparty/MobileUI)
target_link_libraries(QmlAppTemplate PRIVATE MobileUI)

# MobileSharing
add_subdirectory(src/thirdparty/MobileSharing)
target_link_libraries(QmlAppTemplate PRIVATE MobileSharing)

# SingleApplication
set(QAPPLICATION_CLASS QGuiApplication)
add_subdirectory(src/thirdparty/SingleApplication)
target_link_libraries(QmlAppTemplate PRIVATE SingleApplication)

# Qt
target_link_libraries(QmlAppTemplate PRIVATE
    Qt::Core
    Qt::Gui
    Qt::Qml
    Qt::Quick
    Qt::QuickControls2
    Qt::Svg
)

################################################################################

if(lupdate_only)
    target_sources(QmlAppTemplate PUBLIC
        qml/*.js qml/*.qml
        qml/components/*.qml
        qml/components_generic/*.qml
        qml/components_js/*.js
    )
endif()

if(CMAKE_BUILD_TYPE STREQUAL Release)
    target_compile_definitions(QmlAppTemplate PRIVATE
        NDEBUG
        QT_NO_DEBUG
        QT_NO_DEBUG_OUTPUT
    )
endif()

set_target_properties(QmlAppTemplate PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER "io.emeric.qmlapptemplate"
    MACOSX_BUNDLE_INFO_PLIST ${CMAKE_CURRENT_SOURCE_DIR}/assets/ios/Info.plist
    MACOSX_BUNDLE ON
    WIN32_EXECUTABLE ON
)

install(TARGETS QmlAppTemplate
    BUNDLE DESTINATION .    # used by macOS
    ARCHIVE DESTINATION .
    LIBRARY DESTINATION .   # used by Android
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

qt_generate_deploy_qml_app_script(
    TARGET QmlAppTemplate
    FILENAME_VARIABLE deploy_script
    NO_UNSUPPORTED_PLATFORM_ERROR
    DEPLOY_USER_QML_MODULES_ON_UNSUPPORTED_PLATFORM
    MACOS_BUNDLE_POST_BUILD
)
install(SCRIPT ${deploy_script})

################################################################################
