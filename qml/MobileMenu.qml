import QtQuick

import ThemeEngine

Item {
    id: mobileMenu
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.bottom: parent.bottom

    property int hhh: (appWindow.isPhone ? 36 : 48)
    property int hhi: (hhh * 0.666)
    property int hhv: visible ? hhh : 0

    z: 10
    height: hhh + screenPaddingNavbar + screenPaddingBottom

    ////////////////////////////////////////////////////////////////////////////

    Rectangle { // background
        anchors.fill: parent
        opacity: 0.9
        color: appWindow.isTablet ? Theme.colorTabletmenu : Theme.colorBackground

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
/*
    Rectangle { // navbar area
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        height: screenPaddingNavbar + screenPaddingBottom

        visible: (!mobileMenu.visible || appContent.state === "Tutorial")
        opacity: 0.9
        color: {
            if (appContent.state === "Tutorial") return Theme.colorHeader
            return Theme.colorBackground
        }
    }
*/
    // prevent clicks below this area
    MouseArea { anchors.fill: parent; acceptedButtons: Qt.AllButtons; }

    ////////////////////////////////////////////////////////////////////////////

    Row {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: (-screenPaddingNavbar -screenPaddingBottom) / 2
        spacing: (!appWindow.wideMode || (appWindow.isPhone && utilsScreen.screenSize < 5.0)) ? -8 : 24

        MobileMenuItem_horizontal {
            id: menuComponents
            height: mobileMenu.hhh
            sourceSize: mobileMenu.hhi

            colorContent: Theme.colorTabletmenuContent
            colorHighlight: Theme.colorTabletmenuHighlight

            text: qsTr("Components")
            source: "qrc:/assets/icons_material/duotone-touch_app-24px.svg"
            highlighted: (appContent.state === "MobileComponents")
            onClicked: screenMobileComponents.loadScreen()
        }
        MobileMenuItem_horizontal {
            id: menuSettings
            height: mobileMenu.hhh
            sourceSize: mobileMenu.hhi

            colorContent: Theme.colorTabletmenuContent
            colorHighlight: Theme.colorTabletmenuHighlight

            text: qsTr("Settings")
            source: "qrc:/assets/icons_material/baseline-settings-20px.svg"
            highlighted: (appContent.state === "Settings")
            onClicked: screenSettings.loadScreen()
        }
        MobileMenuItem_horizontal {
            id: menuAbout
            height: mobileMenu.hhh
            sourceSize: mobileMenu.hhi

            colorContent: Theme.colorTabletmenuContent
            colorHighlight: Theme.colorTabletmenuHighlight

            text: qsTr("About")
            source: "qrc:/assets/icons_material/outline-info-24px.svg"
            highlighted: (appContent.state === "About" || appContent.state === "AboutPermissions")
            onClicked: screenAbout.loadScreen()
        }
    }

    ////////////////////////////////////////////////////////////////////////////
}
