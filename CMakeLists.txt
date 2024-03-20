cmake_minimum_required(VERSION 3.20)

project(QmlAppTemplate VERSION 0.6 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

string(TIMESTAMP CURRENT_TIMESTAMP "%s" UTC)
set(APP_NAME ${CMAKE_PROJECT_NAME})
set(APP_VERSION ${CMAKE_PROJECT_VERSION})
set(APP_VERSION_CODE ${TIMESTAMP})

################################################################################

message(STATUS "[CMAKE] CMAKE_VERSION               = ${CMAKE_VERSION}")
message(STATUS "[CMAKE] CMAKE_PREFIX_PATH           = ${CMAKE_PREFIX_PATH}")
message(STATUS "[SYSTEM] (HOST) SYSTEM NAME         = ${CMAKE_HOST_SYSTEM_NAME}")
message(STATUS "[SYSTEM] (HOST) SYSTEM VERSION      = ${CMAKE_HOST_SYSTEM_VERSION}")
message(STATUS "[SYSTEM] (TARGET) SYSTEM NAME       = ${CMAKE_SYSTEM_NAME}")
message(STATUS "[SYSTEM] (TARGET) SYSTEM VERSION    = ${CMAKE_SYSTEM_VERSION}")
message(STATUS "[PROJECT] SOURCE_DIR                = ${CMAKE_CURRENT_SOURCE_DIR}")
message(STATUS "[PROJECT] BUILD_TYPE                = ${CMAKE_BUILD_TYPE}")
message(STATUS "[PROJECT] TOOLCHAIN_FILE            = ${CMAKE_TOOLCHAIN_FILE}")
message(STATUS "[PROJECT] QT_HOST_PATH              = ${QT_HOST_PATH}")

################################################################################

find_package(Qt6 REQUIRED COMPONENTS Core Gui Qml Quick QuickControls2 Svg)

qt_standard_project_setup(REQUIRES 6.4)

qt_add_executable(${CMAKE_PROJECT_NAME}
    src/SettingsManager.cpp src/SettingsManager.h
    src/main.cpp
    qml/qml.qrc
    qml/components.qrc
    i18n/i18n.qrc
    assets/assets.qrc
)

target_include_directories(${CMAKE_PROJECT_NAME} PUBLIC src/thirdparty/)

# AppUtils
add_subdirectory(src/thirdparty/AppUtils)
target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE AppUtils)

# MobileUI
add_subdirectory(src/thirdparty/MobileUI)
target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE MobileUI)

# MobileSharing
add_subdirectory(src/thirdparty/MobileSharing)
target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE MobileSharing)

# SingleApplication
set(QAPPLICATION_CLASS QGuiApplication)
add_subdirectory(src/thirdparty/SingleApplication)
target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE SingleApplication)

# Qt
target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE
    Qt6::Core
    Qt6::Gui
    Qt6::Qml
    Qt6::Quick
    Qt6::QuickControls2
    Qt6::Svg
)

################################################################################

## Android
if(ANDROID)
    set_target_properties(${CMAKE_PROJECT_NAME} PROPERTIES
        QT_ANDROID_ABIS "armeabi-v7a;arm64-v8a;x86;x86_64"
        QT_ANDROID_BUILD_ALL_ABIS ON
        QT_ANDROID_MIN_SDK_VERSION 23
        QT_ANDROID_TARGET_SDK_VERSION 34
        QT_ANDROID_PACKAGE_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/assets/android/"
    )
endif()

#if(APPLE)
#    set(CMAKE_XCODE_ATTRIBUTE_CODE_SIGNING_REQUIRED "NO")
#    set(CMAKE_XCODE_ATTRIBUTE_CODE_SIGN_IDENTITY "")
#    set(CMAKE_XCODE_ATTRIBUTE_DEVELOPMENT_TEAM "")
#    set(CMAKE_XCODE_ATTRIBUTE_PROVISIONING_PROFILE "")
#endif()

## macOS
if(APPLE AND NOT IOS)
    set(CMAKE_XCODE_ATTRIBUTE_PRODUCT_BUNDLE_IDENTIFIER "io.emeric.qmlapptemplate")
    set(CMAKE_XCODE_ATTRIBUTE_MARKETING_VERSION "${PROJECT_VERSION}")

    set(CMAKE_OSX_ARCHITECTURES "x86_64;arm64")
    set(CMAKE_OSX_DEPLOYMENT_TARGET "11.0")
    set(CMAKE_XCODE_ATTRIBUTE_INFOPLIST_FILE "${CMAKE_CURRENT_SOURCE_DIR}/assets/macos/Info.plist")
    set(CMAKE_XCODE_ATTRIBUTE_CODE_SIGN_ENTITLEMENTS "${CMAKE_CURRENT_SOURCE_DIR}/assets/macos/${CMAKE_PROJECT_NAME}.entitlements")

    set_target_properties(${CMAKE_PROJECT_NAME} PROPERTIES
        MACOSX_BUNDLE ON
    )
