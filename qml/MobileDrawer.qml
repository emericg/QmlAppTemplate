import QtQuick

import ComponentLibrary
import AppUtils

DrawerThemed {
    contentItem: Item {

        ////////////////

        Column {
            id: headerColumn

            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            z: 5

            ////////

            Rectangle { // statusbar area
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.rightMargin: -1

                height: Math.max(Theme.screenPaddingTop, Theme.screenPaddingStatusbar)
                color: Theme.colorStatusbar // to be able to read statusbar content
            }

            ////////

            Rectangle { // logo area
                anchors.left: parent.left
                anchors.right: parent.right

                height: appHeader.hideInLandscape ? 0 : 80
                color: Theme.colorBackground

                Image {
                    id: imageHeader
                    anchors.left: parent.left
                    anchors.leftMargin: 12
                    anchors.verticalCenter: parent.verticalCenter

                    width: 40
                    height: 40
                    source: "qrc:/assets/logos/logo.svg"
                    sourceSize: Qt.size(width*2, height*2)
                }
                Text {
                    id: textHeader
                    anchors.left: imageHeader.right
                    anchors.leftMargin: 12
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: 0

                    text: UtilsApp.appName()
                    textFormat: Text.PlainText
                    color: Theme.colorText
                    font.bold: true
                    font.pixelSize: Theme.fontSizeTitle
                }
            }

            ////////
        }

        ////////////////

        Flickable {
            anchors.top: headerColumn.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: footerColumn.top

            contentWidth: -1
            contentHeight: contentColumn.height

            Column {
                id: contentColumn
                anchors.left: parent.left
                anchors.right: parent.right

                topPadding: 0
                bottomPadding: Math.max(Theme.screenPaddingNavbar, Theme.screenPaddingBottom)

                ListSeparatorPadded { }

                ////////

                DrawerItem_menu {
                    text: qsTr("Components")
                    source: "qrc:/IconLibrary/material-icons/duotone/touch_app.svg"
                    highlighted: (appContent.state === "MobileComponents")

                    onClicked: {
                        screenMobileComponents.loadScreen()
                        appDrawer.close()
                    }
                }

                DrawerItem_menu {
                    text: qsTr("Playgrounds")
                    source: "qrc:/IconLibrary/material-symbols/build-fill.svg"
                    highlighted: (appContent.state === "Playgrounds")

                    onClicked: {
                        screenPlayground.loadScreen()
                        appDrawer.close()
                    }
                }

                DrawerItem_menu {
                    text: qsTr("Host infos")
                    source: "qrc:/IconLibrary/material-icons/duotone/memory.svg"
                    highlighted: (appContent.state === "HostInfos")

                    onClicked: {
                        screenHostInfos.loadScreen()
                        appDrawer.close()
                    }
                }

                DrawerItem_menu {
                    text: qsTr("Font infos")
                    source: "qrc:/IconLibrary/material-icons/duotone/format_size.svg"
                    highlighted: (appContent.state === "FontInfos")

                    onClicked: {
                        screenFontInfos.loadScreen()
                        appDrawer.close()
                    }
                }

                ////////

                ListSeparatorPadded { }

                DrawerItem_menu {
                    text: qsTr("Settings")
                    source: "qrc:/IconLibrary/material-symbols/settings-fill.svg"
                    highlighted: (appContent.state === "ScreenSettings")

                    onClicked: {
                        screenSettings.loadScreen()
                        appDrawer.close()
                    }
                }

                DrawerItem_menu {
                    text: qsTr("About")
                    source: "qrc:/IconLibrary/material-symbols/info-fill.svg"
                    highlighted: (appContent.state === "ScreenAbout" ||
                                  appContent.state === "ScreenAboutPermissions")

                    onClicked: {
                        screenAbout.loadScreen()
                        appDrawer.close()
                    }
                }

                ListSeparatorPadded { }

                ////////
            }
        }

        ////////////////

        Column {
            id: footerColumn

            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            z: 5

            Rectangle { // navbar area
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.rightMargin: -1

                height: Math.max(Theme.screenPaddingNavbar, Theme.screenPaddingBottom)
                color: Theme.colorTabletmenu
                opacity: 0.95
            }
        }

        ////////////////
    }
}
