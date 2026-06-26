
#ifndef SETTINGS_MANAGER_H
#define SETTINGS_MANAGER_H
/* ************************************************************************** */

#include <QtQml/qqmlregistration.h>

#include <QObject>
#include <QString>
#include <QSize>

class QQmlEngine;
class QJSEngine;

/* ************************************************************************** */

/*!
 * \brief The SettingsManager class
 */
class SettingsManager: public QObject
{
    Q_OBJECT
    QML_ELEMENT
    QML_SINGLETON

    Q_PROPERTY(bool firstLaunch READ isFirstLaunch NOTIFY firstLaunchChanged)

    Q_PROPERTY(QSize initialSize READ getInitialSize NOTIFY initialSizeChanged)
    Q_PROPERTY(QSize initialPosition READ getInitialPosition NOTIFY initialSizeChanged)
    Q_PROPERTY(uint initialVisibility READ getInitialVisibility NOTIFY initialSizeChanged)

    Q_PROPERTY(QString appTheme READ getAppTheme WRITE setAppTheme NOTIFY appThemeChanged)
    Q_PROPERTY(bool appThemeAuto READ getAppThemeAuto WRITE setAppThemeAuto NOTIFY appThemeAutoChanged)
    Q_PROPERTY(uint appThemeAutoMethod READ getAppThemeAutoMethod WRITE setAppThemeAutoMethod NOTIFY appThemeAutoChanged)
    Q_PROPERTY(uint appUnitSystem READ getAppUnitSystem WRITE setAppUnitSystem NOTIFY appUnitSystemChanged)
    Q_PROPERTY(QString appLanguage READ getAppLanguage WRITE setAppLanguage NOTIFY appLanguageChanged)

    bool m_firstlaunch = true;

    // Application window
    QSize m_appSize = QSize(1280, 720);
    QSize m_appPosition = QSize(64, 64);
    unsigned m_appVisibility = 1;               //!< QWindow::Visibility

    // Application generic
    QString m_appTheme = "THEME_DEFAULT";
    bool m_appThemeAuto = false;
    unsigned m_appThemeAutoMethod = 0;
    unsigned m_appUnitSystem = 0;               //!< QLocale::MeasurementSystem
    QString m_appLanguage = "auto";

    // Application specific

    // Yours to fill

    // Read / Write settings
    bool readSettings();
    bool writeSettings();

    // Singleton
    explicit SettingsManager(QObject *parent = nullptr);

Q_SIGNALS:
    void firstLaunchChanged();
    void initialSizeChanged();
    void appThemeChanged();
    void appThemeAutoChanged();
    void appThemeAutoMethodChanged();
    void appUnitSystemChanged();
    void appLanguageChanged();

public:
    static SettingsManager *getInstance();
    static SettingsManager *create(QQmlEngine *engine, QJSEngine *scriptEngine);

    // Generic

    bool isFirstLaunch() const { return m_firstlaunch; }

    QSize getInitialSize() { return m_appSize; }
    QSize getInitialPosition() { return m_appPosition; }
    unsigned getInitialVisibility() { return m_appVisibility; }

    const QString &getAppTheme() const { return m_appTheme; }
    void setAppTheme(const QString &value);

    bool getAppThemeAuto() const { return m_appThemeAuto; }
    void setAppThemeAuto(const bool value);

    unsigned getAppThemeAutoMethod() const { return m_appThemeAutoMethod; }
    void setAppThemeAutoMethod(const unsigned value);

    unsigned getAppUnitSystem() const { return m_appUnitSystem; }
    void setAppUnitSystem(const unsigned value);

    const QString &getAppLanguage() const { return m_appLanguage; }
    void setAppLanguage(const QString &value);

    // App

    // Yours to fill

    // Utils

    Q_INVOKABLE void resetSettings();
};

/* ************************************************************************** */
#endif // SETTINGS_MANAGER_H
