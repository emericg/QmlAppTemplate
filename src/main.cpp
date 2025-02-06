
#include "SettingsManager.h"

#include <utils_app.h>
#include <utils_screen.h>
#include <utils_sysinfo.h>
#include <utils_language.h>
#include <utils_wifi.h>
#include <utils_os_macos_dock.h>

#include <MobileUI>
#include <SingleApplication>

#include <QtGlobal>
#include <QLibraryInfo>
#include <QVersionNumber>

#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQuickWindow>
#include <QQuickStyle>
#include <QSurfaceFormat>

/* ************************************************************************** */

int main(int argc, char *argv[])
{
    // Hacks ///////////////////////////////////////////////////////////////////

#if defined(Q_OS_LINUX) && !defined(Q_OS_ANDROID)
    // NVIDIA driver suspend&resume hack
    auto format = QSurfaceFormat::defaultFormat();
    format.setOption(QSurfaceFormat::ResetNotification);
    QSurfaceFormat::setDefaultFormat(format);
#endif

#if !defined(Q_OS_ANDROID) && !defined(Q_OS_IOS)
    // Qt 6.6+ mouse wheel hack
    qputenv("QT_QUICK_FLICKABLE_WHEEL_DECELERATION", "10000");
#endif

    // Force OpenGL for Qt WebEngine or the MapLibre plugin
    //qputenv("QSG_RHI_BACKEND", "opengl");

    // DEBUG ///////////////////////////////////////////////////////////////////

    //qputenv("QSG_INFO", "1");               // print Qt Scene Graph info
    //qputenv("QT_QPA_EGLFS_DEBUG", "1");     // print Qt Platform Abstraction EGL debug info
    //qputenv("QT_DEBUG_PLUGINS", "1");       // print Qt plugins info

    // GUI application /////////////////////////////////////////////////////////

    SingleApplication app(argc, argv, true);

    // Application name
    app.setApplicationName("QmlAppTemplate");
    app.setOrganizationName("emeric");
    app.setOrganizationDomain("emeric");

#if !defined(Q_OS_ANDROID) && !defined(Q_OS_IOS)
    app.setWindowIcon(QIcon(":/assets/gfx/logos/logo.svg"));
    app.setApplicationDisplayName("QmlAppTemplate");
#endif

    // Init app components
    SettingsManager *sm = SettingsManager::getInstance();
    if (!sm)
    {
        qWarning() << "Cannot init app components!";
        return EXIT_FAILURE;
    }

    // Init generic utils
    UtilsApp *utilsApp = UtilsApp::getInstance();
    UtilsScreen *utilsScreen = UtilsScreen::getInstance();
    UtilsSysInfo *utilsSysInfo = UtilsSysInfo::getInstance();
    UtilsWiFi *utilsWiFi = UtilsWiFi::getInstance();
    UtilsLanguage *utilsLanguage = UtilsLanguage::getInstance();
    if (!utilsApp || !utilsScreen || !utilsSysInfo || !utilsLanguage)
    {
        qWarning() << "Cannot init generic utils!";
        return EXIT_FAILURE;
    }

    // Translate the application
    utilsLanguage->loadLanguage(sm->getAppLanguage());

    // Force QtQuick components style? // Some styles are only available on target OS
    // Basic // Fusion // Imagine // macOS // iOS // Material // Universal // Windows
    //QQuickStyle::setStyle("Universal");

    MobileUI::registerQML();

    // ThemeEngine
    qmlRegisterSingletonType(QUrl("qrc:/ComponentLibrary/ThemeEngine.qml"), "ComponentLibrary", 1, 0, "Theme");

    QQmlApplicationEngine engine;
    engine.addImportPath(":/");
    engine.addImportPath(":/QmlAppTemplate");
    engine.addImportPath(":/ComponentLibrary");

    //qDebug() << engine.importPathList();
    //QDirIterator qrc(":", QDirIterator::Subdirectories);
    //while(qrc.hasNext()) { qDebug() << qrc.next(); }

    QQmlContext *engine_context = engine.rootContext();
    engine_context->setContextProperty("settingsManager", sm);
    engine_context->setContextProperty("utilsApp", utilsApp);
    engine_context->setContextProperty("utilsLanguage", utilsLanguage);
    engine_context->setContextProperty("utilsScreen", utilsScreen);
    engine_context->setContextProperty("utilsSysInfo", utilsSysInfo);
    engine_context->setContextProperty("utilsWiFi", utilsWiFi);

    // Load the main view
#if defined(Q_OS_ANDROID) || defined(Q_OS_IOS) || defined(FORCE_MOBILE_UI)
    engine.load(QUrl(QStringLiteral("qrc:/MobileApplication.qml")));
    //engine.loadFromModule("QmlAppTemplate", "MobileApplication");
#else
    engine.load(QUrl(QStringLiteral("qrc:/DesktopApplication.qml")));
    //engine.loadFromModule("QmlAppTemplate", "DesktopApplication");
#endif

    if (engine.rootObjects().isEmpty())
    {
        qWarning() << "Cannot init QmlApplicationEngine!";
        return EXIT_FAILURE;
    }

    // For i18n retranslate
    utilsLanguage->setQmlEngine(&engine);

    // app info
    utilsApp->setQuickWindow(qobject_cast<QQuickWindow *>(engine.rootObjects().value(0)));

#if !defined(Q_OS_ANDROID) && !defined(Q_OS_IOS) // desktop section

    // QQuickWindow must be valid at this point
    QQuickWindow *window = qobject_cast<QQuickWindow *>(engine.rootObjects().value(0));
    if (!window) return EXIT_FAILURE;

    // React to secondary instances
    QObject::connect(&app, &SingleApplication::instanceStarted, window, &QQuickWindow::show);
    QObject::connect(&app, &SingleApplication::instanceStarted, window, &QQuickWindow::raise);

#if defined(Q_OS_MACOS)
    // macOS dock
    MacOSDockHandler *dockIconHandler = MacOSDockHandler::getInstance();
    QObject::connect(dockIconHandler, &MacOSDockHandler::dockIconClicked, window, &QQuickWindow::show);
    QObject::connect(dockIconHandler, &MacOSDockHandler::dockIconClicked, window, &QQuickWindow::raise);
#endif

#endif // desktop section

#if defined(Q_OS_ANDROID)
    QNativeInterface::QAndroidApplication::hideSplashScreen(333);
#endif

    return app.exec();
}

/* ************************************************************************** */
