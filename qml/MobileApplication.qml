import QtQuick
import QtQuick.Controls
import QtQuick.Window

import ThemeEngine
import MobileUI

ApplicationWindow {
    id: appWindow
    minimumWidth: 480
    minimumHeight: 960

    flags: Qt.Window | Qt.MaximizeUsingFullscreenGeometryHint
    color: Theme.colorBackground
    visible: true

    property bool isHdpi: (utilsScreen.screenDpi >= 128 || utilsScreen.screenPar >= 2.0)
    property bool isDesktop: (Qt.platform.os !== "ios" && Qt.platform.os !== "android")
    property bool isMobile: (Qt.platform.os === "ios" || Qt.platform.os === "android")
    property bool isPhone: ((Qt.platform.os === "ios" || Qt.platform.os === "android") && (utilsScreen.screenSize < 7.0))
    property bool isTablet: ((Qt.platform.os === "ios" || Qt.platform.os === "android") && (utilsScreen.screenSize >= 7.0))

    // Mobile stuff ////////////////////////////////////////////////////////////

    // 1 = Qt.PortraitOrientation, 2 = Qt.LandscapeOrientation
    // 4 = Qt.InvertedPortraitOrientation, 8 = Qt.InvertedLandscapeOrientation
    property int screenOrientation: Screen.primaryOrientation
    property int screenOrientationFull: Screen.orientation

    property int screenPaddingStatusbar: 0
    property int screenPaddingNavbar: 0

    property int screenPaddingTop: 0
    property int screenPaddingLeft: 0
    property int screenPaddingRight: 0
    property int screenPaddingBottom: 0

    Connections {
        target: Screen
        function onOrientationChanged() { mobileUI.handleSafeAreas() }
    }

    MobileUI {
        id: mobileUI

        statusbarColor: "transparent"
        statusbarTheme: Theme.themeStatusbar
        navbarColor: Theme.colorBackground

        Component.onCompleted: handleSafeAreas()

        function handleSafeAreas() {
            // safe areas handling is a work in progress /!\
            // safe areas are only taken into account when using maximized geometry / full screen mode

            mobileUI.refreshUI() // hack

            if (appWindow.visibility === Window.FullScreen ||
                appWindow.flags & Qt.MaximizeUsingFullscreenGeometryHint) {

                screenPaddingStatusbar = mobileUI.statusbarHeight
                screenPaddingNavbar = mobileUI.navbarHeight

                screenPaddingTop = mobileUI.safeAreaTop
                screenPaddingLeft = mobileUI.safeAreaLeft
                screenPaddingRight = mobileUI.safeAreaRight
                screenPaddingBottom = mobileUI.safeAreaBottom

                // hacks
                if (Qt.platform.os === "android") {
                    if (appWindow.visibility === Window.FullScreen) {
                        screenPaddingStatusbar = 0
                        screenPaddingNavbar = 0
                    }
                    if (appWindow.flags & Qt.MaximizeUsingFullscreenGeometryHint) {
                        if (mobileUI.isPhone) {
                            if (Screen.orientation === Qt.LandscapeOrientation) {
                                screenPaddingLeft = screenPaddingStatusbar
                                screenPaddingRight = screenPaddingNavbar
                                screenPaddingNavbar = 0
                            } else if (Screen.orientation === Qt.InvertedLandscapeOrientation) {
                                screenPaddingLeft = screenPaddingNavbar
                                screenPaddingRight = screenPaddingStatusbar
                                screenPaddingNavbar = 0
                            }
                        }
                    }
                }
                // hacks
                if (Qt.platform.os === "ios") {
                    if (appWindow.visibility === Window.FullScreen) {
                        screenPaddingStatusbar = 0
                    }
                }
            } else {
                screenPaddingStatusbar = 0
                screenPaddingNavbar = 0
                screenPaddingTop = 0
                screenPaddingLeft = 0
                screenPaddingRight = 0
                screenPaddingBottom = 0
            }
/*
            console.log("> handleSafeAreas()")
            console.log("- window mode:         " + appWindow.visibility)
            console.log("- window flags:        " + appWindow.flags)
            console.log("- screen dpi:          " + Screen.devicePixelRatio)
            console.log("- screen width:        " + Screen.width)
            console.log("- screen width avail:  " + Screen.desktopAvailableWidth)
            console.log("- screen height:       " + Screen.height)
            console.log("- screen height avail: " + Screen.desktopAvailableHeight)
            console.log("- screen orientation (full): " + Screen.orientation)
            console.log("- screen orientation (primary): " + Screen.primaryOrientation)
            console.log("- screenSizeStatusbar: " + screenPaddingStatusbar)
            console.log("- screenSizeNavbar:    " + screenPaddingNavbar)
            console.log("- screenPaddingTop:    " + screenPaddingTop)
            console.log("- screenPaddingLeft:   " + screenPaddingLeft)
            console.log("- screenPaddingRight:  " + screenPaddingRight)
            console.log("- screenPaddingBottom: " + screenPaddingBottom)
*/
        }
    }

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

    Component.onCompleted: {
        //
    }

    Connections {
        target: appHeader
        function onLeftMenuClicked() {
            if (appContent.state === "MobileComponents" && screenMobileComponents.stackViewDepth <= 1) {
                appDrawer.open()
            } else {
                backAction()
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
                    Theme.loadTheme(settingsManager.appTheme)

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
                    mobileUI.backToHomeScreen()
                }
            }
        } else if (appContent.state === "Settings") {
            screenSettings.backAction()
        } else if (appContent.state === "About") {
            screenAbout.backAction()
        } else if (appContent.state === "AboutPermissions") {
            screenAbout.loadScreen()
        }
    }
    function forwardAction() {
        //
    }
    function deselectAction() {
        //
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

    onActiveFocusItemChanged: {
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
        Keys.onBackPressed: backAction()

        ScreenMobileComponents {
            id: screenMobileComponents
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
