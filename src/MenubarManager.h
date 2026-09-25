
#ifndef MENUBAR_MANAGER_H
#define MENUBAR_MANAGER_H
/* ************************************************************************** */

#include <QtQml/qqmlregistration.h>

#include <QObject>
#include <QWindow>

class QJSEngine;
class QQmlEngine;

class QMenu;
class QAction;
class QQuickWindow;

/* ************************************************************************** */

/*!
 * \brief The MenubarManager class.
 *
 * Native macOS menu bar, meant to be adapted to each application.
 * On other platforms the singleton exists (so QML can use it) but no menu bar is created.
 */
class MenubarManager: public QObject
{
    Q_OBJECT
    QML_ELEMENT
    QML_SINGLETON

    QQuickWindow *m_saved_view = nullptr;

    QAction *m_actionAbout = nullptr;
    QAction *m_actionSettings = nullptr;

    QMenu *m_menuFile = nullptr;
    QAction *m_actionExport = nullptr;
    QAction *m_actionClear = nullptr;

    QMenu *m_menuView = nullptr;
    QAction *m_actionViewMain = nullptr;
    QAction *m_actionViewDesktopComponents = nullptr;
    QAction *m_actionViewMobileComponents = nullptr;
    QAction *m_actionViewTools = nullptr;

    int m_currentView = -1; //!< UI screen currently shown, for the View menu checkmark

    QMenu *m_menuWindow = nullptr;
    QAction *m_actionMinimize = nullptr;
    QAction *m_actionMaximize = nullptr;
    QAction *m_actionFullScreen = nullptr;
    QAction *m_actionClose = nullptr;

    QWindow::Visibility m_previousVisibility = QWindow::Windowed; //!< state to restore when leaving full screen

    QMenu *m_menuHelp = nullptr;
    QAction *m_actionWebsite = nullptr;
    QAction *m_actionIssueTracker = nullptr;
    QAction *m_actionReleaseNotes = nullptr;

    void showWindow();

    // Singleton
    explicit MenubarManager(QObject *parent = nullptr);
    ~MenubarManager();

signals:
    void settingsClicked();
    void aboutClicked();
    void exportClicked();
    void clearClicked();
    void viewClicked(int screen);

public:
    static MenubarManager *getInstance();
    static MenubarManager *create(QQmlEngine *, QJSEngine *);

    /*!
     * \brief Create the macOS menu bar.
     * \param view: the application main window, target of the Window menu actions.
     */
    void setupMenubar(QQuickWindow *view);

    /*!
     * \brief Set the screen currently shown, to update the View menu checkmark.
     * \param screen: screen index, as emitted by viewClicked(), or -1 for none.
     */
    Q_INVOKABLE void setCurrentView(int screen);

private slots:
    void updateViewActions();
    void updateWindowActions();
    void about();
    void settings();
    void fileExport();
    void fileClear();

    void windowMinimize();
    void windowMaximize();
    void windowFullScreen();
    void windowClose();

    void website();
    void issuetracker();
    void releasenotes();
};

/* ************************************************************************** */
#endif // MENUBAR_MANAGER_H
