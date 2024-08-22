import QtQuick
import QtQuick.Controls

import ThemeEngine
import "qrc:/utils/UtilsNumber.js" as UtilsNumber

Loader {
    id: screenAbout
    anchors.fill: parent

    function loadScreen() {
        // load screen
        screenAbout.active = true

        // change screen
        appContent.state = "About"
    }

    function backAction() {
        if (screenAbout.status === Loader.Ready)
            screenAbout.item.backAction()
    }

    ////////////////////////////////////////////////////////////////////////////

    active: false
    asynchronous: false

    sourceComponent: Flickable {
        anchors.fill: parent

        contentWidth: -1
        contentHeight: contentColumn.height

        boundsBehavior: isDesktop ? Flickable.OvershootBounds : Flickable.DragAndOvershootBounds
        ScrollBar.vertical: ScrollBar { visible: false }

        ////////

        function backAction() {
            if (isDesktop) screenDesktopComponents.loadScreen()
            else if (isMobile) screenMobileComponents.loadScreen()
        }

        ////////

        Column {
            id: contentColumn

            anchors.left: parent.left
            anchors.right: parent.right

            ////////////////

            Rectangle { // header area
                anchors.left: parent.left
                anchors.leftMargin: -screenPaddingLeft
                anchors.right: parent.right
                anchors.rightMargin: -screenPaddingRight

                height: 96
                color: Theme.colorForeground

                Row {
                    anchors.left: parent.left
                    anchors.leftMargin: screenPaddingLeft + Theme.componentMargin
                    anchors.verticalCenter: parent.verticalCenter

                    z: 2
                    height: 96
                    spacing: Theme.componentMargin

                    Image { // logo
                        width: 80
                        height: 80
                        anchors.verticalCenter: parent.verticalCenter

                        source: "qrc:/assets/gfx/logos/logo.svg"
                        sourceSize: Qt.size(width, height)
                    }

                    Column {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.verticalCenterOffset: -2

                        Text {
                            text: "QmlAppTemplate"
                            color: Theme.colorText
                            font.pixelSize: Theme.fontSizeTitle
                        }
                        Text {
                            color: Theme.colorSubText
                            text: qsTr("version %1 %2").arg(utilsApp.appVersion()).arg(utilsApp.appBuildMode())
                            font.pixelSize: Theme.fontSizeContentBig
                        }
                    }
                }

                Row {
                    anchors.right: parent.right
                    anchors.rightMargin: screenPaddingRight + Theme.componentMargin
                    anchors.verticalCenter: parent.verticalCenter

                    visible: wideWideMode
                    spacing: Theme.componentMargin

                    ButtonSolid {
                        width: isPhone ? 150 : 160

                        text: qsTr("WEBSITE")
                        source: "qrc:/assets/icons/material-symbols/link.svg"
                        sourceSize: 28
                        onClicked: Qt.openUrlExternally("https://emeric.io/")
                    }

                    ButtonSolid {
                        width: isPhone ? 150 : 160

                        text: qsTr("SUPPORT")
                        source: "qrc:/assets/icons/material-symbols/support.svg"
                        sourceSize: 22
                        onClicked: Qt.openUrlExternally("https://emeric.io/")
                    }

                    ButtonSolid {
                        width: isPhone ? 150 : 160
                        visible: (appWindow.width > 800)

                        text: qsTr("GitHub")
                        source: "qrc:/assets/gfx/logos/github.svg"
                        sourceSize: 22
                        onClicked: Qt.openUrlExternally("https://github.com/emericg/QmlAppTemplate")
                    }
                }

                Rectangle { // bottom separator
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    height: 2
                    visible: isDesktop
                    border.color: Theme.colorSeparator
                }
            }

            ////////////////

            Row { // buttons row
                height: 72

                anchors.left: parent.left
                anchors.leftMargin: screenPaddingLeft + Theme.componentMargin
                anchors.right: parent.right
                anchors.rightMargin: screenPaddingRight + Theme.componentMargin

                visible: !wideWideMode
                spacing: Theme.componentMargin

                ButtonSolid {
                    anchors.verticalCenter: parent.verticalCenter
                    width: ((parent.width - parent.spacing) / 2)

                    text: qsTr("WEBSITE")
                    source: "qrc:/assets/icons/material-symbols/link.svg"
                    sourceSize: 28
                    onClicked: Qt.openUrlExternally("https://emeric.io/")
                }

                ButtonSolid {
                    width: ((parent.width - parent.spacing) / 2)
                    anchors.verticalCenter: parent.verticalCenter

                    text: qsTr("SUPPORT")
                    source: "qrc:/assets/icons/material-symbols/support.svg"
                    sourceSize: 22
                    onClicked: Qt.openUrlExternally("https://emeric.io/")
                }
            }

            ////////////////

            ListItem { // description
                anchors.left: parent.left
                anchors.right: parent.right

                text: qsTr("A Qt6 / QML application template, with a full set of visual controls, as well as build and deploy scripts and CI setups.")
                source: "qrc:/assets/icons/material-symbols/info.svg"
            }

            ListItemClickable { // authors
                anchors.left: parent.left
                anchors.right: parent.right

                text: qsTr("Application by <a href=\"https://emeric.io\">Emeric Grange</a>")
                source: "qrc:/assets/icons/material-symbols/supervised_user_circle.svg"
                indicatorSource: "qrc:/assets/icons/material-icons/duotone/launch.svg"
                onClicked: Qt.openUrlExternally("https://emeric.io")
            }

            ListItemClickable { // rate
                anchors.left: parent.left
                anchors.right: parent.right

                //visible: (Qt.platform.os === "android" || Qt.platform.os === "ios")

                text: qsTr("Rate the application")
                source: "qrc:/assets/icons/material-symbols/stars-fill.svg"
                indicatorSource: "qrc:/assets/icons/material-icons/duotone/launch.svg"
                onClicked: Qt.openUrlExternally("https://github.com/emericg/QmlAppTemplate")
            }

            ListSeparator { }

            ////////

            ListItemClickable { // tutorial
                anchors.left: parent.left
                anchors.right: parent.right

                text: qsTr("Open the tutorial")
                source: "qrc:/assets/icons/material-symbols/menu_book-fill.svg"
                sourceSize: 28
                indicatorSource: "qrc:/assets/icons/material-symbols/chevron_right.svg"
                //onClicked: screenTutorial.openFrom("ScreenAbout")
            }

            ListSeparator { }

            ////////

            ListItemClickable { // permissions
                anchors.left: parent.left
                anchors.right: parent.right

                visible: (Qt.platform.os === "android")

                text: qsTr("About app permissions")
                source: "qrc:/assets/icons/material-symbols/flaky.svg"
                indicatorSource: "qrc:/assets/icons/material-symbols/chevron_right.svg"
                onClicked: screenAboutPermissions.loadScreen()
            }

            ListSeparator { visible: (Qt.platform.os === "android") }

            ////////

            Item { // list dependencies
                anchors.left: parent.left
                anchors.leftMargin: Theme.componentMargin
                anchors.right: parent.right
                anchors.rightMargin: Theme.componentMargin

                height: 40 + dependenciesText.height + dependenciesColumn.height

                IconSvg {
                    width: 24
                    height: 24
                    anchors.left: parent.left
                    anchors.leftMargin: 4
                    anchors.verticalCenter: dependenciesText.verticalCenter

                    source: "qrc:/assets/icons/material-symbols/settings-fill.svg"
                    color: Theme.colorSubText
                }

                Text {
                    id: dependenciesText
                    anchors.top: parent.top
                    anchors.topMargin: 16
                    anchors.left: parent.left
                    anchors.leftMargin: appHeader.headerPosition - parent.anchors.leftMargin
                    anchors.right: parent.right
                    anchors.rightMargin: 8

                    text: qsTr("This application is made possible thanks to a couple of third party open source projects:")
                    textFormat: Text.PlainText
                    color: Theme.colorSubText
                    font.pixelSize: Theme.fontSizeContent
                    wrapMode: Text.WordWrap
                }

                Column {
                    id: dependenciesColumn
                    anchors.top: dependenciesText.bottom
                    anchors.topMargin: 8
                    anchors.left: parent.left
                    anchors.leftMargin: appHeader.headerPosition - parent.anchors.leftMargin
                    anchors.right: parent.right
                    anchors.rightMargin: 8
                    spacing: 4

                    Repeater {
                        model: [
                            "Qt6 (LGPL v3)",
                            "MobileUI (MIT)",
                            "MobileSharing (MIT)",
                            "SingleApplication (MIT)",
                            "Google Material Icons (MIT)",
                        ]
                        delegate: Text {
                            anchors.left: parent.left
                            anchors.right: parent.right

                            text: "- " + modelData
                            textFormat: Text.PlainText
                            color: Theme.colorSubText
                            font.pixelSize: Theme.fontSizeContent
                            wrapMode: Text.WordWrap
                        }
                    }
                }
            }

            ListSeparator { }

            ////////

            Item { // list translators
                anchors.left: parent.left
                anchors.leftMargin: Theme.componentMargin
                anchors.right: parent.right
                anchors.rightMargin: Theme.componentMargin

                height: 40 + translatorsText.height + translatorsColumn.height

                IconSvg {
                    anchors.left: parent.left
                    anchors.leftMargin: 4
                    anchors.verticalCenter: translatorsText.verticalCenter
                    width: 24
                    height: 24

                    source: "qrc:/assets/icons/material-icons/duotone/translate.svg"
                    color: Theme.colorSubText
                }

                Text {
                    id: translatorsText
                    anchors.top: parent.top
                    anchors.topMargin: 16
                    anchors.left: parent.left
                    anchors.leftMargin: appHeader.headerPosition - parent.anchors.leftMargin
                    anchors.right: parent.right
                    anchors.rightMargin: 8

                    text: qsTr("Special thanks to our translators:")
                    textFormat: Text.PlainText
                    color: Theme.colorSubText
                    font.pixelSize: Theme.fontSizeContent
                    wrapMode: Text.WordWrap
                }

                Column {
                    id: translatorsColumn
                    anchors.top: translatorsText.bottom
                    anchors.topMargin: 8
                    anchors.left: parent.left
                    anchors.leftMargin: appHeader.headerPosition - parent.anchors.leftMargin
                    anchors.right: parent.right
                    anchors.rightMargin: 8
                    spacing: 4

                    Repeater {
                        model: [
                            "Translator 1 (Español)",
                            "Translator 2 (French)",
                            "Translator 9 (Klingon)",
                        ]
                        delegate: Text {
                            anchors.left: parent.left
                            anchors.right: parent.right

                            text: "- " + modelData
                            textFormat: Text.PlainText
                            color: Theme.colorSubText
                            font.pixelSize: Theme.fontSizeContent
                            wrapMode: Text.WordWrap
                        }
                    }
                }
            }

            ListSeparator { }

            ////////

            Item { // list debug infos
                anchors.left: parent.left
                anchors.leftMargin: Theme.componentMargin
                anchors.right: parent.right
                anchors.rightMargin: Theme.componentMargin

                height: 32 + debugColumn.height
                visible: utilsApp.isDebugBuild()

                IconSvg {
                    anchors.top: debugColumn.top
                    anchors.topMargin: 0
                    anchors.left: parent.left
                    anchors.leftMargin: 4
                    width: 24
                    height: 24

                    source: "qrc:/assets/icons/material-symbols/info.svg"
                    color: Theme.colorSubText
                }

                Column {
                    id: debugColumn
                    anchors.left: parent.left
                    anchors.leftMargin: appHeader.headerPosition - parent.anchors.leftMargin
                    anchors.right: parent.right
                    anchors.rightMargin: 8
                    anchors.verticalCenter: parent.verticalCenter

                    spacing: Theme.componentMargin * 0.33

                    Text {
                        color: Theme.colorSubText
                        text: "App name: %1".arg(utilsApp.appName())
                        textFormat: Text.PlainText
                        font.pixelSize: Theme.fontSizeContent
                    }
                    Text {
                        color: Theme.colorSubText
                        text: "App version: %1".arg(utilsApp.appVersion())
                        textFormat: Text.PlainText
                        font.pixelSize: Theme.fontSizeContent
                    }
                    Text {
                        color: Theme.colorSubText
                        text: "Build mode: %1".arg(utilsApp.appBuildModeFull())
                        textFormat: Text.PlainText
                        font.pixelSize: Theme.fontSizeContent
                    }
                    Text {
                        color: Theme.colorSubText
                        text: "Build architecture: %1".arg(utilsApp.qtArchitecture())
                        textFormat: Text.PlainText
                        font.pixelSize: Theme.fontSizeContent
                    }
                    Text {
                        color: Theme.colorSubText
                        text: "Build date: %1".arg(utilsApp.appBuildDateTime())
                        textFormat: Text.PlainText
                        font.pixelSize: Theme.fontSizeContent
                    }
                    Text {
                        color: Theme.colorSubText
                        text: "Qt version: %1".arg(utilsApp.qtVersion())
                        textFormat: Text.PlainText
                        font.pixelSize: Theme.fontSizeContent
                    }
                }
            }

            ListSeparator { visible: utilsApp.isDebugBuild() }

            ////////

        }
    }

    ////////////////////////////////////////////////////////////////////////////
}
