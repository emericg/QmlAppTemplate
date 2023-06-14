import QtQuick 2.15

import ThemeEngine 1.0

Rectangle {
    id: mobileMenu
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.bottom: parent.bottom

    property int hhh: (appWindow.isPhone ? 36 : 48)
    property int hhi: (hhh * 0.666)
    property int hhv: visible ? hhh : 0

    z: 10
    height: hhh + screenPaddingBottom
    color: appWindow.isTablet ? Theme.colorTabletmenu : Theme.colorBackground

    ////////////////////////////////////////////////////////////////////////////

    Rectangle {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: 1
        opacity: 0.5
        visible: !appWindow.isPhone
        color: Theme.colorTabletmenuContent
    }

    // prevent clicks below this area
    MouseArea { anchors.fill: parent; acceptedButtons: Qt.AllButtons; }

    ////////////////////////////////////////////////////////////////////////////

    Row {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -screenPaddingBottom
        spacing: (!appWindow.wideMode || (appWindow.isPhone && utilsScreen.screenSize < 5.0)) ? -8 : 24

        MobileMenuItem_horizontal {
            id: menuComponents
            height: mobileMenu.hhh
            sourceSize: mobileMenu.hhi

            colorContent: Theme.colorTabletmenuContent
            colorHighlight: Theme.colorTabletmenuHighlight

            text: qsTr("Components")
            source: "qrc:/assets/icons_material/duotone-touch_app-24px.svg"
            selected: (appContent.state === "MobileComponents")
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
            selected: (appContent.state === "Settings")
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
            selected: (appContent.state === "About" || appContent.state === "AboutPermissions")
            onClicked: screenAbout.loadScreen()
        }
    }
}
