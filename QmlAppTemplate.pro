TARGET  = QmlAppTemplate

VERSION = 0.4
DEFINES+= APP_VERSION=\\\"$$VERSION\\\"
DEFINES+= APP_NAME=\\\"$$TARGET\\\"

CONFIG += c++17
QT     += core qml quick quickcontrols2 svg

# Validate Qt version
!versionAtLeast(QT_VERSION, 6.0) : error("You need at least Qt version 6.0 for $${TARGET}")
!versionAtLeast(QT_VERSION, 6.3) : warning("Many $${TARGET} features will require at least Qt version 6.3")

# Project features #############################################################

# Use Qt Quick compiler
ios | android { CONFIG += qtquickcompiler }

win32 { DEFINES += _USE_MATH_DEFINES }

# AppUtils
include(src/thirdparty/AppUtils/AppUtils.pri)

# MobileUI and MobileSharing for mobile OS
include(src/thirdparty/MobileUI/MobileUI.pri)
include(src/thirdparty/MobileSharing/MobileSharing.pri)

# SingleApplication for desktop OS
DEFINES += QAPPLICATION_CLASS=QGuiApplication
include(src/thirdparty/SingleApplication/SingleApplication.pri)

# Project files ################################################################

SOURCES  += src/main.cpp \
            src/SettingsManager.cpp

HEADERS  += src/SettingsManager.h

INCLUDEPATH += src/

RESOURCES   += qml/qml.qrc \
               i18n/i18n.qrc \
               assets/assets.qrc

OTHER_FILES += .gitignore \
               .github/workflows/builds.yml \
               deploy_linux.sh \
               deploy_macos.sh \
               deploy_windows.sh

