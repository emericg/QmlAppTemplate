import QtQuick

import ComponentLibrary

Item {
    id: mobileMenu

    anchors.left: parent.left
    anchors.right: parent.right
    anchors.bottom: parent.bottom

    height: (contentHeight + navbarHeight)

    ////////////////////////////////////////////////////////////////////////////

    property int hhh: (Theme.isPhone ? 48 : 48)
    property int hhi: (Theme.isPhone ? 26 : (hhh * 0.5))
    property int www: 80

    readonly property bool hideInLandscape: (Theme.isPhone && Theme.screenOrientation !== Qt.PortraitOrientation)

    readonly property int contentHeight: hideInLandscape ? 0 : hhh
    readonly property int navbarHeight: Math.max(Theme.screenPaddingNavbar, Theme.screenPaddingBottom)

    // prevent clicks below this area
    MouseArea { anchors.fill: parent; acceptedButtons: Qt.AllButtons; }

    ////////////////////////////////////////////////////////////////////////////

    Rectangle { // menubar background area
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: mobileMenu.contentHeight

        visible: !mobileMenu.hideInLandscape
        color: Theme.colorTabletmenu
        opacity: 0.95

        Rectangle { // separator
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            height: Theme.isPhone ? 0 : 2
            opacity: Theme.isPhone ? 0.24 : 0.33
            color: Theme.colorTabletmenuContent
        }
    }

    Rectangle { // navbar background area
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        height: mobileMenu.navbarHeight

        opacity: 0.95
        color: {
            if (appContent.state === "Tutorial") return Theme.colorHeader
            return Theme.colorTabletmenu
        }
    }

    ////////////////////////////////////////////////////////////////////////////

    Item { // menubar area
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: mobileMenu.hhh

        visible: !mobileMenu.hideInLandscape

        Row {
            anchors.centerIn: parent
            anchors.verticalCenterOffset: 4

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
