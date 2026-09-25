import QtQuick
import QtQuick.Controls
import QtQuick.Window

import ComponentLibrary
import AppUtils

ApplicationWindow {
    id: appWindow

    flags: Qt.Window
    color: Theme.colorBackground

    // Helpers
    property bool isHdpi: (UtilsScreen.screenDpi >= 128 || UtilsScreen.screenPar >= 2.0)
    property bool isDesktop: true
    property bool isMobile: false
    property bool isPhone: false
    property bool isTablet: false

    // Setup ThemeEngine
    Binding { target: Theme; property: "appTheme";               value: SettingsManager.appTheme }
    Binding { target: Theme; property: "appThemeAuto";           value: SettingsManager.appThemeAuto }
    Binding { target: Theme; property: "appThemeAutoMethod";     value: SettingsManager.appThemeAutoMethod }
    Binding { target: Theme; property: "appWidth";               value: appWindow.width }
    Binding { target: Theme; property: "appHeight";              value: appWindow.height }
    Binding { target: Theme; property: "screenDpi";              value: UtilsScreen.screenDpi }
    Binding { target: Theme; property: "screenPar";              value: UtilsScreen.screenPar }
    Binding { target: Theme; property: "screenSize";             value: UtilsScreen.screenSize }

    // Desktop stuff ///////////////////////////////////////////////////////////

    minimumWidth: 1024
    minimumHeight: 640

    width: {
        if (SettingsManager.initialSize.width > 0)
            return SettingsManager.initialSize.width
        else
            return isHdpi ? 1280 : 1440
    }
    height: {
        if (SettingsManager.initialSize.height > 0)
            return SettingsManager.initialSize.height
        else
            return isHdpi ? 720 : 920
    }
    x: SettingsManager.initialPosition.width
    y: SettingsManager.initialPosition.height
    visibility: SettingsManager.initialVisibility
    visible: true

    WindowGeometrySaver {
        windowInstance: appWindow
        Component.onCompleted: {
            // Make sure we handle window visibility correctly
            visibility = SettingsManager.initialVisibility
        }
    }

    // Mobile stuff ////////////////////////////////////////////////////////////

    property int screenOrientation: Screen.primaryOrientation
    property int screenOrientationFull: Screen.orientation

    property int screenPaddingStatusbar: 0
    property int screenPaddingNavbar: 0
    property int screenPaddingTop: 0
    property int screenPaddingLeft: 0
    property int screenPaddingRight: 0
    property int screenPaddingBottom: 0

    // Events handling /////////////////////////////////////////////////////////

    Connections {
        target: appHeader

        function onBackButtonClicked() {
            appWindow.backAction()
        }
        function onRightMenuClicked() {
            //
        }

        function onMenuComponentsClicked() { screenDesktopComponents.loadScreen() }
        function onMenuSettingsClicked() { screenSettings.loadScreen() }
        function onMenuAboutClicked() { screenAbout.loadScreen() }
    }

    Connections {
        target: MenubarManager

        function onSettingsClicked() { screenSettings.loadScreen() }
        function onAboutClicked() { screenAbout.loadScreen() }
        function onExportClicked() { }
        function onClearClicked() { }
        function onViewClicked(screen) {
            if (screen === 0) screenMainView.loadScreen()
            else if (screen === 1) screenDesktopComponents.loadScreen()
            else if (screen === 2) screenMobileComponents.loadScreen()
            else if (screen === 3) screenPlayground.loadScreen()
        }
    }

    Connections {
        target: Qt.application
        function onStateChanged() {
            switch (Qt.application.state) {
                case Qt.ApplicationSuspended:
                    //console.log("Qt.ApplicationSuspended")
                    break
                case Qt.ApplicationHidden:
                    //console.log("Qt.ApplicationHidden")
                    break
                case Qt.ApplicationInactive:
                    //console.log("Qt.ApplicationInactive")
                    break
                case Qt.ApplicationActive:
                    //console.log("Qt.ApplicationActive")

                    // Check if we need an 'automatic' theme change
                    Theme.loadTheme(SettingsManager.appTheme)

                    break
            }
        }
    }

    // User generated events handling //////////////////////////////////////////

    function backAction() {
        var state = false

        // backAction() calls will (sometime) return true if an action has been performed,
        // so we know there is no need to go back the backAction() stack

        if (appContent.state === "DesktopComponents") state = screenDesktopComponents.backAction()
        if (appContent.state === "MobileComponents") state = screenMobileComponents.backAction()
        if (appContent.state === "Playgrounds") state = screenPlayground.backAction()
        if (appContent.state === "HostInfos") state = screenHostInfos.backAction()
        if (appContent.state === "FontInfos") state = screenFontInfos.backAction()
        if (appContent.state === "ScreenSettings") state = screenSettings.backAction()
        if (appContent.state === "ScreenAbout") state = screenAbout.backAction()

        if (state === false) { // generic action
            if (Theme.isDesktop) screenDesktopComponents.loadScreen()
            else screenMobileComponents.loadScreen()
        }
    }

    function forwardAction() {
        // nothing
    }

    function setFullScreen() {
        if (appWindow.visibility !== Window.FullScreen) {
            appWindow.visibility = Window.FullScreen
        } else {
            appWindow.visibility = Window.Windowed
        }
    }

    function cleanExit() {
        if (Qt.platform.os === "osx") {
            Qt.quit() // exit the app explicitely
        } else {
            appWindow.close() // close the window
        }
    }

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.BackButton | Qt.ForwardButton
        onClicked: (mouse) => {
            if (mouse.button === Qt.BackButton) {
                appWindow.backAction()
            } else if (mouse.button === Qt.ForwardButton) {
                appWindow.forwardAction()
            }
        }
    }

    Shortcut {
        sequences: [StandardKey.Back, StandardKey.Backspace]
        onActivated: appWindow.backAction()
    }
    Shortcut {
        sequences: [StandardKey.Forward]
        onActivated: appWindow.forwardAction()
    }
    Shortcut {
        sequences: [StandardKey.Preferences]
        onActivated: screenSettings.loadScreen()
    }
    Shortcut {
        sequences: [StandardKey.FullScreen]
        onActivated: appWindow.setFullScreen()
    }
    Shortcut {
        sequences: [StandardKey.Close]
        onActivated: appWindow.close()
    }
    Shortcut {
        sequences: [StandardKey.Quit]
        onActivated: appWindow.cleanExit()
    }
    Shortcut {
        sequence: "Ctrl+E"
        onActivated: themeEditor.toggle()
    }

    // UI sizes ////////////////////////////////////////////////////////////////

    property bool headerUnicolor: (Theme.colorHeader === Theme.colorBackground)
    property bool sidebarUnicolor: (Theme.colorSidebar === Theme.colorBackground)

    property bool singleColumn: {
        if (isMobile) {
            if (screenOrientation === Qt.PortraitOrientation ||
                (isTablet && width < 480)) { // can be a 2/3 split screen on tablet
                return true
            } else {
                return false
            }
        } else {
            return (appWindow.width < appWindow.height)
        }
    }

    // QML (disabled) //////////////////////////////////////////////////////////
