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

    onScreenOrientationChanged: handleSafeAreas()
    onVisibilityChanged: handleSafeAreas()

    function handleSafeAreas() {
        // safe areas are only taken into account when using maximized geometry / full screen mode
        if (appWindow.visibility === ApplicationWindow.FullScreen ||
            appWindow.flags & Qt.MaximizeUsingFullscreenGeometryHint) {

            screenPaddingStatusbar = mobileUI.statusbarHeight
            screenPaddingNavbar = mobileUI.navbarHeight

            screenPaddingTop = mobileUI.safeAreaTop
            screenPaddingLeft = mobileUI.safeAreaLeft
            screenPaddingRight = mobileUI.safeAreaRight
            screenPaddingBottom = mobileUI.safeAreaBottom

            // hacks
            if (Qt.platform.os === "android") {
                if (Screen.primaryOrientation === Qt.PortraitOrientation) {
                    screenPaddingStatusbar = mobileUI.safeAreaTop
                    screenPaddingTop = 0
                } else {
                    screenPaddingNavbar = 0
                }
            }
            // hacks
            if (Qt.platform.os === "ios") {
                //
            }
            // hacks
            if (visibility === ApplicationWindow.FullScreen) {
                screenPaddingStatusbar = 0
                screenPaddingNavbar = 0
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
        console.log("- screen width:        " + Screen.width)
        console.log("- screen width avail:  " + Screen.desktopAvailableWidth)
        console.log("- screen height:       " + Screen.height)
        console.log("- screen height avail: " + Screen.desktopAvailableHeight)
        console.log("- screen orientation:  " + Screen.orientation)
        console.log("- screen orientation (primary): " + Screen.primaryOrientation)
        console.log("- screenSizeStatusbar: " + screenPaddingStatusbar)
        console.log("- screenSizeNavbar:    " + screenPaddingNavbar)
        console.log("- screenPaddingTop:    " + screenPaddingTop)
        console.log("- screenPaddingLeft:   " + screenPaddingLeft)
        console.log("- screenPaddingRight:  " + screenPaddingRight)
        console.log("- screenPaddingBottom: " + screenPaddingBottom)
*/
    }

    MobileUI {
        id: mobileUI

        statusbarColor: Theme.colorStatusbar
        navbarColor: Theme.colorBackground
    }

    MobileHeader {
        id: appHeader
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
            if (appContent.state === "MainView" /*|| appContent.state === "MobileComponents"*/) {
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
        if (appContent.state === "MainView") {
            if (exitTimer.running)
                Qt.quit()
            else
                exitTimer.start()
        } else if (appContent.state === "MobileComponents") {
            screenMobileComponents.backAction()
        } else if (appContent.state === "Settings") {
            screenSettings.backAction()
        } else if (appContent.state === "About") {
            screenAbout.backAction()
        } else if (appContent.state === "AboutPermissions") {
            screenAbout.loadScreen()
        } else {
            screenMainView.loadScreen()
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
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.bottomMargin: screenPaddingNavbar + screenPaddingBottom

        focus: true
        Keys.onBackPressed: backAction()

        ScreenMainView {
            id: screenMainView
            anchors.bottomMargin: mobileMenu.hhv
        }
        ScreenMobileComponents {
            id: screenMobileComponents
            anchors.bottomMargin: mobileMenu.hhv
        }
        ScreenFontInfos {
            id: screenFontInfos
            anchors.bottomMargin: mobileMenu.hhv
        }
        ScreenHostInfos {
            id: screenHostInfos
            anchors.bottomMargin: mobileMenu.hhv
        }

        ScreenSettings {
            id: screenSettings
            anchors.bottomMargin: mobileMenu.hhv
        }
        ScreenAbout {
            id: screenAbout
            anchors.bottomMargin: mobileMenu.hhv
        }
        MobilePermissions {
            id: screenAboutPermissions
            anchors.bottomMargin: mobileMenu.hhv
        }

        Component.onCompleted: {
            //
        }

        onStateChanged: {
            if (state === "MainView" /*|| state === "MobileComponents"*/)
                appHeader.leftMenuMode = "drawer"
            else if (state === "Tutorial")
                appHeader.leftMenuMode = "close"
            else
                appHeader.leftMenuMode = "back"
        }

        // Initial state
        state: "MobileComponents"

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

    Rectangle { // navbar area
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        height: screenPaddingNavbar + screenPaddingBottom
        visible: (!mobileMenu.visible || appContent.state === "Tutorial")
        opacity: 0.8
        color: {
            if (appContent.state === "Tutorial") return Theme.colorHeader
            return Theme.colorBackground
        }
    }

    ////////////////

    MobileMenu {
        id: mobileMenu
    }

    ////////////////

    Timer {
        id: exitTimer
        interval: 3333
        running: false
        repeat: false
    }
    Rectangle {
        id: exitWarning

        anchors.left: parent.left
        anchors.leftMargin: Theme.componentMargin
        anchors.right: parent.right
        anchors.rightMargin: Theme.componentMargin
        anchors.bottom: parent.bottom
        anchors.margins: Theme.componentMargin + screenPaddingNavbar + screenPaddingBottom

        height: Theme.componentHeight
        radius: Theme.componentRadius

        color: Theme.colorComponentBackground
        border.color: Theme.colorSeparator
        border.width: Theme.componentBorderWidth

        opacity: exitTimer.running ? 1 : 0
        Behavior on opacity { OpacityAnimator { duration: 333 } }
        visible: opacity

        Text {
            anchors.centerIn: parent

            text: qsTr("Press one more time to exit...")
            textFormat: Text.PlainText
            font.pixelSize: Theme.fontSizeContent
            color: Theme.colorText
        }
    }

    ////////////////////////////////////////////////////////////////////////////
}
