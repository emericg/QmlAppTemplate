import QtQuick

import ComponentLibrary

Rectangle {
    id: appSidebar

    anchors.top: parent.top
    anchors.left: parent.left
    anchors.bottom: parent.bottom

    width: iconsSection.width + menusSection.width
    z: 10

    color: Theme.colorSidebar

    ////////////////

    DragHandler {
        // Drag on the sidebar to drag the whole window // Qt 5.15+
        // Also, prevent clicks below this area
        onActiveChanged: if (active) appWindow.startSystemMove()
        target: null
    }

    ////////////////

    Rectangle {
        id: iconsSection

        anchors.top: parent.top
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        width: 64

        color: Theme.colorSeparator

        Column { // top icons
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right

            topPadding: 16
            bottomPadding: 16
            spacing: 8

            DesktopSidebarItem_icon {
                source: "qrc:/IconLibrary/material-symbols/home.svg"
                //text: qsTr("Home")

                checked: (appContent.state === "MainView")
                onClicked: screenMainView.loadScreen()
            }

            DesktopSidebarItem_icon {
                source: "qrc:/IconLibrary/material-symbols/hardware/computer.svg"
                //text: qsTr("Components")

                checked: (appContent.state === "DesktopComponents" ||
                          appContent.state === "MobileComponents")
                onClicked: screenDesktopComponents.loadScreen()
            }

            DesktopSidebarItem_icon {
                source: "qrc:/IconLibrary/material-symbols/build.svg"
                //text: qsTr("Tools")

                checked: (appContent.state === "Playgrounds" ||
                          appContent.state === "HostInfos" ||
                          appContent.state === "FontInfos")
                onClicked: screenPlayground.loadScreen()
            }
        }
    }

    ////////////////

    Item {
        id: menusSection
        anchors.top: parent.top
        anchors.left: iconsSection.right
        anchors.bottom: parent.bottom
        width: isHdpi ? 240 : 300

        ////////

        Column { // top menu
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.leftMargin: 12
            anchors.right: parent.right
            anchors.rightMargin: 12 + 2

            topPadding: 16
            bottomPadding: 16
            spacing: 8
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

        ////////

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

        ////////
    }

    ////////////////

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

    ////////////////
}
