import QtQuick
import QtQuick.Layouts

import ComponentLibrary

Rectangle {
    id: appSidebar

    anchors.top: parent.top
    anchors.left: parent.left
    anchors.bottom: parent.bottom

    width: iconsSection.width + (collapsed ? 0 : menusSection.width)
    z: 10

    color: Theme.colorSidebar

    // settings
    property bool autoCollapsable: true
    property bool userCollapsable: true

    ////////////////////////////////////////////////////////////////////////////

    // Keep only the iconsSection, the menusSection slides under the sidebar
    // Either set by the layout (autoCollapsed), or by the user (userCollapsed)
    readonly property bool collapsed: (autoCollapsed || userCollapsed)

    readonly property bool autoCollapsed: {
        if (autoCollapsable) {
            if (Theme.singleColumn) return true
            if (appWindow.contentAreaWidth - iconsSection.width - menusSection.width < 512) return true
        }
        return false
    }

    property bool userCollapsed: false

    // Show the menus over the content, while the sidebar is collapsed
    // Closed when a screen is loaded, and when the sidebar expands
    property bool menusOpened: false

    onCollapsedChanged: menusOpened = false

    Connections {
        target: appContent
        function onStateChanged() { appSidebar.menusOpened = false }
    }

    ////////////////

    DragHandler {
        // Drag on the sidebar to drag the whole window // Prevent clicks below this area
        onActiveChanged: if (active) appWindow.startSystemMove()
        target: null
    }

    MouseArea {
        x: appSidebar.width
        width: appWindow.width
        height: appSidebar.height

        visible: appSidebar.collapsed && appSidebar.menusOpened
        enabled: appSidebar.collapsed && appSidebar.menusOpened

        // Overlay covering the content outside the sidebar, clickable to close the menus
        onClicked: appSidebar.menusOpened = false

        Rectangle {
            anchors.fill: parent
            anchors.margins: Theme.windowBorders
            radius: Theme.windowCornersRadius
            color: "#000000"
            opacity: Theme.isLight ? 0.24 : 0.48
        }
    }

    ////////////////////////////////////////////////////////////////////////////

    Rectangle {
        id: iconsSection

        anchors.top: parent.top
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        width: 64
        z: 5

        color: Theme.colorSeparator

        ////////////////

        Column { // top icons
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right

            topPadding: 16
            bottomPadding: 16
            spacing: 8

            ////

            DesktopSidebarItem_icon {
                //text: qsTr("Home")
                source: "qrc:/IconLibrary/material-symbols/home.svg"

                checked: (appContent.state === "MainView")
                onClicked: screenMainView.loadScreen()
            }

            ////

            DesktopSidebarItem_icon {
                //text: qsTr("Components")
                source: "qrc:/IconLibrary/material-symbols/hardware/computer.svg"

                checked: (appContent.state === "DesktopComponents" ||
                          appContent.state === "MobileComponents")
                onClicked: screenDesktopComponents.loadScreen()
            }

            ////

            DesktopSidebarItem_icon {
                //text: qsTr("Tools")
                source: "qrc:/IconLibrary/material-symbols/build.svg"

                checked: (appContent.state === "Playgrounds" ||
                          appContent.state === "HostInfos" ||
                          appContent.state === "FontInfos")
                onClicked: screenPlayground.loadScreen()
            }

            ////
        }

        ////////////////

        Column { // bottom icons
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom

            topPadding: 16
            bottomPadding: 16
            spacing: 8

            DesktopSidebarItem_icon {
                visible: (appSidebar.userCollapsable || appSidebar.collapsed)

                source: (!appSidebar.collapsed || appSidebar.menusOpened) ? "qrc:/IconLibrary/material-symbols/menu_open.svg"
                                                                          : "qrc:/IconLibrary/material-symbols/menu.svg"

                onClicked: {
                    if (appSidebar.autoCollapsed) appSidebar.menusOpened = !appSidebar.menusOpened
                    else appSidebar.userCollapsed = !appSidebar.userCollapsed
                }
            }
        }

        ////////////////
    }

    ////////////////////////////////////////////////////////////////////////////

    Item {
        id: menusSection

        anchors.top: parent.top
        anchors.bottom: parent.bottom
        width: Theme.isHdpi ? 240 : 300
        z: 4

        ////////////////

        visible: !appSidebar.collapsed || appSidebar.menusOpened || (x > iconsSection.width - width)
        x: (!appSidebar.collapsed || appSidebar.menusOpened) ? iconsSection.width : iconsSection.width - width

        Behavior on x {
            enabled: appSidebar.collapsed
            NumberAnimation { duration: 200; easing.type: Easing.OutCubic }
        }

        Rectangle { // background and border, while sliding over the content
            anchors.fill: parent
            anchors.rightMargin: -2
            visible: appSidebar.collapsed

            color: Theme.colorSidebar
            border.width: 2
            border.color: Theme.colorSeparator
        }

        ////////////////

        Column { // top menu
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.leftMargin: 12
            anchors.right: parent.right
            anchors.rightMargin: 12 + 2

            topPadding: 16
            bottomPadding: 16
            spacing: 8
/*
            DesktopSidebarItem_header {
                id: sidebarHeader
                source: "qrc:/IconLibrary/material-symbols/hardware/cable.svg"
                text: qsTr("Demo device")

                checked: (appContent.state === "MainView")
                onClicked: screenMainView.loadScreen()

                ButtonSimple {
                    Layout.fillHeight: true
                    text: qsTr("Save")
                    source: "qrc:/IconLibrary/material-symbols/save.svg"
                    sourceSize: 16
                    colorBackground: sidebarHeader.colorButtonPrimary
                    onClicked: console.log("DesktopSidebarItem_header > Save")
                }
                ButtonSimple {
                    Layout.fillHeight: true
                    text: qsTr("Cancel")
                    source: "qrc:/IconLibrary/material-symbols/rotate_left.svg"
                    sourceSize: 16
                    colorBackground: sidebarHeader.colorButtonPrimary
                    onClicked: console.log("DesktopSidebarItem_header > Cancel")
                }
                ButtonSimple {
                    Layout.fillHeight: true
                    text: qsTr("Update")
                    source: "qrc:/IconLibrary/material-symbols/new_releases.svg"
                    sourceSize: 16
                    colorBackground: sidebarHeader.colorButtonOrange
                    onClicked: console.log("DesktopSidebarItem_header > Update")
                }
            }

            Item { width: 2; height: 2; } // spacer
*/
            ////

            DesktopSidebarMenu {
                source: "qrc:/IconLibrary/material-symbols/home.svg"
                text: qsTr("Home")

                checked: (appContent.state === "MainView")
                onClicked: screenMainView.loadScreen()
            }

            Item { width: 2; height: 2; } // spacer

            DesktopSidebarMenu {
                source: "qrc:/IconLibrary/material-symbols/hardware/computer.svg"
                text: qsTr("Desktop")

                checked: (appContent.state === "DesktopComponents")
                onClicked: screenDesktopComponents.loadScreen()
            }
            DesktopSidebarMenu {
                source: "qrc:/IconLibrary/material-symbols/hardware/smartphone-fill.svg"
                text: qsTr("Mobile")

                checked: (appContent.state === "MobileComponents")
                onClicked: screenMobileComponents.loadScreen()
            }
            DesktopSidebarSubMenu {
                source: "qrc:/IconLibrary/material-symbols/build-fill.svg"
                text: qsTr("Tools")

                checked: (appContent.state === "Playgrounds" ||
                          appContent.state === "HostInfos" ||
                          appContent.state === "FontInfos")

                submenus: [
                    { text: qsTr("Playgrounds"), onClicked: function() { screenPlayground.loadScreen() } },
                    { text: qsTr("Host info"), onClicked: function() { screenHostInfos.loadScreen() } },
                    { text: qsTr("Fonts info"), onClicked: function() { screenFontInfos.loadScreen() }  }
                ]

                onClicked: screenPlayground.loadScreen()
            }

            ////
        }

        ////////////////

        Column { // bottom menu
            anchors.left: parent.left
            anchors.leftMargin: 12
            anchors.right: parent.right
            anchors.rightMargin: 12 + 2
            anchors.bottom: parent.bottom

            topPadding: 16
            bottomPadding: 16
            spacing: 8

            ////

            DesktopSidebarMenu {
                text: qsTr("Settings")
                source: "qrc:/IconLibrary/material-icons/duotone/tune.svg"
                checked: (appContent.state === "ScreenSettings")

                onClicked: screenSettings.loadScreen()
            }

            DesktopSidebarMenu {
                text: qsTr("About")
                source: "qrc:/IconLibrary/material-icons/duotone/info.svg"
                checked: (appContent.state === "ScreenAbout")

                onClicked: screenAbout.loadScreen()
            }

            DesktopSidebarMenu {
                text: qsTr("Exit")
                source: "qrc:/IconLibrary/material-icons/duotone/exit_to_app.svg"
                onClicked: Qt.quit()
            }

            ////
        }

        ////////////////
    }

    ////////////////////////////////////////////////////////////////////////////

    Rectangle { // border
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        width: 2
        opacity: 1.0
        color: Theme.colorSeparator
    }

    Rectangle { // fake shadow
        anchors.top: parent.top
        anchors.left: parent.right
        anchors.bottom: parent.bottom

        width: 8
        opacity: 0.333

        gradient: Gradient {
            orientation: Gradient.Horizontal
            GradientStop { position: 0.0; color: Theme.colorSeparator; }
            GradientStop { position: 1.0; color: "transparent"; }
        }
    }

    ////////////////////////////////////////////////////////////////////////////
}
