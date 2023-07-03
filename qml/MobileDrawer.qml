import QtQuick 2.15
import QtQuick.Controls 2.15

import ThemeEngine 1.0

Drawer {
    width: (appWindow.screenOrientation === Qt.PortraitOrientation || appWindow.width < 480)
            ? 0.8 * appWindow.width : 0.5 * appWindow.width
    height: appWindow.height

    ////////////////////////////////////////////////////////////////////////////

    background: Rectangle {
        color: Theme.colorBackground

        Rectangle { // left border
            x: parent.width - 1
            width: 1
            height: parent.height
            color: Theme.colorSeparator
        }
    }

    ////////////////////////////////////////////////////////////////////////////

    contentItem: Item {

        Column {
            id: rectangleHeader
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.rightMargin: 1
            z: 5

            ////////

            Rectangle {
                id: rectangleStatusbar
                anchors.left: parent.left
                anchors.right: parent.right

                height: Math.max(screenPaddingTop, screenPaddingStatusbar)
                color: Theme.colorBackground // "red" // to hide flickable content
            }

            ////////

            Rectangle {
                id: rectangleLogo
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
                    source: "qrc:/assets/logos/logo.svg"
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

        ////////////////////////////////////////////////////////////////////////////

        Flickable {
            anchors.top: rectangleHeader.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom

            contentWidth: -1
            contentHeight: contentColumn.height

            Column {
                id: contentColumn
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.rightMargin: 1

                ////////

                ListSeparatorPadded { }

                ////////

                DrawerItem {
                    text: qsTr("Components")
                    iconSource: "qrc:/assets/icons_material/duotone-touch_app-24px.svg"
                    highlighted: (appContent.state === "MobileComponents")

                    onClicked: {
                        screenMobileComponents.loadScreen()
                        appDrawer.close()
                    }
                }

                DrawerItem {
                    text: qsTr("Host infos")
                    iconSource: "qrc:/assets/icons_material/duotone-memory-24px.svg"
                    highlighted: (appContent.state === "HostInfos")

                    onClicked: {
                        screenHostInfos.loadScreen()
                        appDrawer.close()
                    }
                }

                DrawerItem {
                    text: qsTr("Font infos")
                    iconSource: "qrc:/assets/icons_material/duotone-format_size-24px.svg"
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
                    iconSource: "qrc:/assets/icons_material/outline-settings-24px.svg"
                    highlighted: (appContent.state === "Settings")

                    onClicked: {
                        screenSettings.loadScreen()
                        appDrawer.close()
                    }
                }

                DrawerItem {
                    text: qsTr("About")
                    iconSource: "qrc:/assets/icons_material/outline-info-24px.svg"
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
    }

    ////////////////////////////////////////////////////////////////////////////
}
