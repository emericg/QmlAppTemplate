
#include "SettingsManager.h"

#include <QCoreApplication>
#include <QQmlEngine>
#include <QJSEngine>
#include <QSettings>
#include <QLocale>
#include <QDebug>

/* ************************************************************************** */

SettingsManager *SettingsManager::instance = nullptr;

SettingsManager *SettingsManager::getInstance()
{
    if (instance == nullptr)
    {
        instance = new SettingsManager();
    }

    return instance;
}

SettingsManager *SettingsManager::create(QQmlEngine *, QJSEngine *)
{
    return getInstance();
}

SettingsManager::SettingsManager()
{
    readSettings();
}

SettingsManager::~SettingsManager()
{
    //
}

/* ************************************************************************** */
/* ************************************************************************** */

bool SettingsManager::readSettings()
{
    bool status = false;

    QSettings settings(QCoreApplication::organizationName(), QCoreApplication::applicationName());

    if (settings.status() == QSettings::NoError)
    {
#if !defined(Q_OS_ANDROID) && !defined(Q_OS_IOS)
        if (settings.contains("ApplicationWindow/x"))
            m_appPosition.setWidth(settings.value("ApplicationWindow/x").toInt());
        if (settings.contains("ApplicationWindow/y"))
            m_appPosition.setHeight(settings.value("ApplicationWindow/y").toInt());
        if (settings.contains("ApplicationWindow/width"))
            m_appSize.setWidth(settings.value("ApplicationWindow/width").toInt());
        if (settings.contains("ApplicationWindow/height"))
            m_appSize.setHeight(settings.value("ApplicationWindow/height").toInt());
        if (settings.contains("ApplicationWindow/visibility"))
            m_appVisibility = settings.value("ApplicationWindow/visibility").toUInt();

        if (m_appPosition.width() > 8192) m_appPosition.setWidth(100);
        if (m_appPosition.height() > 8192) m_appPosition.setHeight(100);
        if (m_appSize.width() > 8192) m_appSize.setWidth(1920);
        if (m_appSize.height() > 8192) m_appSize.setHeight(1080);
        if (m_appVisibility < 1 || m_appVisibility > 5) m_appVisibility = 1;
#endif
        if (settings.contains("settings/appTheme"))
            m_appTheme = settings.value("settings/appTheme").toString();

        if (settings.contains("settings/appThemeAuto"))
            m_appThemeAuto = settings.value("settings/appThemeAuto").toBool();

        if (settings.contains("settings/appThemeAutoMethod"))
            m_appThemeAutoMethod = settings.value("settings/appThemeAutoMethod").toUInt();

        if (settings.contains("settings/appUnitSystem"))
            m_appUnitSystem = settings.value("settings/appUnitSystem").toUInt();

        if (settings.contains("settings/appLanguage"))
            m_appLanguage = settings.value("settings/appLanguage").toString();

        status = true;
    }
    else
    {
        qWarning() << "SettingsManager::readSettings() error:" << settings.status();
    }

    return status;
}

/* ************************************************************************** */

bool SettingsManager::writeSettings()
{
    bool status = false;

    QSettings settings(QCoreApplication::organizationName(), QCoreApplication::applicationName());

    if (settings.isWritable())
    {
        settings.setValue("settings/appTheme", m_appTheme);
        settings.setValue("settings/appThemeAuto", m_appThemeAuto);
        settings.setValue("settings/appThemeAutoMethod", m_appThemeAutoMethod);
        settings.setValue("settings/appUnitSystem", m_appUnitSystem);
        settings.setValue("settings/appLanguage", m_appLanguage);

        if (settings.status() == QSettings::NoError)
        {
            status = true;
        }
        else
        {
            qWarning() << "SettingsManager::writeSettings() error:" << settings.status();
        }
    }
    else
    {
        qWarning() << "SettingsManager::writeSettings() error: read only file?";
    }

    return status;
}

/* ************************************************************************** */

void SettingsManager::resetSettings()
{
    m_appTheme = "THEME_DEFAULT";
    Q_EMIT appThemeChanged();
    m_appThemeAuto = false;
    Q_EMIT appThemeAutoChanged();
    m_appThemeAutoMethod = 0;
    Q_EMIT appThemeAutoMethodChanged();
    m_appUnitSystem = 0;
    Q_EMIT appUnitSystemChanged();
    m_appLanguage = "auto";
    Q_EMIT appLanguageChanged();
}

/* ************************************************************************** */
/* ************************************************************************** */

void SettingsManager::setAppTheme(const QString &value)
{
    if (m_appTheme != value)
    {
        m_appTheme = value;
        writeSettings();
        Q_EMIT appThemeChanged();
    }
}

void SettingsManager::setAppThemeAuto(const bool value)
{
    if (m_appThemeAuto != value)
    {
        m_appThemeAuto = value;
        writeSettings();
        Q_EMIT appThemeAutoChanged();
    }
}

void SettingsManager::setAppThemeAutoMethod(const unsigned value)
{
    if (m_appThemeAutoMethod != value)
    {
        m_appThemeAutoMethod = value;
        writeSettings();
        Q_EMIT appThemeAutoMethodChanged();
    }
}

void SettingsManager::setAppUnitSystem(const unsigned value)
{
    if (m_appUnitSystem != value)
    {
        m_appUnitSystem = value;
        writeSettings();
        Q_EMIT appUnitSystemChanged();
    }
}

void SettingsManager::setAppLanguage(const QString &value)
{
    if (m_appLanguage != value)
    {
        m_appLanguage = value;
        writeSettings();
        Q_EMIT appLanguageChanged();
    }
}

/* ************************************************************************** */

// Yours to fill

/* ************************************************************************** */
