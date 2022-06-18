/*!
 * COPYRIGHT (C) 2022 Emeric Grange - All Rights Reserved
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * \date      2022
 * \author    Emeric Grange <emeric.grange@gmail.com>
 */

#include "SettingsManager.h"

#include <utils_app.h>
#include <utils_screen.h>
#include <utils_sysinfo.h>
#include <utils_language.h>
#include <utils_os_macosdock.h>

#include <MobileUI>
#include <MobileSharing>
#include <SingleApplication>

#include <QtGlobal>
#include <QLibraryInfo>
#include <QVersionNumber>

#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQuickWindow>
#include <QQuickStyle>
#include <QSurfaceFormat>

#if defined(Q_OS_ANDROID) && (QT_VERSION < QT_VERSION_CHECK(6, 0, 0))
#include <QtAndroid>
#endif

/* ************************************************************************** */

int main(int argc, char *argv[])
{
    // GUI application /////////////////////////////////////////////////////////

#if defined(Q_OS_LINUX) && !defined(Q_OS_ANDROID)
    // NVIDIA driver suspend&resume hack
    auto format = QSurfaceFormat::defaultFormat();
    format.setOption(QSurfaceFormat::ResetNotification);
    QSurfaceFormat::setDefaultFormat(format);
#endif

    SingleApplication app(argc, argv);

    // Application name
    app.setApplicationName("QmlAppTemplate");
    app.setApplicationDisplayName("QmlAppTemplate");
    app.setOrganizationName("emeric");
    app.setOrganizationDomain("emeric");

#if !defined(Q_OS_ANDROID) && !defined(Q_OS_IOS)
    // Application icon
    QIcon appIcon(":/assets/logos/logo.svg");
    app.setWindowIcon(appIcon);
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
    UtilsSysinfo *utilsSysinfo = UtilsSysinfo::getInstance();
    UtilsLanguage *utilsLanguage = UtilsLanguage::getInstance();
    if (!utilsScreen || !utilsApp || !utilsLanguage)
    {
        qWarning() << "Cannot init generic utils!";
        return EXIT_FAILURE;
    }

    // Translate the application
    utilsLanguage->loadLanguage(sm->getAppLanguage());

    // ThemeEngine
    qmlRegisterSingletonType(QUrl("qrc:/qml/ThemeEngine.qml"), "ThemeEngine", 1, 0, "Theme");

    //QQuickStyle::setStyle("Material");

    MobileUI::registerQML();

    // Then we start the UI
    QQmlApplicationEngine engine;
    QQmlContext *engine_context = engine.rootContext();

    engine_context->setContextProperty("settingsManager", sm);
    engine_context->setContextProperty("utilsApp", utilsApp);
    engine_context->setContextProperty("utilsLanguage", utilsLanguage);
    engine_context->setContextProperty("utilsScreen", utilsScreen);
    engine_context->setContextProperty("utilsSysinfo", utilsSysinfo);

    // Load the main view
#if defined(Q_OS_ANDROID) || defined(Q_OS_IOS) || defined(FORCE_MOBILE_UI)
    //ShareUtils *mShareUtils = new ShareUtils();
    //engine_context->setContextProperty("utilsShare", mShareUtils);
    engine.load(QUrl(QStringLiteral("qrc:/qml/MobileApplication.qml")));
#else
    engine.load(QUrl(QStringLiteral("qrc:/qml/DesktopApplication.qml")));
#endif
    if (engine.rootObjects().isEmpty())
    {
        qWarning() << "Cannot init QmlApplicationEngine!";
        return EXIT_FAILURE;
    }

    // For i18n retranslate
    utilsLanguage->setQmlEngine(&engine);

    // Notch handling // QQuickWindow must be valid at this point
    QQuickWindow *window = qobject_cast<QQuickWindow *>(engine.rootObjects().value(0));
    engine_context->setContextProperty("quickWindow", window);

#if !defined(Q_OS_ANDROID) && !defined(Q_OS_IOS) // desktop section

#if defined(Q_OS_MACOS)
    MacOSDockHandler *dockIconHandler = MacOSDockHandler::getInstance();
    QObject::connect(dockIconHandler, &MacOSDockHandler::dockIconClicked, window, &QQuickWindow::show);
    QObject::connect(dockIconHandler, &MacOSDockHandler::dockIconClicked, window, &QQuickWindow::raise);
#endif

#endif // desktop section

#if defined(Q_OS_ANDROID)
#if (QT_VERSION < QT_VERSION_CHECK(6, 0, 0))
    QtAndroid::hideSplashScreen(333);
#else
    QNativeInterface::QAndroidApplication::hideSplashScreen(333);
#endif
#endif

    return app.exec();
}

/* ************************************************************************** */
