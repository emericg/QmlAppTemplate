cmake_minimum_required(VERSION 3.20)

project(QmlAppTemplate VERSION 0.8 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(APP_NAME ${PROJECT_NAME})
set(APP_VERSION ${PROJECT_VERSION})

################################################################################

message(STATUS ">>> BUILDING ${PROJECT_NAME} v${PROJECT_VERSION} >>>")
message(STATUS "[CMAKE] CMAKE_VERSION               = ${CMAKE_VERSION}")
message(STATUS "[CMAKE] CMAKE_PREFIX_PATH           = ${CMAKE_PREFIX_PATH}")
message(STATUS "[BUILD] QT_HOST_PATH                = ${QT_HOST_PATH}")
message(STATUS "[BUILD] TOOLCHAIN_FILE              = ${CMAKE_TOOLCHAIN_FILE}")
message(STATUS "[BUILD] BUILD_TYPE                  = ${CMAKE_BUILD_TYPE}")
message(STATUS "[SYSTEM] (HOST) SYSTEM NAME         = ${CMAKE_HOST_SYSTEM_NAME}")
message(STATUS "[SYSTEM] (HOST) SYSTEM VERSION      = ${CMAKE_HOST_SYSTEM_VERSION}")
message(STATUS "[SYSTEM] (HOST) SYSTEM PROCESSOR    = ${CMAKE_HOST_SYSTEM_PROCESSOR}")
message(STATUS "[SYSTEM] (TARGET) SYSTEM NAME       = ${CMAKE_SYSTEM_NAME}")
message(STATUS "[SYSTEM] (TARGET) SYSTEM VERSION    = ${CMAKE_SYSTEM_VERSION}")
message(STATUS "[SYSTEM] (TARGET) SYSTEM PROCESSOR  = ${CMAKE_SYSTEM_PROCESSOR}")
message(STATUS "[TOP PROJECT] CMAKE_PROJECT_NAME    = ${CMAKE_PROJECT_NAME}")
message(STATUS "[TOP PROJECT] CMAKE_PROJECT_VERSION = ${CMAKE_PROJECT_VERSION}")
message(STATUS "[TOP PROJECT] CMAKE_SOURCE_DIR      = ${CMAKE_SOURCE_DIR}")
message(STATUS "[PROJECT] PROJECT_NAME              = ${PROJECT_NAME}")
message(STATUS "[PROJECT] PROJECT_VERSION           = ${PROJECT_VERSION}")
message(STATUS "[PROJECT] PROJECT_SOURCE_DIR        = ${PROJECT_SOURCE_DIR}")
message(STATUS "[PROJECT] CMAKE_CURRENT_SOURCE_DIR  = ${CMAKE_CURRENT_SOURCE_DIR}")

################################################################################

find_package(Qt6 REQUIRED COMPONENTS Core Gui Svg Qml Quick QuickControls2)
find_package(Qt6 REQUIRED COMPONENTS LinguistTools)

qt_standard_project_setup(REQUIRES 6.8
                          I18N_SOURCE_LANGUAGE en
                          I18N_TRANSLATED_LANGUAGES fr)

qt_policy(SET QTP0001 NEW)
qt_policy(SET QTP0002 NEW)
qt_policy(SET QTP0003 NEW)
qt_policy(SET QTP0004 NEW)

# Set app desktop icons
if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
    set(app_icon_windows "${PROJECT_SOURCE_DIR}/assets/windows/${PROJECT_NAME}.rc")
elseif(CMAKE_SYSTEM_NAME STREQUAL "Darwin")
    set(app_icon_macos "${PROJECT_SOURCE_DIR}/assets/macos/${PROJECT_NAME}.icns")
endif()

qt_add_executable(${PROJECT_NAME}
    src/main.cpp
    src/SettingsManager.cpp src/SettingsManager.h

    ${app_icon_macos}
    ${app_icon_windows}
    assets/assets.qrc
    thirdparty/IconLibrary/IconLibrary_material.qrc
)

qt_add_qml_module(${PROJECT_NAME}
    URI ${PROJECT_NAME}
    NO_PLUGIN
    QML_FILES
        qml/MobileApplication.qml
        qml/MobileHeader.qml
        qml/MobileDrawer.qml
        qml/MobilePermissions.qml
        qml/MobileMenu.qml
        qml/MobileExit.qml

        qml/DesktopApplication.qml
        qml/DesktopHeader.qml
        qml/DesktopSidebar.qml

        qml/ScreenMainView.qml
        qml/ScreenMobileComponents.qml
        qml/ScreenDesktopComponents.qml
        qml/ScreenPlayground.qml
        qml/ScreenFontInfos.qml
        qml/ScreenHostInfos.qml
        qml/ScreenSettings.qml
        qml/ScreenAbout.qml

        qml/PageButtons.qml
        qml/PageColors.qml
        qml/PageDateTime.qml
        qml/PageDialogs.qml
        qml/PageIndicators.qml
        qml/PageSelectors.qml
        qml/PageSliders.qml
        qml/PageTextFields.qml
        qml/PageTickers.qml

        qml/popups/PopupMessage.qml
        qml/popups/PopupChoice.qml
        qml/popups/PopupBirthDate.qml
        qml/popups/PopupDate.qml
        qml/popups/PopupTime.qml

    SOURCES
        src/SettingsManager.cpp src/SettingsManager.h
)

qt_add_translations(${PROJECT_NAME}
    TS_FILE_BASE ${PROJECT_NAME}
    TS_FILE_DIR ${PROJECT_SOURCE_DIR}/i18n/
    RESOURCE_PREFIX "/i18n"
)

################################################################################

# "Other Files" macro
function(add_other_files target)
    foreach(file IN LISTS ARGN)
        target_sources(${target} PRIVATE ${file})
        source_group("Other Files" FILES ${file})
    endforeach()
endfunction()

add_other_files(${PROJECT_NAME}
    README.md LICENSE.md
    deploy_linux.sh deploy_macos.sh deploy_windows.sh
    .github/workflows/builds_desktop_cmake.yml
    .github/workflows/builds_mobile_cmake.yml
    .github/workflows/flatpak.yml
    .gitignore
)

################################################################################

# AppUtils
set(UTILS_QT_RHI ON)
set(UTILS_DOCK_ENABLED ON)
add_subdirectory(thirdparty/AppUtils)
target_link_libraries(${PROJECT_NAME} PRIVATE AppUtils AppUtils_plugin)

# MobileUI
add_subdirectory(thirdparty/MobileUI)
target_link_libraries(${PROJECT_NAME} PRIVATE MobileUI MobileUI_plugin)

# ComponentLibrary
add_subdirectory(thirdparty/ComponentLibrary)
target_link_libraries(${PROJECT_NAME} PRIVATE ComponentLibrary_plugin)

# Qt libraries
target_link_libraries(${PROJECT_NAME} PRIVATE
    Qt6::Core
    Qt6::Gui
    Qt6::Svg
    Qt6::Qml
    Qt6::Quick
    Qt6::QuickControls2
)

target_include_directories(${PROJECT_NAME} PRIVATE src/)
target_include_directories(${PROJECT_NAME} PRIVATE thirdparty/)

# Qt official hacks...
set(QML_IMPORT_PATH
    "${CMAKE_BINARY_DIR}/thirdparty/"
    "${CMAKE_BINARY_DIR}/thirdparty/MobileUI"
    "${CMAKE_BINARY_DIR}/thirdparty/ComponentLibrary"
    CACHE STRING "QML Modules import paths" FORCE)

# Qt official hacks...
set(QT_QML_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR})