lupdate_only {
    SOURCES += qml/*.qml qml/*.js \
               qml/components/*.qml qml/components_generic/*.qml qml/components_js/*.js
}

# Build settings ###############################################################

unix {
    # Enables AddressSanitizer
    #QMAKE_CXXFLAGS += -fsanitize=address,undefined
    #QMAKE_LFLAGS += -fsanitize=address,undefined

    #QMAKE_CXXFLAGS += -Wno-nullability-completeness
}

DEFINES += QT_DEPRECATED_WARNINGS
DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

CONFIG(release, debug|release) : DEFINES += NDEBUG QT_NO_DEBUG QT_NO_DEBUG_OUTPUT

# Build artifacts ##############################################################

CONFIG(release, debug|release) : BUILD_MODE = "RELEASE"
CONFIG(debug, debug|release) : BUILD_MODE = "DEBUG"

OBJECTS_DIR = build/$${BUILD_MODE}_$${QT_ARCH}/obj/
MOC_DIR     = build/$${BUILD_MODE}_$${QT_ARCH}/moc/
RCC_DIR     = build/$${BUILD_MODE}_$${QT_ARCH}/rcc/
UI_DIR      = build/$${BUILD_MODE}_$${QT_ARCH}/ui/
QMLCACHE_DIR= build/$${BUILD_MODE}_$${QT_ARCH}/qml/

DESTDIR     = bin/

################################################################################
# Application deployment and installation steps

linux:!android {
    TARGET = $$lower($${TARGET})

    # Automatic application packaging # Needs linuxdeployqt installed
    #system(linuxdeployqt $${OUT_PWD}/$${DESTDIR}/ -qmldir=qml/)

    # Application packaging # Needs linuxdeployqt installed
    #deploy.commands = $${OUT_PWD}/$${DESTDIR}/ -qmldir=qml/
    #install.depends = deploy
    #QMAKE_EXTRA_TARGETS += install deploy

    # Installation steps
    isEmpty(PREFIX) { PREFIX = /usr/local }
    target_app.files       += $${OUT_PWD}/$${DESTDIR}/$$lower($${TARGET})
    target_app.path         = $${PREFIX}/bin/
    target_appentry.files  += $${OUT_PWD}/assets/linux/$$lower($${TARGET}).desktop
    target_appentry.path    = $${PREFIX}/share/applications
    target_appdata.files   += $${OUT_PWD}/assets/linux/$$lower($${TARGET}).appdata.xml
    target_appdata.path     = $${PREFIX}/share/appdata
    target_icon_appimage.files += $${OUT_PWD}/assets/linux/$$lower($${TARGET}).svg
    target_icon_appimage.path   = $${PREFIX}/share/pixmaps/
    target_icon_flatpak.files  += $${OUT_PWD}/assets/linux/$$lower($${TARGET}).svg
    target_icon_flatpak.path    = $${PREFIX}/share/icons/hicolor/scalable/apps/
    INSTALLS += target_app target_appentry target_appdata target_icon_appimage target_icon_flatpak

    # Clean appdir/ and bin/ directories
    #QMAKE_CLEAN += $${OUT_PWD}/$${DESTDIR}/$$lower($${TARGET})
    #QMAKE_CLEAN += $${OUT_PWD}/appdir/
}

macx {
    #QMAKE_MACOSX_DEPLOYMENT_TARGET = 10.12
    #message("QMAKE_MACOSX_DEPLOYMENT_TARGET: $$QMAKE_MACOSX_DEPLOYMENT_TARGET")

    # Bundle name
    QMAKE_TARGET_BUNDLE_PREFIX = com.emeric
    QMAKE_BUNDLE = qmlapptemplate

    # OS icons
    ICON = $${PWD}/assets/macos/$$lower($${TARGET}).icns
    #QMAKE_ASSET_CATALOGS_APP_ICON = "AppIcon"
    #QMAKE_ASSET_CATALOGS = $${PWD}/assets/macos/Images.xcassets

    # OS infos
    QMAKE_INFO_PLIST = $${PWD}/assets/macos/Info.plist

    # OS entitlement (sandbox and stuff)
    ENTITLEMENTS.name = CODE_SIGN_ENTITLEMENTS
    ENTITLEMENTS.value = $${PWD}/assets/macos/$$lower($${TARGET}).entitlements
    QMAKE_MAC_XCODE_SETTINGS += ENTITLEMENTS

    # Target architecture
    #QMAKE_APPLE_DEVICE_ARCHS = "x86_64;arm64" # x86_64, arm64

    #======== Automatic bundle packaging

    # Deploy step (app bundle packaging)
    deploy.commands = macdeployqt $${OUT_PWD}/$${DESTDIR}/$${TARGET}.app -qmldir=qml/ -appstore-compliant
    install.depends = deploy
    QMAKE_EXTRA_TARGETS += install deploy

    # Installation step (note: app bundle packaging)
    isEmpty(PREFIX) { PREFIX = /usr/local }
    target.files += $${OUT_PWD}/${DESTDIR}/${TARGET}.app
    target.path = $$(HOME)/Applications
    INSTALLS += target

    # Clean step
    QMAKE_DISTCLEAN += -r $${OUT_PWD}/${DESTDIR}/${TARGET}.app
}

win32 {
    # OS icon
    RC_ICONS = $${PWD}/assets/windows/$$lower($${TARGET}).ico

    # Deploy step
    deploy.commands = $$quote(windeployqt $${OUT_PWD}/$${DESTDIR}/ --qmldir qml/)
    install.depends = deploy
    QMAKE_EXTRA_TARGETS += install deploy

    # Installation step
    # TODO

    # Clean step
    # TODO
}

android {
    # ANDROID_TARGET_ARCH: [x86_64, armeabi-v7a, arm64-v8a]
    #message("ANDROID_TARGET_ARCH: $$ANDROID_TARGET_ARCH")

    # Bundle name
    QMAKE_TARGET_BUNDLE_PREFIX = com.emeric
    QMAKE_BUNDLE = qmlapptemplate

    OTHER_FILES += assets/android/src/com/emeric/utils/QShareUtils.java \
                   assets/android/src/com/emeric/utils/QSharePathResolver.java

    DISTFILES += $${PWD}/assets/android/AndroidManifest.xml \
                 $${PWD}/assets/android/gradle.properties \
                 $${PWD}/assets/android/build.gradle

    ANDROID_PACKAGE_SOURCE_DIR = $${PWD}/assets/android
}

ios {
    #QMAKE_IOS_DEPLOYMENT_TARGET = 11.0
    #message("QMAKE_IOS_DEPLOYMENT_TARGET: $$QMAKE_IOS_DEPLOYMENT_TARGET")

    # Bundle name
    QMAKE_TARGET_BUNDLE_PREFIX = com.emeric.ios
    QMAKE_BUNDLE = qmlapptemplate

    # OS infos
    QMAKE_INFO_PLIST = $${PWD}/assets/ios/Info.plist
    QMAKE_APPLE_TARGETED_DEVICE_FAMILY = 1,2 # 1: iPhone / 2: iPad / 1,2: Universal

    # OS icons
    #QMAKE_ASSET_CATALOGS_APP_ICON = "AppIcon"
    #QMAKE_ASSET_CATALOGS = $${PWD}/assets/ios/Images.xcassets

    # iOS launch screen
    #AppLaunchScreen.files += $${PWD}/assets/ios/AppLaunchScreen.storyboard
    #QMAKE_BUNDLE_DATA += AppLaunchScreen

    # iOS developer settings
    exists($${PWD}/assets/ios/ios_signature.pri) {
        # Must contain values for:
        # QMAKE_DEVELOPMENT_TEAM
        # QMAKE_PROVISIONING_PROFILE
        include($${PWD}/assets/ios/ios_signature.pri)
    }
}
