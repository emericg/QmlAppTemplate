import QtQuick
import QtQuick.Window

import ComponentLibrary
import MobileUI
import AppUtils

Window {
    id: appWindow
    minimumWidth: 480
    minimumHeight: 960

    flags: Qt.Window | Qt.MaximizeUsingFullscreenGeometryHint
    color: Theme.colorBackground
    visible: true

    // Helpers
    property bool isHdpi: (UtilsScreen.screenDpi >= 128 || UtilsScreen.screenPar >= 2.0)
    property bool isDesktop: (Qt.platform.os !== "ios" && Qt.platform.os !== "android")
    property bool isMobile: (Qt.platform.os === "ios" || Qt.platform.os === "android")
    property bool isPhone: ((Qt.platform.os === "ios" || Qt.platform.os === "android") && (UtilsScreen.screenSize < 7.0))
    property bool isTablet: ((Qt.platform.os === "ios" || Qt.platform.os === "android") && (UtilsScreen.screenSize >= 7.0))

    // Setup ThemeEngine
    Binding { target: Theme; property: "appTheme";               value: SettingsManager.appTheme }
    Binding { target: Theme; property: "appThemeAuto";           value: SettingsManager.appThemeAuto }
    Binding { target: Theme; property: "appThemeAutoMethod";     value: SettingsManager.appThemeAutoMethod }
    Binding { target: Theme; property: "appWidth";               value: appWindow.width }
    Binding { target: Theme; property: "appHeight";              value: appWindow.height }
    Binding { target: Theme; property: "screenOrientation";      value: Screen.primaryOrientation }
    Binding { target: Theme; property: "screenDpi";              value: UtilsScreen.screenDpi }
    Binding { target: Theme; property: "screenPar";              value: UtilsScreen.screenPar }
    Binding { target: Theme; property: "screenSize";             value: UtilsScreen.screenSize }
    Binding { target: Theme; property: "screenPaddingStatusbar"; value: MobileUI.statusbarHeight }
    Binding { target: Theme; property: "screenPaddingNavbar";    value: MobileUI.navbarHeight }
    Binding { target: Theme; property: "screenPaddingTop";       value: MobileUI.safeAreaTop }
    Binding { target: Theme; property: "screenPaddingLeft";      value: MobileUI.safeAreaLeft }
    Binding { target: Theme; property: "screenPaddingRight";     value: MobileUI.safeAreaRight }
    Binding { target: Theme; property: "screenPaddingBottom";    value: MobileUI.safeAreaBottom }

    // Setup MobileUI
    Binding { target: MobileUI; property: "statusbarColor";      value: Theme.colorStatusbar }
    Binding { target: MobileUI; property: "navbarColor";         value: Theme.colorTabletmenu }

    // Mobile stuff ////////////////////////////////////////////////////////////

    // 1 = Qt.PortraitOrientation, 2 = Qt.LandscapeOrientation
    // 4 = Qt.InvertedPortraitOrientation, 8 = Qt.InvertedLandscapeOrientation
    property int screenOrientation: Screen.primaryOrientation
    property int screenOrientationFull: Screen.orientation

    property int screenPaddingStatusbar: MobileUI.statusbarHeight
    property int screenPaddingNavbar: MobileUI.navbarHeight

    property int screenPaddingTop: MobileUI.safeAreaTop
    property int screenPaddingLeft: MobileUI.safeAreaLeft
    property int screenPaddingRight: MobileUI.safeAreaRight
    property int screenPaddingBottom: MobileUI.safeAreaBottom

    MobileHeader {
        id: appHeader

        leftMenuMode: {
            if (appContent.state === "MobileComponents" && screenMobileComponents.stackViewDepth <= 1)
                return "drawer"
            else if (appContent.state === "Tutorial")
                return "close"

            return "back"
        }
    }

    MobileDrawer {
        id: appDrawer

        interactive: (appContent.state !== "Tutorial")
    }

    // Events handling /////////////////////////////////////////////////////////

    Connections {
        target: appHeader
        function onLeftMenuClicked() {
            if (appContent.state === "MobileComponents" && screenMobileComponents.stackViewDepth <= 1) {
                appDrawer.open()
            } else {
                appWindow.backAction()
            }
        }
        function onRightMenuClicked() {
            //
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
        if (appContent.state === "MobileComponents") {
            if (screenMobileComponents.backAction()) {
                if (mobileExit.enabled) {
                    if (mobileExit.timerRunning)
                        Qt.quit()
                    else
                        mobileExit.timerStart()
                } else {
                    MobileUI.backToHomeScreen()
                }
            }
        } else if (appContent.state === "Playground") {
            screenPlayground.backAction()
        } else if (appContent.state === "HostInfos") {
            screenHostInfos.backAction()
        } else if (appContent.state === "FontInfos") {
            screenFontInfos.backAction()
        } else if (appContent.state === "Settings") {
            screenSettings.backAction()
        } else if (appContent.state === "About") {
            screenAbout.backAction()
        } else if (appContent.state === "AboutPermissions") {
            screenAbout.loadScreen()
        }
    }

    function forwardAction() {
        // nothing
    }

    // UI sizes ////////////////////////////////////////////////////////////////

    property bool headerUnicolor: (Theme.colorHeader === Theme.colorBackground)

    property bool singleColumn: {
        if (isMobile) {
            if ((isPhone && screenOrientation === Qt.PortraitOrientation) ||
                (isTablet && width < 512)) { // can be a 2/3 split screen on tablet
                return true
            } else {
                return false
            }
        } else {
            return (appWindow.width < appWindow.height)
        }
    }

    property bool wideMode: (isDesktop && width >= 560) || (isTablet && width >= 480)
    property bool wideWideMode: (width >= 640)

    // QML /////////////////////////////////////////////////////////////////////

    onActiveFocusItemChanged: { // DEBUG
        //console.log("activeFocusItem:" + activeFocusItem)
    }

    FocusScope {
        id: appContent

        anchors.top: appHeader.bottom
        anchors.left: parent.left
        anchors.leftMargin: screenPaddingLeft
        anchors.right: parent.right
        anchors.rightMargin: screenPaddingRight
        anchors.bottom: mobileMenu.top

        focus: true
        Keys.onBackPressed: appWindow.backAction()

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
        MobilePermissions {
            id: screenAboutPermissions
        }

        // Initial state
        state: "MobileComponents"

        onStateChanged: {
            //
        }

        states: [
            State {
                name: "MobileComponents"
                PropertyChanges { target: appHeader; headerTitle: "QmlAppTemplate"; }
                PropertyChanges { target: screenMobileComponents; visible: true; enabled: true; }
                PropertyChanges { target: screenPlayground; visible: false; enabled: false; }
                PropertyChanges { target: screenFontInfos; visible: false; enabled: false; }
                PropertyChanges { target: screenHostInfos; visible: false; enabled: false; }
                PropertyChanges { target: screenSettings; visible: false; enabled: false; }
                PropertyChanges { target: screenAbout; visible: false; enabled: false; }
                PropertyChanges { target: screenAboutPermissions; visible: false; enabled: false; }
            },
            State {
                name: "Playground"
                PropertyChanges { target: appHeader; headerTitle: "Playground"; }
                PropertyChanges { target: screenMobileComponents; visible: false; enabled: false; }
                PropertyChanges { target: screenPlayground; visible: true; enabled: true; }
                PropertyChanges { target: screenFontInfos; visible: false; enabled: false; }
                PropertyChanges { target: screenHostInfos; visible: false; enabled: false; }
                PropertyChanges { target: screenSettings; visible: false; enabled: false; }
                PropertyChanges { target: screenAbout; visible: false; enabled: false; }
                PropertyChanges { target: screenAboutPermissions; visible: false; enabled: false; }
            },
            State {
                name: "FontInfos"
                PropertyChanges { target: appHeader; headerTitle: "Font infos"; }
                PropertyChanges { target: screenMobileComponents; visible: false; enabled: false; }
                PropertyChanges { target: screenPlayground; visible: false; enabled: false; }
                PropertyChanges { target: screenFontInfos; visible: true; enabled: true; }
                PropertyChanges { target: screenHostInfos; visible: false; enabled: false; }
                PropertyChanges { target: screenSettings; visible: false; enabled: false; }
                PropertyChanges { target: screenAbout; visible: false; enabled: false; }
                PropertyChanges { target: screenAboutPermissions; visible: false; enabled: false; }
            },
            State {
                name: "HostInfos"
                PropertyChanges { target: appHeader; headerTitle: "Host infos"; }
                PropertyChanges { target: screenMobileComponents; visible: false; enabled: false; }
                PropertyChanges { target: screenPlayground; visible: false; enabled: false; }
                PropertyChanges { target: screenFontInfos; visible: false; enabled: false; }
                PropertyChanges { target: screenHostInfos; visible: true; enabled: true; }
                PropertyChanges { target: screenSettings; visible: false; enabled: false; }
                PropertyChanges { target: screenAbout; visible: false; enabled: false; }
                PropertyChanges { target: screenAboutPermissions; visible: false; enabled: false; }
            },
            State {
                name: "Settings"
                PropertyChanges { target: appHeader; headerTitle: qsTr("Settings"); }
                PropertyChanges { target: screenMobileComponents; visible: false; enabled: false; }
                PropertyChanges { target: screenPlayground; visible: false; enabled: false; }
                PropertyChanges { target: screenFontInfos; visible: false; enabled: false; }
                PropertyChanges { target: screenHostInfos; visible: false; enabled: false; }
                PropertyChanges { target: screenSettings; visible: true; enabled: true; }
                PropertyChanges { target: screenAbout; visible: false; enabled: false; }
                PropertyChanges { target: screenAboutPermissions; visible: false; enabled: false; }
            },
            State {
                name: "About"
                PropertyChanges { target: appHeader; headerTitle: qsTr("About"); }
                PropertyChanges { target: screenMobileComponents; visible: false; enabled: false; }
                PropertyChanges { target: screenPlayground; visible: false; enabled: false; }
                PropertyChanges { target: screenFontInfos; visible: false; enabled: false; }
                PropertyChanges { target: screenHostInfos; visible: false; enabled: false; }
                PropertyChanges { target: screenSettings; visible: false; enabled: false; }
                PropertyChanges { target: screenAbout; visible: true; enabled: true; }
                PropertyChanges { target: screenAboutPermissions; visible: false; enabled: false; }
            },
            State {
                name: "AboutPermissions"
                PropertyChanges { target: appHeader; headerTitle: qsTr("Permissions"); }
                PropertyChanges { target: screenMobileComponents; visible: false; enabled: false; }
                PropertyChanges { target: screenPlayground; visible: false; enabled: false; }
                PropertyChanges { target: screenFontInfos; visible: false; enabled: false; }
                PropertyChanges { target: screenHostInfos; visible: false; enabled: false; }
                PropertyChanges { target: screenSettings; visible: false; enabled: false; }
                PropertyChanges { target: screenAbout; visible: false; enabled: false; }
                PropertyChanges { target: screenAboutPermissions; visible: true; enabled: true; }
            }
        ]
    }

    ////////////////

    MobileExit {
        id: mobileExit
        enabled: true
    }

    ////////////////

    MobileMenu {
        id: mobileMenu
    }

    ////////////////////////////////////////////////////////////////////////////
}
