import QtQuick

import ThemeEngine

Item {
    id: mobileMenu
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.bottom: parent.bottom

    //property int hhh: (appWindow.isPhone ? 36 : 48)
    property int hhh: 60
    property int hhi: (hhh * 0.4)
    property int hhv: visible ? hhh : 0
    property int www: 80

    z: 10
    height: hhh + screenPaddingNavbar + screenPaddingBottom

    // prevent clicks below this area
    MouseArea { anchors.fill: parent; acceptedButtons: Qt.AllButtons; }

    ////////////////////////////////////////////////////////////////////////////

    Rectangle { // menubar background area
        anchors.fill: parent
        opacity: 0.95
        color: Theme.colorTabletmenu

        Rectangle {
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            height: 1
            opacity: 0.8
            visible: !appWindow.isPhone
            color: Theme.colorTabletmenuContent
        }
    }

    Rectangle { // navbar background area
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        height: screenPaddingNavbar + screenPaddingBottom

        visible: (!mobileMenu.visible || appContent.state === "Tutorial")
        opacity: 0.95
        color: {
            if (appContent.state === "Tutorial") return Theme.colorHeader
            return Theme.colorBackground
        }
    }

    ////////////////////////////////////////////////////////////////////////////

    Item { // buttons area
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
                source: "qrc:/assets/icons/material-icons/duotone/touch_app.svg"
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
                source: "qrc:/assets/icons/material-symbols/settings-fill.svg"
                highlighted: (appContent.state === "Settings")
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
                source: "qrc:/assets/icons/material-symbols/info-fill.svg"
                highlighted: (appContent.state === "About" || appContent.state === "AboutPermissions")
                onClicked: screenAbout.loadScreen()
            }
        }
    }

    ////////////////////////////////////////////////////////////////////////////
}