################################################################################

## Release build? Set "no debug" macros
target_compile_definitions(${PROJECT_NAME} PRIVATE
    $<$<CONFIG:Release>:NDEBUG>
    $<$<CONFIG:Release>:QT_NO_DEBUG>
    $<$<CONFIG:Release>:QT_NO_DEBUG_OUTPUT>
)

################################################################################

include(GNUInstallDirs)

## Linux
if(CMAKE_SYSTEM_NAME STREQUAL "Linux")
    install(FILES ${PROJECT_SOURCE_DIR}/assets/linux/${PROJECT_NAME}.desktop DESTINATION ${CMAKE_INSTALL_DATAROOTDIR}/applications/)
    install(FILES ${PROJECT_SOURCE_DIR}/assets/linux/${PROJECT_NAME}.appdata.xml DESTINATION ${CMAKE_INSTALL_DATAROOTDIR}/appdata/)
    install(FILES ${PROJECT_SOURCE_DIR}/assets/linux/${PROJECT_NAME}.svg DESTINATION ${CMAKE_INSTALL_DATAROOTDIR}/pixmaps/)
    install(FILES ${PROJECT_SOURCE_DIR}/assets/linux/${PROJECT_NAME}.svg DESTINATION ${CMAKE_INSTALL_DATAROOTDIR}/icons/hicolor/scalable/apps/)
    install(FILES ${PROJECT_SOURCE_DIR}/LICENSE.md DESTINATION ${CMAKE_INSTALL_DATAROOTDIR}/licenses/${PROJECT_NAME}/)
endif()