endif()

## iOS
if(IOS)
    set(CMAKE_OSX_ARCHITECTURES "arm64")
    set(CMAKE_OSX_SYSROOT "iphoneos")
    set(CMAKE_OSX_DEPLOYMENT_TARGET "14.0")
    set(CMAKE_XCODE_ATTRIBUTE_IPHONEOS_DEPLOYMENT_TARGET "14.0")
    set(CMAKE_XCODE_ATTRIBUTE_TARGETED_DEVICE_FAMILY "1,2") # iPhone,iPad
    set(CMAKE_XCODE_ATTRIBUTE_INFOPLIST_FILE "${CMAKE_CURRENT_SOURCE_DIR}/assets/ios/Info.plist")

    set_target_properties(${CMAKE_PROJECT_NAME} PROPERTIES
        MACOSX_BUNDLE ON
        # Old way ???
        MACOSX_BUNDLE_GUI_IDENTIFIER            "io.emeric.qmlapptemplate"
        MACOSX_BUNDLE_BUNDLE_NAME               ${CMAKE_PROJECT_NAME}
        MACOSX_BUNDLE_BUNDLE_VERSION            ${PROJECT_VERSION}
        MACOSX_BUNDLE_SHORT_VERSION_STRING      ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
        MACOSX_BUNDLE_COPYRIGHT                 "Copyright © 2024 Emeric Grange"
        MACOSX_BUNDLE_INFO_PLIST                "${CMAKE_CURRENT_SOURCE_DIR}/assets/ios/Info.plist"
        #MACOSX_BUNDLE_INFO_PLIST                "${CMAKE_CURRENT_SOURCE_DIR}/assets/ios/Info.plist.in"
        #QT_IOS_LAUNCH_SCREEN                    "${CMAKE_CURRENT_SOURCE_DIR}/assets/ios/LaunchScreen.storyboard"
        # New Xcode attributes ???
        XCODE_ATTRIBUTE_PRODUCT_BUNDLE_IDENTIFIER           "io.emeric.qmlapptemplate"
        XCODE_ATTRIBUTE_PRODUCT_NAME                        ${CMAKE_PROJECT_NAME}
        XCODE_ATTRIBUTE_CURRENT_PROJECT_VERSION             ${PROJECT_VERSION}
        XCODE_ATTRIBUTE_MARKETING_VERSION                   ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
        XCODE_ATTRIBUTE_ASSETCATALOG_COMPILER_APPICON_NAME  "AppIcon"
        XCODE_ATTRIBUTE_IPHONEOS_DEPLOYMENT_TARGET          "14.0"
        XCODE_ATTRIBUTE_TARGETED_DEVICE_FAMILY              "1,2"   # iPhone,iPad
        XCODE_ATTRIBUTE_INFOPLIST_KEY_CFBundleDisplayName       ${CMAKE_PROJECT_NAME}
        XCODE_ATTRIBUTE_INFOPLIST_KEY_LSApplicationCategoryType "public.app-category.mycategory"
        XCODE_ATTRIBUTE_GCC_GENERATE_DEBUGGING_SYMBOLS      "YES"
    )
endif()

## Windows
if(WIN32)
    set_target_properties(${CMAKE_PROJECT_NAME} PROPERTIES
        WIN32_EXECUTABLE ON
    )

    target_compile_definitions(${CMAKE_PROJECT_NAME} PRIVATE
        _USE_MATH_DEFINES
    )
endif()

## Debug or release
if(CMAKE_BUILD_TYPE STREQUAL Release)
    target_compile_definitions(${CMAKE_PROJECT_NAME} PRIVATE
        NDEBUG
        QT_NO_DEBUG
        QT_NO_DEBUG_OUTPUT
    )
endif()

################################################################################

if(lupdate_only)
    target_sources(${CMAKE_PROJECT_NAME} PUBLIC
        qml/*.js qml/*.qml
        qml/components/*.qml
        qml/components_generic/*.qml
        qml/components_js/*.js
    )
endif()

################################################################################

install(TARGETS ${CMAKE_PROJECT_NAME}
    BUNDLE DESTINATION .
    ARCHIVE DESTINATION .
    LIBRARY DESTINATION .
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

qt_generate_deploy_qml_app_script(
    TARGET ${CMAKE_PROJECT_NAME}
    OUTPUT_SCRIPT deploy_script
    NO_UNSUPPORTED_PLATFORM_ERROR
    DEPLOY_USER_QML_MODULES_ON_UNSUPPORTED_PLATFORM
    MACOS_BUNDLE_POST_BUILD
)
install(SCRIPT ${deploy_script})

################################################################################
