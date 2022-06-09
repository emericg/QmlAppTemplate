import QtQuick 2.15
import QtQuick.Controls 2.15

import ThemeEngine 1.0

Rectangle {
    id: sideBar
    anchors.top: parent.top
    anchors.left: parent.left
    anchors.bottom: parent.bottom

    z: 10
    width: isHdpi ? 80 : 92
    color: Theme.colorSidebar

    ////////////////////////////////////////////////////////////////////////////

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

    ////////////////////////////////////////////////////////////////////////////

    Column {
        id: topMenu
        anchors.top: parent.top
        anchors.topMargin: 32
        anchors.left: parent.left
        anchors.right: parent.right

        DesktopSidebarItem {
            source: "qrc:/assets/icons_material/duotone-touch_app-24px.svg"
            sourceSize: 40
            highlightMode: "indicator"

            selected: (appContent.state === "MainView")
            onClicked: appContent.state = "MainView"
        }
        DesktopSidebarItem {
            source: "qrc:/assets/icons_material/duotone-memory-24px.svg"
            sourceSize: 40
            highlightMode: "indicator"

            selected: (appContent.state === "HostInfos")
            onClicked: appContent.state = "HostInfos"
        }
        DesktopSidebarItem {
            source: "qrc:/assets/icons_material/duotone-format_size-24px.svg"
            sourceSize: 40
            highlightMode: "indicator"

            selected: (appContent.state === "FontList")
            onClicked: appContent.state = "FontList"
        }
    }

    ////////////////////////////////////////////////////////////////////////////

    Column {
        id: bottomMenu
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 12

        DesktopSidebarItem {
            source: "qrc:/assets/icons_material/baseline-settings-20px.svg"
            sourceSize: 40
            highlightMode: "indicator"

            selected: (appContent.state === "Settings")
            onClicked: appContent.state = "Settings"
        }

        DesktopSidebarItem {
            source: "qrc:/assets/icons_material/outline-info-24px.svg"
            sourceSize: 40
            highlightMode: "indicator"

            selected: (appContent.state === "About")
            onClicked: appContent.state = "About"
        }

        DesktopSidebarItem {
            source: "qrc:/assets/icons_material/duotone-exit_to_app-24px.svg"
            sourceSize: 40
            highlightMode: "circle"

            onClicked: appWindow.close()
        }
    }

    ////////////////////////////////////////////////////////////////////////////
/*
    Rectangle { // shadow
        anchors.top: parent.top
        anchors.right: parent.left
        anchors.bottom: parent.bottom

        width: 8
        opacity: 0.66

        gradient: Gradient {
            orientation: Gradient.Horizontal
            GradientStop { position: 0.0; color: Theme.colorSidebarHighlight; }
            GradientStop { position: 1.0; color: Theme.colorBackground; }
        }
    }
*/
}