/*
    menuBar: MenuBar {
        id: appMenubar
        Menu {
            title: qsTr("File")
            MenuItem {
                text: qsTr("Do nothing")
                onTriggered: console.log("Do nothing action triggered");
            }
            MenuItem {
                text: qsTr("&Exit")
                onTriggered: appWindow.cleanExit()
            }
        }
    }
*/
/*
    DesktopHeader {
        id: appHeader

        anchors.top: parent.top
        anchors.left: appSidebar.right
        anchors.right: parent.right
    }
*/
    Item { // compat
        id: appHeader

        anchors.top: parent.top
        anchors.left: appSidebar.right
        anchors.right: parent.right
        height: 0

        // compat
        property int headerPosition: 64
        signal backButtonClicked()
        signal rightMenuClicked()
        signal menuComponentsClicked()
        signal menuSettingsClicked()
        signal menuAboutClicked()
    }

    // QML /////////////////////////////////////////////////////////////////////

    Component.onCompleted: {
        screenMainView.loadScreen()
    }

    onActiveFocusItemChanged: { // DEBUG
        //console.log("activeFocusItem:" + activeFocusItem)
    }

    DesktopSidebar {
        id: appSidebar
        z: 2

        anchors.top: parent.top
        anchors.left: parent.left
        anchors.bottom: parent.bottom
    }

    Rectangle {
        id: appContent

        anchors.top: appHeader.bottom
        anchors.left: appSidebar.right
        anchors.right: parent.right
        anchors.rightMargin: themeEditor.width
        anchors.bottom: parent.bottom

        color: Theme.colorBackground

        ScreenMainView {
            id: screenMainView
        }
        ScreenDesktopComponents {
            id: screenDesktopComponents
        }
        ScreenMobileComponents {
            id: screenMobileComponents
        }
        ScreenPlayground {
            id: screenPlayground
        }
        ScreenFontInfos {
            id: screenFontInfos
        }
        ScreenHostInfos {
            id: screenHostInfos
        }

        ScreenSettings {
            id: screenSettings
        }
        ScreenAbout {
            id: screenAbout
        }

        state: ""
        onStateChanged: {
            // Reflect the active screen as a checkmark in the macOS View menu
            if (state === "MainView") MenubarManager.setCurrentView(0)
            else if (state === "DesktopComponents") MenubarManager.setCurrentView(1)
            else if (state === "MobileComponents") MenubarManager.setCurrentView(2)
            else if (state === "Playgrounds" || state === "HostInfos" || state === "FontInfos") MenubarManager.setCurrentView(3)
            else MenubarManager.setCurrentView(-1)
        }

        states: [
            State {
                name: "MainView"
                PropertyChanges { target: screenMainView; visible: true; enabled: true; focus: true; }
                PropertyChanges { target: screenDesktopComponents; visible: false; enabled: false; }
                PropertyChanges { target: screenMobileComponents; visible: false; enabled: false; }
                PropertyChanges { target: screenPlayground; visible: false; enabled: false; }
                PropertyChanges { target: screenFontInfos; visible: false; enabled: false; }
                PropertyChanges { target: screenHostInfos; visible: false; enabled: false; }
                PropertyChanges { target: screenSettings; visible: false; enabled: false; }
                PropertyChanges { target: screenAbout; visible: false; enabled: false; }
            },
            State {
                name: "DesktopComponents"
                PropertyChanges { target: screenMainView; visible: false; enabled: false; }
                PropertyChanges { target: screenDesktopComponents; visible: true; enabled: true; focus: true; }
                PropertyChanges { target: screenMobileComponents; visible: false; enabled: false; }
                PropertyChanges { target: screenPlayground; visible: false; enabled: false; }
                PropertyChanges { target: screenFontInfos; visible: false; enabled: false; }
                PropertyChanges { target: screenHostInfos; visible: false; enabled: false; }
                PropertyChanges { target: screenSettings; visible: false; enabled: false; }
                PropertyChanges { target: screenAbout; visible: false; enabled: false; }
            },
            State {
                name: "MobileComponents"
                PropertyChanges { target: screenMainView; visible: false; enabled: false; }
                PropertyChanges { target: screenDesktopComponents; visible: false; enabled: false; }
                PropertyChanges { target: screenMobileComponents; visible: true; enabled: true; focus: true; }
                PropertyChanges { target: screenPlayground; visible: false; enabled: false; }
                PropertyChanges { target: screenFontInfos; visible: false; enabled: false; }
                PropertyChanges { target: screenHostInfos; visible: false; enabled: false; }
                PropertyChanges { target: screenSettings; visible: false; enabled: false; }
                PropertyChanges { target: screenAbout; visible: false; enabled: false; }
            },
            State {
                name: "Playgrounds"
                PropertyChanges { target: screenMainView; visible: false; enabled: false; }
                PropertyChanges { target: screenDesktopComponents; visible: false; enabled: false; }
                PropertyChanges { target: screenMobileComponents; visible: false; enabled: false; }
                PropertyChanges { target: screenPlayground; visible: true; enabled: true; focus: true; }
                PropertyChanges { target: screenFontInfos; visible: false; enabled: false; }
                PropertyChanges { target: screenHostInfos; visible: false; enabled: false; }
                PropertyChanges { target: screenSettings; visible: false; enabled: false; }
                PropertyChanges { target: screenAbout; visible: false; enabled: false; }
            },
            State {
                name: "FontInfos"
                PropertyChanges { target: screenMainView; visible: false; enabled: false; }
                PropertyChanges { target: screenDesktopComponents; visible: false; enabled: false; }
                PropertyChanges { target: screenMobileComponents; visible: false; enabled: false; }
                PropertyChanges { target: screenPlayground; visible: false; enabled: false; }
                PropertyChanges { target: screenFontInfos; visible: true; enabled: true; focus: true; }
                PropertyChanges { target: screenHostInfos; visible: false; enabled: false; }
                PropertyChanges { target: screenSettings; visible: false; enabled: false; }
                PropertyChanges { target: screenAbout; visible: false; enabled: false; }
            },
            State {
                name: "HostInfos"
                PropertyChanges { target: screenMainView; visible: false; enabled: false; }
                PropertyChanges { target: screenDesktopComponents; visible: false; enabled: false; }
                PropertyChanges { target: screenMobileComponents; visible: false; enabled: false; }
                PropertyChanges { target: screenPlayground; visible: false; enabled: false; }
                PropertyChanges { target: screenFontInfos; visible: false; enabled: false; }
                PropertyChanges { target: screenHostInfos; visible: true; enabled: true; focus: true; }
                PropertyChanges { target: screenSettings; visible: false; enabled: false; }
                PropertyChanges { target: screenAbout; visible: false; enabled: false; }
            },
            State {
                name: "ScreenSettings"
                PropertyChanges { target: screenMainView; visible: false; enabled: false; }
                PropertyChanges { target: screenDesktopComponents; visible: false; enabled: false; }
                PropertyChanges { target: screenMobileComponents; visible: false; enabled: false; }
                PropertyChanges { target: screenPlayground; visible: false; enabled: false; }
                PropertyChanges { target: screenFontInfos; visible: false; enabled: false; }
                PropertyChanges { target: screenHostInfos; visible: false; enabled: false; }
                PropertyChanges { target: screenSettings; visible: true; enabled: true; focus: true; }
                PropertyChanges { target: screenAbout; visible: false; enabled: false; }
            },
            State {
                name: "ScreenAbout"
                PropertyChanges { target: screenMainView; visible: false; enabled: false; }
                PropertyChanges { target: screenDesktopComponents; visible: false; enabled: false; }
                PropertyChanges { target: screenMobileComponents; visible: false; enabled: false; }
                PropertyChanges { target: screenPlayground; visible: false; enabled: false; }
                PropertyChanges { target: screenFontInfos; visible: false; enabled: false; }
                PropertyChanges { target: screenHostInfos; visible: false; enabled: false; }
                PropertyChanges { target: screenSettings; visible: false; enabled: false; }
                PropertyChanges { target: screenAbout; visible: true; enabled: true; focus: true; }
            }
        ]
    }

    ////////////////////////////////////////////////////////////////////////////

    EditorPanel {
        id: themeEditor

        anchors.top: appHeader.bottom
        anchors.right: parent.right
        anchors.bottom: parent.bottom
    }

    ////////////////////////////////////////////////////////////////////////////
}