## macOS
if(CMAKE_SYSTEM_NAME STREQUAL "Darwin")
    #set(CMAKE_OSX_ARCHITECTURES "x86_64;arm64")
    set(CMAKE_OSX_DEPLOYMENT_TARGET "12.0")

    set(app_icon_macos "${PROJECT_SOURCE_DIR}/assets/macos/${PROJECT_NAME}.icns")
    set_source_files_properties(${app_icon_macos} PROPERTIES MACOSX_PACKAGE_LOCATION "Resources")

    set_target_properties(${PROJECT_NAME} PROPERTIES
        MACOSX_BUNDLE ON
        MACOSX_BUNDLE_INFO_PLIST "${PROJECT_SOURCE_DIR}/assets/macos/Info.plist"
        # New Xcode attributes (???)
        XCODE_ATTRIBUTE_PRODUCT_BUNDLE_IDENTIFIER           "io.emeric.qmlapptemplate"
        XCODE_ATTRIBUTE_PRODUCT_NAME                        ${PROJECT_NAME}
        XCODE_ATTRIBUTE_CURRENT_PROJECT_VERSION             ${PROJECT_VERSION}
        XCODE_ATTRIBUTE_MARKETING_VERSION                   ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
        XCODE_ATTRIBUTE_CODE_SIGN_ENTITLEMENTS             "${PROJECT_SOURCE_DIR}/assets/macos/${PROJECT_NAME}.entitlements"
    )
endif()

## Windows
if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
    set_target_properties(${PROJECT_NAME} PROPERTIES
        WIN32_EXECUTABLE ON
    )
endif()

################################################################################

## Android
if(CMAKE_SYSTEM_NAME STREQUAL "Android")
    set_target_properties(${PROJECT_NAME} PROPERTIES
        #QT_ANDROID_ABIS "armeabi-v7a;arm64-v8a;x86;x86_64"
        #QT_ANDROID_BUILD_ALL_ABIS ON
        QT_ANDROID_MIN_SDK_VERSION 28
        QT_ANDROID_TARGET_SDK_VERSION 36
        QT_ANDROID_PACKAGE_SOURCE_DIR "${PROJECT_SOURCE_DIR}/assets/android/"
    )

    # Support 16 KB page sizes / pre NDK28
    target_link_options(${PROJECT_NAME} PRIVATE "-Wl,-z,max-page-size=16384")

    ## Download SSL Libraries
    #include(FetchContent)
    #FetchContent_Declare(
    #    android_openssl
    #    DOWNLOAD_EXTRACT_TIMESTAMP true
    #    URL https://github.com/KDAB/android_openssl/archive/refs/heads/master.zip
    #)
    #FetchContent_MakeAvailable(android_openssl)

    ## Include SSL Libraries
    #include(${android_openssl_SOURCE_DIR}/android_openssl.cmake)
    #add_android_openssl_libraries(${PROJECT_NAME})
endif()

## iOS
if(CMAKE_SYSTEM_NAME STREQUAL "iOS")
    #set(app_icon_ios "${PROJECT_SOURCE_DIR}/assets/ios/Assets.xcassets")
    #set_source_files_properties(${app_icon_ios} PROPERTIES MACOSX_PACKAGE_LOCATION "Resources")

    set_target_properties(${PROJECT_NAME} PROPERTIES
        MACOSX_BUNDLE ON
        MACOSX_BUNDLE_INFO_PLIST "${PROJECT_SOURCE_DIR}/assets/ios/Info.plist"
        # Qt
        #QT_IOS_LAUNCH_SCREEN "${PROJECT_SOURCE_DIR}/assets/ios/LaunchScreen.storyboard"
        # New Xcode attributes (???)
        XCODE_ATTRIBUTE_PRODUCT_BUNDLE_IDENTIFIER           "io.emeric.qmlapptemplate"
        XCODE_ATTRIBUTE_PRODUCT_NAME                        ${PROJECT_NAME}
        XCODE_ATTRIBUTE_CURRENT_PROJECT_VERSION             ${PROJECT_VERSION}
        XCODE_ATTRIBUTE_MARKETING_VERSION                   ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
        XCODE_ATTRIBUTE_IPHONEOS_DEPLOYMENT_TARGET          "16.0"
        XCODE_ATTRIBUTE_TARGETED_DEVICE_FAMILY              "1,2" # iPhone,iPad
        XCODE_ATTRIBUTE_ASSETCATALOG_COMPILER_APPICON_NAME  "AppIcon"
        XCODE_ATTRIBUTE_GCC_GENERATE_DEBUGGING_SYMBOLS      "YES"
    )
endif()

################################################################################

# Output (build)
set_target_properties(${PROJECT_NAME} PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY "${CMAKE_SOURCE_DIR}/bin"
)

# Output (install)
install(TARGETS ${PROJECT_NAME}
    BUNDLE DESTINATION ${CMAKE_INSTALL_BINDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
)

# Output (automatic deployment, similar to running linuxdeploy / macdeployqt / windeployqt)
#qt_generate_deploy_qml_app_script(
#    TARGET ${PROJECT_NAME}
#    OUTPUT_SCRIPT deploy_script
#    MACOS_BUNDLE_POST_BUILD
#    NO_UNSUPPORTED_PLATFORM_ERROR
#    DEPLOY_USER_QML_MODULES_ON_UNSUPPORTED_PLATFORM
#)
#install(SCRIPT ${deploy_script})

################################################################################
