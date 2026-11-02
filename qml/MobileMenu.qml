import QtQuick

import ComponentLibrary

Item {
    id: mobileMenu

    anchors.left: parent.left
    anchors.right: parent.right
    anchors.bottom: parent.bottom

    property int hhh: (Theme.isPhone ? 52 : 48)
    property int hhi: (Theme.isPhone ? 26 : (hhh * 0.5))
    property int www: 80

    property int contentHeight: visible ? hhh : 0
    height: (Theme.screenOrientation === Qt.PortraitOrientation)
                ? contentHeight + Math.max(Theme.screenPaddingNavbar, Theme.screenPaddingBottom) : 0

    // prevent clicks below this area
    MouseArea { anchors.fill: parent; acceptedButtons: Qt.AllButtons; }

    ////////////////////////////////////////////////////////////////////////////

    Rectangle { // menubar background area
        anchors.fill: parent

        opacity: 0.95
        color: Theme.colorTabletmenu

        Rectangle { // separator
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            height: 1

            visible: !Theme.isPhone
            color: Theme.colorTabletmenuContent
            opacity: 0.8
        }
    }

    Rectangle { // navbar background area
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        height: Math.max(Theme.screenPaddingNavbar, Theme.screenPaddingBottom)

        visible: (!mobileMenu.visible || appContent.state === "Tutorial")
        opacity: 0.95
        color: {
            if (appContent.state === "Tutorial") return Theme.colorHeader
            return Theme.colorBackground
        }
    }

    ////////////////////////////////////////////////////////////////////////////

    Item { // menubar area
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: mobileMenu.hhh

        Row {
            anchors.centerIn: parent

            spacing: Theme.componentMargin

            MobileMenuItem_vertical {
                id: menuComponents
                width: mobileMenu.www
                height: mobileMenu.hhh
                sourceSize: mobileMenu.hhi

                colorContent: Theme.colorTabletmenuContent
                colorHighlight: Theme.colorTabletmenuHighlight

                text: qsTr("Components")
                source: "qrc:/IconLibrary/material-icons/duotone/touch_app.svg"
                highlighted: (appContent.state === "MobileComponents")
                onClicked: screenMobileComponents.loadScreen()
            }
            MobileMenuItem_vertical {
                id: menuSettings
                width: mobileMenu.www
                height: mobileMenu.hhh
                sourceSize: mobileMenu.hhi

                colorContent: Theme.colorTabletmenuContent
                colorHighlight: Theme.colorTabletmenuHighlight

                text: qsTr("Settings")
                source: "qrc:/IconLibrary/material-symbols/settings-fill.svg"
                highlighted: (appContent.state === "ScreenSettings")
                onClicked: screenSettings.loadScreen()
            }
            MobileMenuItem_vertical {
                id: menuAbout
                width: mobileMenu.www
                height: mobileMenu.hhh
                sourceSize: mobileMenu.hhi

                colorContent: Theme.colorTabletmenuContent
                colorHighlight: Theme.colorTabletmenuHighlight

                text: qsTr("About")
                source: "qrc:/IconLibrary/material-symbols/info-fill.svg"
                highlighted: (appContent.state === "ScreenAbout" ||
                              appContent.state === "ScreenAboutPermissions")
                onClicked: screenAbout.loadScreen()
            }
        }
    }

    ////////////////////////////////////////////////////////////////////////////
}
