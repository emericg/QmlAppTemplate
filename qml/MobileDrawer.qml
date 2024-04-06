import QtQuick
import QtQuick.Controls

import ThemeEngine

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

                height: Math.max(screenPaddingTop, screenPaddingStatusbar)
                color: Theme.colorStatusbar
            }

            ////////

            Rectangle { // logo area
                anchors.left: parent.left
                anchors.right: parent.right

                height: 80
                color: Theme.colorBackground

                Image {
                    id: imageHeader
                    anchors.left: parent.left
                    anchors.leftMargin: 12
                    anchors.verticalCenter: parent.verticalCenter

                    width: 40
                    height: 40
                    source: "qrc:/assets/gfx/logos/logo.svg"
                    sourceSize: Qt.size(width, height)
                }
                Text {
                    id: textHeader
                    anchors.left: imageHeader.right
                    anchors.leftMargin: 12
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: 0

                    text: "QmlAppTemplate"
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
            anchors.bottom: parent.bottom

            contentWidth: -1
            contentHeight: contentColumn.height

            Column {
                id: contentColumn
                anchors.left: parent.left
                anchors.right: parent.right

                ////////

                ListSeparatorPadded { }

                ////////

                DrawerItem {
                    text: qsTr("Components")
                    source: "qrc:/assets/icons/material-icons/duotone/touch_app.svg"
                    highlighted: (appContent.state === "MobileComponents")

                    onClicked: {
                        screenMobileComponents.loadScreen()
                        appDrawer.close()
                    }
                }

                DrawerItem {
                    text: qsTr("Host infos")
                    source: "qrc:/assets/icons/material-icons/duotone/memory.svg"
                    highlighted: (appContent.state === "HostInfos")

                    onClicked: {
                        screenHostInfos.loadScreen()
                        appDrawer.close()
                    }
                }

                DrawerItem {
                    text: qsTr("Font infos")
                    source: "qrc:/assets/icons/material-icons/duotone/format_size.svg"
                    highlighted: (appContent.state === "FontInfos")

                    onClicked: {
                        screenFontInfos.loadScreen()
                        appDrawer.close()
                    }
                }

                ////////

                ListSeparatorPadded { }

                ////////

                DrawerItem {
                    text: qsTr("Settings")
                    source: "qrc:/assets/icons/material-symbols/settings-fill.svg"
                    highlighted: (appContent.state === "Settings")

                    onClicked: {
                        screenSettings.loadScreen()
                        appDrawer.close()
                    }
                }

                DrawerItem {
                    text: qsTr("About")
                    source: "qrc:/assets/icons/material-symbols/info-fill.svg"
                    highlighted: (appContent.state === "About" || appContent.state === "AboutPermissions")

                    onClicked: {
                        screenAbout.loadScreen()
                        appDrawer.close()
                    }
                }

                ////////

                ListSeparatorPadded { }

                ////////
            }
        }

        ////////////////
    }
}
