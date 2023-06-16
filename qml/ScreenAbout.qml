import QtQuick
import QtQuick.Controls

import ThemeEngine 1.0
import "qrc:/js/UtilsNumber.js" as UtilsNumber

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
        ScrollBar.vertical: ScrollBar { visible: isDesktop; }

        function backAction() {
            screenMainView.loadScreen()
        }

        Column {
            id: contentColumn

            anchors.left: parent.left
            anchors.right: parent.right

            ////////////////

            Rectangle { // header area
                anchors.left: parent.left
                anchors.right: parent.right

                height: 96
                color: Theme.colorForeground

                Row {
                    anchors.left: parent.left
                    anchors.leftMargin: Theme.componentMargin
                    anchors.verticalCenter: parent.verticalCenter

                    z: 2
                    height: 96
                    spacing: Theme.componentMargin

                    Image { // logo
                        width: 80
                        height: 80
                        anchors.verticalCenter: parent.verticalCenter

                        source: "qrc:/assets/logos/logo.svg"
                        sourceSize: Qt.size(width, height)
                    }

                    Column {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.verticalCenterOffset: 2
                        spacing: 0

                        Text {
                            text: "QmlAppTemplate"
                            color: Theme.colorText
                            font.pixelSize: 28
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
                    anchors.rightMargin: Theme.componentMargin
                    anchors.verticalCenter: parent.verticalCenter

                    visible: wideWideMode
                    spacing: Theme.componentMargin

                    ButtonWireframeIconCentered {
                        width: 160
                        sourceSize: 28
                        fullColor: true
                        primaryColor: Theme.colorMaterialBlue

                        text: qsTr("WEBSITE")
                        source: "qrc:/assets/icons_material/baseline-insert_link-24px.svg"
                        onClicked: Qt.openUrlExternally("https://emeric.io/")
                    }

                    ButtonWireframeIconCentered {
                        width: 160
                        sourceSize: 22
                        fullColor: true
                        primaryColor: Theme.colorMaterialBlue

                        text: qsTr("SUPPORT")
                        source: "qrc:/assets/icons_material/baseline-support-24px.svg"
                        onClicked: Qt.openUrlExternally("https://emeric.io/")
                    }

                    ButtonWireframeIconCentered {
                        width: 160
                        sourceSize: 22
                        fullColor: true
                        primaryColor: Theme.colorMaterialBlue
                        visible: (appWindow.width > 800)

                        text: qsTr("GitHub")
                        source: "qrc:/assets/logos/github.svg"
                        onClicked: Qt.openUrlExternally("https://github.com/emericg/QmlAppTemplate")
                    }
                }

                Rectangle { // bottom separator
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    height: 2
                    visible: isDesktop
                    border.color: Qt.darker(parent.color, 1.03)
                }
            }

            ////////////////

            Row {
                id: buttonsRow
                height: 64

                anchors.left: parent.left
                anchors.leftMargin: screenPaddingLeft + Theme.componentMargin
                anchors.right: parent.right
                anchors.rightMargin: screenPaddingRight + Theme.componentMargin

                visible: !wideWideMode
                spacing: Theme.componentMargin

                ButtonWireframeIconCentered {
                    width: ((parent.width - parent.spacing) / 2)
                    anchors.verticalCenter: parent.verticalCenter

                    sourceSize: 28
                    fullColor: true
                    primaryColor: Theme.colorMaterialBlue

                    text: qsTr("WEBSITE")
                    source: "qrc:/assets/icons_material/baseline-insert_link-24px.svg"
                    onClicked: Qt.openUrlExternally("https://emeric.io/")
                }

                ButtonWireframeIconCentered {
                    width: ((parent.width - parent.spacing) / 2)
                    anchors.verticalCenter: parent.verticalCenter

                    sourceSize: 22
                    fullColor: true
                    primaryColor: Theme.colorMaterialBlue

                    text: qsTr("SUPPORT")
                    source: "qrc:/assets/icons_material/baseline-support-24px.svg"
                    onClicked: Qt.openUrlExternally("https://emeric.io/")
                }
            }

            ////////

            ListItem { // description
                width: parent.width
                text: qsTr("A Qt6 / QML application template, with a full set of visual controls, as well as build and deploy scripts and CI setups.")
                iconSource: "qrc:/assets/icons_material/outline-info-24px.svg"
            }

            ////////

            ListItemClickable { // authors
                width: parent.width
                text: qsTr("Application by <a href=\"https://emeric.io\">Emeric Grange</a>")
                iconSource: "qrc:/assets/icons_material/baseline-supervised_user_circle-24px.svg"
                indicatorSource: "qrc:/assets/icons_material/duotone-launch-24px.svg"
                onClicked: Qt.openUrlExternally("https://emeric.io")
            }

            ListItemClickable { // rate
                width: parent.width
                visible: (Qt.platform.os === "android" || Qt.platform.os === "ios")

                text: qsTr("Rate the application")
                iconSource: "qrc:/assets/icons_material/baseline-stars-24px.svg"
                indicatorSource: "qrc:/assets/icons_material/duotone-launch-24px.svg"
                onClicked: Qt.openUrlExternally("https://github.com/emericg/QmlAppTemplate")
            }

            ListItemClickable { // tutorial
                width: parent.width

                text: qsTr("Open the tutorial")
                iconSource: "qrc:/assets/icons_material/baseline-import_contacts-24px.svg"
                iconSize: 28
                indicatorSource: "qrc:/assets/icons_material/baseline-chevron_right-24px.svg"
                //onClicked: screenTutorial.openFrom("ScreenAbout")
            }

            ////////

            ListSeparator { visible: (Qt.platform.os === "android") }

            ListItemClickable { // permissions
                width: parent.width
                visible: (Qt.platform.os === "android")

                text: qsTr("About app permissions")
                iconSource: "qrc:/assets/icons_material/baseline-flaky-24px.svg"
                indicatorSource: "qrc:/assets/icons_material/baseline-chevron_right-24px.svg"
                onClicked: screenAboutPermissions.loadScreen()
            }

            ////////

            ListSeparator { }

            Item {
                id: dependencies
                anchors.left: parent.left
                anchors.leftMargin: screenPaddingLeft + Theme.componentMargin
                anchors.right: parent.right
                anchors.rightMargin: screenPaddingRight + Theme.componentMargin

                height: 32 + dependenciesText.height + dependenciesColumn.height

                IconSvg {
                    id: dependenciesImg
                    width: 24
                    height: 24
                    anchors.left: parent.left
                    anchors.leftMargin: 4
                    anchors.verticalCenter: dependenciesText.verticalCenter

                    source: "qrc:/assets/icons_material/baseline-settings-20px.svg"
                    color: Theme.colorSubText
                }

                Text {
                    id: dependenciesText
                    anchors.top: parent.top
                    anchors.topMargin: 12
                    anchors.left: parent.left
                    anchors.leftMargin: 48
                    anchors.right: parent.right
                    anchors.rightMargin: 8

                    text: qsTr("This application is made possible thanks to a couple of third party open source projects:")
                    textFormat: Text.PlainText
                    font.pixelSize: Theme.fontSizeContent
                    color: Theme.colorSubText
                    wrapMode: Text.WordWrap
                    verticalAlignment: Text.AlignVCenter
                }

                Column {
                    id: dependenciesColumn
                    anchors.top: dependenciesText.bottom
                    anchors.topMargin: 8
                    anchors.left: dependenciesText.left
                    anchors.right: parent.right
                    spacing: 4

                    Text {
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.rightMargin: 12

                        text: "- Qt6 (LGPL 3)"
                        textFormat: Text.PlainText
                        color: Theme.colorSubText
                        font.pixelSize: Theme.fontSizeContent
                        wrapMode: Text.WordWrap
                    }
                    Text {
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.rightMargin: 12

                        text: "- SingleApplication (MIT)"
                        textFormat: Text.PlainText
                        color: Theme.colorSubText
                        font.pixelSize: Theme.fontSizeContent
                        wrapMode: Text.WordWrap
                    }
                    Text {
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.rightMargin: 12

                        text: "- Google Material Icons (MIT)"
                        textFormat: Text.PlainText
                        color: Theme.colorSubText
                        font.pixelSize: Theme.fontSizeContent
                        wrapMode: Text.WordWrap
                    }
                    Text {
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.rightMargin: 12

                        text: "- MobileUI & MobileSharing (MIT)"
                        textFormat: Text.PlainText
                        color: Theme.colorSubText
                        font.pixelSize: Theme.fontSizeContent
                        wrapMode: Text.WordWrap
                    }
                }
            }

            ////////

            ListSeparator { }

            Item {
                id: translators
                anchors.left: parent.left
                anchors.leftMargin: screenPaddingLeft + Theme.componentMargin
                anchors.right: parent.right
                anchors.rightMargin: screenPaddingRight + Theme.componentMargin

                height: 32 + translatorsText.height + translatorsColumn.height

                IconSvg {
                    id: translatorsImg
                    width: 24
                    height: 24
                    anchors.left: parent.left
                    anchors.leftMargin: 4
                    anchors.verticalCenter: translatorsText.verticalCenter

                    source: "qrc:/assets/icons_material/duotone-translate-24px.svg"
                    color: Theme.colorSubText
                }

                Text {
                    id: translatorsText
                    anchors.top: parent.top
                    anchors.topMargin: 12
                    anchors.left: parent.left
                    anchors.leftMargin: 48
                    anchors.right: parent.right
                    anchors.rightMargin: 8

                    text: qsTr("Special thanks to our translators:")
                    textFormat: Text.PlainText
                    font.pixelSize: Theme.fontSizeContent
                    color: Theme.colorSubText
                    wrapMode: Text.WordWrap
                    verticalAlignment: Text.AlignVCenter
                }

                Column {
                    id: translatorsColumn
                    anchors.top: translatorsText.bottom
                    anchors.topMargin: 8
                    anchors.left: translatorsText.left
                    anchors.right: parent.right
                    spacing: 4

                    Text {
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.rightMargin: 12

                        text: "- Translator 1 (Español)"
                        textFormat: Text.PlainText
                        color: Theme.colorSubText
                        font.pixelSize: Theme.fontSizeContent
                    }
                    Text {
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.rightMargin: 12

                        text: "- Translator 2 (French)"
                        textFormat: Text.PlainText
                        color: Theme.colorSubText
                        font.pixelSize: Theme.fontSizeContent
                    }
                    Text {
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.rightMargin: 12

                        text: "- Translator 9 (Klingon)"
                        textFormat: Text.PlainText
                        color: Theme.colorSubText
                        font.pixelSize: Theme.fontSizeContent
                    }
                }

                ////////
            }

            ////////////////
        }
    }

    ////////////////////////////////////////////////////////////////////////////
}
