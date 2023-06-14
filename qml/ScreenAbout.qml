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
            //
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
                    anchors.leftMargin: 16
                    anchors.verticalCenter: parent.verticalCenter

                    z: 2
                    height: 96
                    spacing: 16

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
                    anchors.rightMargin: 16
                    anchors.verticalCenter: parent.verticalCenter

                    visible: wideWideMode
                    spacing: 16

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

            Column {
                anchors.left: parent.left
                anchors.leftMargin: screenPaddingLeft + 16
                anchors.right: parent.right
                anchors.rightMargin: screenPaddingRight + 16

                topPadding: 16
                bottomPadding: 16
                spacing: 16

                Row {
                    id: buttonsRow
                    height: Theme.componentHeight

                    anchors.left: parent.left
                    anchors.leftMargin: 0
                    anchors.right: parent.right
                    anchors.rightMargin: 0

                    visible: !wideWideMode
                    spacing: 16

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

                ////////////////

                Item {
                    id: desc
                    height: Math.max(UtilsNumber.alignTo(description.contentHeight, 8), Theme.componentHeight)
                    anchors.left: parent.left
                    anchors.right: parent.right

                    IconSvg {
                        id: descImg
                        width: 32
                        height: 32
                        anchors.top: parent.top
                        anchors.topMargin: (Theme.componentHeight - width) / 2
                        //anchors.verticalCenter: desc.verticalCenter

                        source: "qrc:/assets/icons_material/outline-info-24px.svg"
                        color: Theme.colorIcon
                    }

                    Text {
                        id: description
                        anchors.left: parent.left
                        anchors.leftMargin: 48
                        anchors.right: parent.right
                        anchors.verticalCenter: desc.verticalCenter

                        text: qsTr("A Qt6 / QML application template, with a full set of visual controls, as well as build and deploy scripts and CI setups.")
                        textFormat: Text.PlainText
                        wrapMode: Text.WordWrap
                        color: Theme.colorText
                        font.pixelSize: Theme.fontSizeContent
                    }
                }

                ////////

                Item {
                    id: authors
                    height: Theme.componentHeight
                    anchors.left: parent.left
                    anchors.right: parent.right

                    IconSvg {
                        id: authorImg
                        width: 32
                        height: 32
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter

                        source: "qrc:/assets/icons_material/baseline-supervised_user_circle-24px.svg"
                        color: Theme.colorIcon
                    }

                    Text {
                        id: authorTxt
                        anchors.left: parent.left
                        anchors.leftMargin: 48
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter

                        text: qsTr("Application by <a href=\"https://emeric.io\">Emeric Grange</a>")
                        textFormat: Text.StyledText
                        onLinkActivated: (link) => { Qt.openUrlExternally(link) }
                        font.pixelSize: Theme.fontSizeContent
                        color: Theme.colorText
                        linkColor: Theme.colorIcon

                        MouseArea {
                            anchors.fill: parent
                            acceptedButtons: Qt.NoButton
                            cursorShape: authorTxt.hoveredLink ? Qt.PointingHandCursor : Qt.ArrowCursor
                        }
                    }

                    IconSvg {
                        width: 20
                        height: 20
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        visible: singleColumn

                        source: "qrc:/assets/icons_material/duotone-launch-24px.svg"
                        color: Theme.colorIcon
                    }
                }

                ////////

                Item {
                    id: rate
                    height: Theme.componentHeight
                    anchors.left: parent.left
                    anchors.right: parent.right

                    visible: (Qt.platform.os === "android" || Qt.platform.os === "ios")

                    IconSvg {
                        id: rateImg
                        width: 32
                        height: 32
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter

                        source: "qrc:/assets/icons_material/baseline-stars-24px.svg"
                        color: Theme.colorIcon
                    }

                    Text {
                        id: rateTxt
                        anchors.left: parent.left
                        anchors.leftMargin: 48
                        anchors.verticalCenter: parent.verticalCenter

                        text: qsTr("Rate the application")
                        textFormat: Text.PlainText
                        font.pixelSize: Theme.fontSizeContent
                        color: Theme.colorText
                    }

                    IconSvg {
                        width: 20
                        height: 20
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        visible: singleColumn

                        source: "qrc:/assets/icons_material/duotone-launch-24px.svg"
                        color: Theme.colorIcon
                    }

                    MouseArea {
                        anchors.top: parent.top
                        anchors.left: parent.left
                        anchors.right: singleColumn ? parent.right : rateTxt.right
                        anchors.rightMargin: singleColumn ? 0 : -24
                        anchors.bottom: parent.bottom
                        onClicked: Qt.openUrlExternally("https://github.com/emericg/QmlAppTemplate")
                    }
                }

                ////////

                Item {
                    id: tuto
                    height: Theme.componentHeight
                    anchors.left: parent.left
                    anchors.right: parent.right

                    IconSvg {
                        width: 28
                        height: 28
                        anchors.left: parent.left
                        anchors.leftMargin: 2
                        anchors.verticalCenter: parent.verticalCenter

                        source: "qrc:/assets/icons_material/baseline-import_contacts-24px.svg"
                        color: Theme.colorIcon
                    }

                    Text {
                        id: tutoTxt
                        anchors.left: parent.left
                        anchors.leftMargin: 48
                        anchors.verticalCenter: parent.verticalCenter

                        text: qsTr("Open the tutorial")
                        textFormat: Text.PlainText
                        font.pixelSize: Theme.fontSizeContent
                        color: Theme.colorText
                    }

                    IconSvg {
                        width: 24
                        height: 24
                        anchors.right: parent.right
                        anchors.rightMargin: -2
                        anchors.verticalCenter: parent.verticalCenter
                        visible: singleColumn

                        source: "qrc:/assets/icons_material/baseline-chevron_right-24px.svg"
                        color: Theme.colorIcon
                    }

                    MouseArea {
                        anchors.top: parent.top
                        anchors.left: parent.left
                        anchors.right: singleColumn ? parent.right : tutoTxt.right
                        anchors.rightMargin: singleColumn ? 0 : -24
                        anchors.bottom: parent.bottom
                    }
                }

                ////////

                Rectangle { // separator
                    anchors.left: parent.left
                    anchors.leftMargin: -(screenPaddingLeft + 16)
                    anchors.right: parent.right
                    anchors.rightMargin: -(screenPaddingRight + 16)
                    height: 1
                    color: Theme.colorSeparator
                    visible: (Qt.platform.os === "android")
                }

                Item {
                    id: permissions
                    height: 32
                    anchors.left: parent.left
                    anchors.right: parent.right

                    visible: (Qt.platform.os === "android")

                    IconSvg {
                        id: permissionsImg
                        width: 24
                        height: 24
                        anchors.left: parent.left
                        anchors.leftMargin: 4
                        anchors.verticalCenter: parent.verticalCenter

                        source: "qrc:/assets/icons_material/baseline-flaky-24px.svg"
                        color: Theme.colorIcon
                    }

                    Text {
                        id: permissionsTxt
                        anchors.left: parent.left
                        anchors.leftMargin: 48
                        anchors.verticalCenter: parent.verticalCenter

                        text: qsTr("About app permissions")
                        textFormat: Text.PlainText
                        font.pixelSize: Theme.fontSizeContent
                        color: Theme.colorText
                    }

                    IconSvg {
                        width: 24
                        height: 24
                        anchors.right: parent.right
                        anchors.rightMargin: -2
                        anchors.verticalCenter: parent.verticalCenter

                        source: "qrc:/assets/icons_material/baseline-chevron_right-24px.svg"
                        color: Theme.colorIcon
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: screenAboutPermissions.loadScreen()
                    }
                }

                ////////

                Rectangle { // separator
                    anchors.left: parent.left
                    anchors.leftMargin: -(screenPaddingLeft + 16)
                    anchors.right: parent.right
                    anchors.rightMargin: -(screenPaddingRight + 16)
                    height: 1
                    color: Theme.colorSeparator
                }

                Item {
                    id: dependencies
                    height: 24 + dependenciesLabel.height + dependenciesColumn.height
                    anchors.left: parent.left
                    anchors.leftMargin: 0
                    anchors.right: parent.right
                    anchors.rightMargin: 0

                    IconSvg {
                        id: dependenciesImg
                        width: 24
                        height: 24
                        anchors.left: parent.left
                        anchors.leftMargin: 4
                        anchors.verticalCenter: dependenciesLabel.verticalCenter

                        source: "qrc:/assets/icons_material/baseline-settings-20px.svg"
                        color: Theme.colorIcon
                    }

                    Text {
                        id: dependenciesLabel
                        anchors.top: parent.top
                        anchors.topMargin: 8
                        anchors.left: parent.left
                        anchors.leftMargin: 48
                        anchors.right: parent.right
                        anchors.rightMargin: 0

                        text: qsTr("This application is made possible thanks to a couple of third party open source projects:")
                        textFormat: Text.PlainText
                        color: Theme.colorText
                        font.pixelSize: Theme.fontSizeContent
                        wrapMode: Text.WordWrap
                    }

                    Column {
                        id: dependenciesColumn
                        anchors.top: dependenciesLabel.bottom
                        anchors.topMargin: 8
                        anchors.left: parent.left
                        anchors.leftMargin: 48
                        anchors.right: parent.right
                        anchors.rightMargin: 0
                        spacing: 4

                        Text {
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.rightMargin: 12

                            text: "- Qt6 (LGPL 3)"
                            textFormat: Text.PlainText
                            color: Theme.colorText
                            font.pixelSize: Theme.fontSizeContent
                            wrapMode: Text.WordWrap
                        }
                        Text {
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.rightMargin: 12

                            text: "- SingleApplication (MIT)"
                            textFormat: Text.PlainText
                            color: Theme.colorText
                            font.pixelSize: Theme.fontSizeContent
                            wrapMode: Text.WordWrap
                        }
                        Text {
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.rightMargin: 12

                            text: "- Google Material Icons (MIT)"
                            textFormat: Text.PlainText
                            color: Theme.colorText
                            font.pixelSize: Theme.fontSizeContent
                            wrapMode: Text.WordWrap
                        }
                        Text {
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.rightMargin: 12

                            text: "- MobileUI & MobileSharing (MIT)"
                            textFormat: Text.PlainText
                            color: Theme.colorText
                            font.pixelSize: Theme.fontSizeContent
                            wrapMode: Text.WordWrap
                        }
                    }
                }

                ////////

                Rectangle { // separator
                    anchors.left: parent.left
                    anchors.leftMargin: -(screenPaddingLeft + 16)
                    anchors.right: parent.right
                    anchors.rightMargin: -(screenPaddingRight + 16)
                    height: 1
                    color: Theme.colorSeparator
                }

                Item {
                    id: translators
                    height: 24 + translatorsLabel.height + translatorsColumn.height
                    anchors.left: parent.left
                    anchors.leftMargin: 0
                    anchors.right: parent.right
                    anchors.rightMargin: 0

                    IconSvg {
                        id: translatorsImg
                        width: 24
                        height: 24
                        anchors.left: parent.left
                        anchors.leftMargin: 4
                        anchors.verticalCenter: translatorsLabel.verticalCenter

                        source: "qrc:/assets/icons_material/duotone-translate-24px.svg"
                        color: Theme.colorIcon
                    }

                    Text {
                        id: translatorsLabel
                        anchors.top: parent.top
                        anchors.topMargin: 8
                        anchors.left: parent.left
                        anchors.leftMargin: 48
                        anchors.right: parent.right
                        anchors.rightMargin: 0

                        text: qsTr("Special thanks to our translators:")
                        textFormat: Text.PlainText
                        color: Theme.colorText
                        font.pixelSize: Theme.fontSizeContent
                        wrapMode: Text.WordWrap
                    }

                    Column {
                        id: translatorsColumn
                        anchors.top: translatorsLabel.bottom
                        anchors.topMargin: 8
                        anchors.left: parent.left
                        anchors.leftMargin: 48
                        anchors.right: parent.right
                        anchors.rightMargin: 0
                        spacing: 4

                        Text {
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.rightMargin: 12

                            text: "- Translator 1 (Español)"
                            textFormat: Text.PlainText
                            color: Theme.colorText
                            font.pixelSize: Theme.fontSizeContent
                        }
                        Text {
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.rightMargin: 12

                            text: "- Translator 2 (French)"
                            textFormat: Text.PlainText
                            color: Theme.colorText
                            font.pixelSize: Theme.fontSizeContent
                        }
                        Text {
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.rightMargin: 12

                            text: "- Translator 9 (Klingon)"
                            textFormat: Text.PlainText
                            color: Theme.colorText
                            font.pixelSize: Theme.fontSizeContent
                        }
                    }
                }

                ////////
            }

            ////////////////
        }
    }

    ////////////////////////////////////////////////////////////////////////////
}
