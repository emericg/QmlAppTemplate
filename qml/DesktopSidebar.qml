import QtQuick
import QtQuick.Controls

import QmlAppTemplate
import ComponentLibrary

Rectangle {
    id: appSidebar
    anchors.top: parent.top
    anchors.left: parent.left
    anchors.bottom: parent.bottom

    z: 10
    width: isHdpi ? 220 : 256
    color: Theme.colorSidebar

    ////////////

    DragHandler {
        // Drag on the sidebar to drag the whole window // Qt 5.15+
        // Also, prevent clicks below this area
        onActiveChanged: if (active) appWindow.startSystemMove()
        target: null
    }

    CsdMac {
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.horizontalCenter: parent.horizontalCenter
    }

    ////////////

    Column { // top menu
        anchors.top: parent.top
        anchors.topMargin: 16
        anchors.left: parent.left
        anchors.leftMargin: 12
        anchors.right: parent.right
        anchors.rightMargin: 12
        spacing: 8

        DesktopSidebarMenu {
            text: qsTr("Desktop")
            source: "qrc:/IconLibrary/material-symbols/hardware/computer.svg"
            checked: (appContent.state === "DesktopComponents")

            onClicked: screenDesktopComponents.loadScreen()
        }
        DesktopSidebarMenu {
            text: qsTr("Mobile")
            source: "qrc:/IconLibrary/material-symbols/hardware/smartphone-fill.svg"
            checked: (appContent.state === "MobileComponents")

            onClicked: screenMobileComponents.loadScreen()
        }
        DesktopSidebarSubMenu {
            text: qsTr("Tools")
            source: "qrc:/IconLibrary/material-symbols/build-fill.svg"

            checked: (appContent.state === "Playground" ||
                      appContent.state === "HostInfos" ||
                      appContent.state === "FontInfos")

            submenus: [
                { text: qsTr("Playground"), onClicked: function() { screenPlayground.loadScreen() } },
                { text: qsTr("Host info"), onClicked: function() { screenHostInfos.loadScreen() } },
                { text: qsTr("Fonts info"), onClicked: function() { screenFontInfos.loadScreen() }  }
            ]

            onClicked: screenPlayground.loadScreen()
        }
    }

    ////////////

    Column { // bottom menu
        anchors.left: parent.left
        anchors.leftMargin: 12
        anchors.right: parent.right
        anchors.rightMargin: 12
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 16
        spacing: 8

        DesktopSidebarMenu {
            text: qsTr("Settings")
            source: "qrc:/IconLibrary/material-icons/duotone/tune.svg"
            checked: (appContent.state === "Settings")

            onClicked: screenSettings.loadScreen()
        }

        DesktopSidebarMenu {
            text: qsTr("About")
            source: "qrc:/IconLibrary/material-icons/duotone/info.svg"
            checked: (appContent.state === "About")

            onClicked: screenAbout.loadScreen()
        }

        DesktopSidebarMenu {
            text: qsTr("Exit")
            source: "qrc:/IconLibrary/material-icons/duotone/exit_to_app.svg"
            onClicked: Qt.quit()
        }
    }

    ////////////
/*
    Column { // top menu
        anchors.top: parent.top
        anchors.topMargin: 32
        anchors.left: parent.left
        anchors.right: parent.right

        DesktopSidebarItem {
            source: "qrc:/assets/icons/material-symbols/hardware/computer.svg"
            sourceSize: 40

            highlightMode: "indicator"
            highlighted: (appContent.state === "DesktopComponents")
            onClicked: screenDesktopComponents.loadScreen()
        }
        DesktopSidebarItem {
            source: "qrc:/assets/icons/material-symbols/hardware/smartphone-fill.svg"
            sourceSize: 40
            highlightMode: "indicator"

            highlighted: (appContent.state === "MobileComponents")
            onClicked: screenMobileComponents.loadScreen()
        }
        DesktopSidebarItem {
            source: "qrc:/assets/icons/material-icons/duotone/touch_app.svg"
            sourceSize: 40

            highlightMode: "indicator"
            highlighted: (appContent.state === "Playground")

            onClicked: screenPlayground.loadScreen()
        }
        DesktopSidebarItem {
            source: "qrc:/assets/icons/material-icons/duotone/memory.svg"
            sourceSize: 40

            highlightMode: "indicator"
            highlighted: (appContent.state === "HostInfos")

            onClicked: screenHostInfos.loadScreen()
        }
        DesktopSidebarItem {
            source: "qrc:/assets/icons/material-icons/duotone/format_size.svg"
            sourceSize: 40

            highlightMode: "indicator"
            highlighted: (appContent.state === "FontInfos")

            onClicked: screenFontInfos.loadScreen()
        }
    }
*/
    ////////////
/*
    Column { // bottom menu
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 12

        DesktopSidebarItem {
            source: "qrc:/assets/icons/material-icons/duotone/tune.svg"
            sourceSize: 40

            highlightMode: "indicator"
            highlighted: (appContent.state === "Settings")

            onClicked: screenSettings.loadScreen()
        }

        DesktopSidebarItem {
            source: "qrc:/assets/icons/material-icons/duotone/info.svg"
            sourceSize: 40

            highlightMode: "indicator"
            highlighted: (appContent.state === "About")

            onClicked: screenAbout.loadScreen()
        }

        DesktopSidebarItem {
            source: "qrc:/assets/icons/material-icons/duotone/exit_to_app.svg"
            sourceSize: 40
            highlightMode: "circle"
            onClicked: Qt.quit()
        }
    }
*/
    ////////////

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

    ////////////
}
