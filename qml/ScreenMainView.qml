import QtQuick
import QtQuick.Controls

import ComponentLibrary
import AppUtils

Loader {
    id: screenMainView
    anchors.fill: parent

    function loadScreen() {
        // load screen
        screenMainView.active = true

        // change screen
        appContent.state = "MainView"
    }

    function backAction() {
        if (screenMainView.status === Loader.Ready)
            return screenMainView.item.backAction()

        return false
    }

    ////////////////////////////////////////////////////////////////////////////

    active: false
    asynchronous: false

    sourceComponent: Flickable {
        anchors.fill: parent

        contentWidth: -1
        contentHeight: contentColumn.height

        boundsBehavior: Theme.isDesktop ? Flickable.OvershootBounds : Flickable.DragAndOvershootBounds
        ScrollBar.vertical: ScrollBar { visible: false }

        ////////

        function backAction() {
            return false
        }

        ////////

        Column {
            id: contentColumn

            anchors.left: parent.left
            anchors.leftMargin: Theme.singleColumn ? 0 : parent.width*0.125
            anchors.right: parent.right
            anchors.rightMargin: Theme.singleColumn ? 0 : parent.width*0.125

            topPadding: Theme.componentMarginXL
            bottomPadding: Theme.componentMarginXL
            spacing: Theme.componentMarginXL

            ////////////////

            Column { // header
                anchors.left: parent.left
                anchors.leftMargin: Theme.componentMarginXL
                anchors.right: parent.right
                anchors.rightMargin: Theme.componentMarginXL
                spacing: Theme.componentMarginS

                Image {
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: 96
                    height: 96

                    fillMode: Image.PreserveAspectFit
                    source: "qrc:/assets/logos/logo.svg"
                    sourceSize { width: 96; height: 96 }
                }
                Text {
                    anchors.horizontalCenter: parent.horizontalCenter

                    text: UtilsApp.appName()
                    textFormat: Text.PlainText
                    color: Theme.colorText
                    font.pixelSize: Theme.fontSizeTitle
                    font.bold: true
                }
                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width

                    text: qsTr("Welcome! Pick a component gallery to explore, or jump to the tools below.")
                    textFormat: Text.PlainText
                    color: Theme.colorSubText
                    font.pixelSize: Theme.fontSizeContent
                    horizontalAlignment: Text.AlignHCenter
                    wrapMode: Text.WordWrap
                }
            }

            ////////////////

            Flow { // primary
                anchors.horizontalCenter: parent.horizontalCenter
                //width: Math.min(implicitWidth, parent.width)

                spacing: Theme.componentMargin

                WelcomeCard {
                    title: qsTr("Desktop components")
                    hint: qsTr("One screen for many components.")
                    icon: "qrc:/IconLibrary/material-symbols/hardware/computer.svg"
                    onClicked: screenDesktopComponents.loadScreen()
                }

                WelcomeCard {
                    title: qsTr("Mobile components")
                    hint: qsTr("Controls and layouts tuned for mobile navigation.")
                    icon: "qrc:/IconLibrary/material-symbols/hardware/smartphone-fill.svg"
                    onClicked: screenMobileComponents.loadScreen()
                }
            }

            ////////////////

            Flow { // secondary
                anchors.left: parent.left
                anchors.leftMargin: Theme.componentMarginXL
                anchors.right: parent.right
                anchors.rightMargin: Theme.componentMarginXL
                spacing: Theme.componentMarginS

                // Shuffled once at creation, so each card gets a distinct accent color.
                readonly property var accents: {
                    let p = [Theme.colorMaterialRed, Theme.colorMaterialPink,
                             Theme.colorMaterialPurple, Theme.colorMaterialIndigo,
                             Theme.colorMaterialBlue, Theme.colorMaterialTeal,
                             Theme.colorMaterialGreen, Theme.colorMaterialOrange,
                             Theme.colorMaterialDeepOrange, Theme.colorMaterialBrown]
                    for (let i = p.length - 1; i > 0; i--) {
                        let j = Math.floor(Math.random() * (i + 1))
                        let t = p[i]; p[i] = p[j]; p[j] = t
                    }
                    return p
                }

                SimpleCard {
                    width: Math.min(400, parent.width)

                    accentColor: parent.accents[0]
                    title: qsTr("Playground")
                    subtitle: qsTr("A scratch area to experiment.")
                    icon: "qrc:/IconLibrary/material-symbols/build-fill.svg"
                    onClicked: screenPlayground.loadScreen()
                }
                SimpleCard {
                    width: Math.min(400, parent.width)

                    accentColor: parent.accents[1]
                    title: qsTr("Host info")
                    subtitle: qsTr("Details about the current device.")
                    icon: "qrc:/IconLibrary/material-icons/duotone/info.svg"
                    onClicked: screenHostInfos.loadScreen()
                }
                SimpleCard {
                    width: Math.min(400, parent.width)

                    accentColor: parent.accents[2]
                    title: qsTr("Fonts info")
                    subtitle: qsTr("Preview the bundled font families.")
                    icon: "qrc:/IconLibrary/material-icons/duotone/info.svg"
                    onClicked: screenFontInfos.loadScreen()
                }
            }

            Flow { // tertiary
                anchors.left: parent.left
                anchors.leftMargin: Theme.componentMarginXL
                anchors.right: parent.right
                anchors.rightMargin: Theme.componentMarginXL
                spacing: Theme.componentMarginS

                readonly property var accents: {
                    let p = [Theme.colorMaterialRed, Theme.colorMaterialPink,
                             Theme.colorMaterialPurple, Theme.colorMaterialIndigo,
                             Theme.colorMaterialBlue, Theme.colorMaterialTeal,
                             Theme.colorMaterialGreen, Theme.colorMaterialOrange,
                             Theme.colorMaterialDeepOrange, Theme.colorMaterialBrown]
                    for (let i = p.length - 1; i > 0; i--) {
                        let j = Math.floor(Math.random() * (i + 1))
                        let t = p[i]; p[i] = p[j]; p[j] = t
                    }
                    return p
                }
                SimpleCard {
                    width: Math.min(400, parent.width)

                    accentColor: parent.accents[3]
                    title: qsTr("Settings")
                    subtitle: qsTr("Theme, language and preferences.")
                    icon: "qrc:/IconLibrary/material-icons/duotone/tune.svg"
                    onClicked: screenSettings.loadScreen()
                }
                SimpleCard {
                    width: Math.min(400, parent.width)

                    accentColor: parent.accents[4]
                    title: qsTr("About")
                    subtitle: qsTr("Version, credits and links.")
                    icon: "qrc:/IconLibrary/material-icons/duotone/info.svg"
                    onClicked: screenAbout.loadScreen()
                }
            }

            ////////////////
        }
    }

    ////////////////////////////////////////////////////////////////////////////

    component WelcomeCard: Rectangle {
        id: card

        required property string title
        required property url icon
        property string hint: ""

        signal clicked()

        width: 320
        height: 400
        radius: Theme.componentRadius

        color: cardArea.containsMouse ? Theme.colorForeground : Theme.colorBackground
        border.width: Theme.componentBorderWidth
        border.color: cardArea.containsMouse ? Theme.colorPrimary : Theme.colorSeparator
        Behavior on border.color { ColorAnimation { duration: 133 } }

        Rectangle { // top part: gradient banner with the centered icon
            id: cardBanner
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: card.border.width
            height: Math.round(card.height * 2 / 3) - card.border.width

            topLeftRadius: card.radius - card.border.width
            topRightRadius: card.radius - card.border.width

            gradient: Gradient {
                GradientStop { position: 0.0; color: Theme.colorPrimary }
                GradientStop { position: 1.0; color: Qt.darker(Theme.colorPrimary, 1.35) }
            }

            IconSvg {
                anchors.centerIn: parent
                width: 64
                height: 64
                color: "white"
                source: card.icon
            }
        }

        Item { // bottom part: title and optional hint
            anchors.top: cardBanner.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom

            Column {
                anchors.centerIn: parent
                width: card.width - Theme.componentMargin * 2
                spacing: 2

                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: card.title
                    textFormat: Text.PlainText
                    color: Theme.colorText
                    font.pixelSize: Theme.fontSizeContentVeryBig
                    font.bold: true
                }
                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    visible: (card.hint.length > 0)
                    width: parent.width

                    text: card.hint
                    textFormat: Text.PlainText
                    color: Theme.colorSubText
                    font.pixelSize: Theme.fontSizeContent
                    horizontalAlignment: Text.AlignHCenter
                    wrapMode: Text.WordWrap
                }
            }
        }

        MouseArea {
            id: cardArea
            anchors.fill: parent
            hoverEnabled: true
            onClicked: card.clicked()
        }
    }

    ////////////////

    component SimpleCard: Rectangle {
        id: scard

        required property string title
        required property url icon
        property string subtitle: ""
        property color accentColor: Theme.colorPrimary

        signal clicked()

        height: 64
        radius: Theme.componentRadius

        color: rowArea.containsMouse ? Qt.darker(scard.accentColor, 1.03) : scard.accentColor
        Behavior on color { ColorAnimation { duration: 133 } }

        Rectangle { // round icon badge
            id: iconBadge
            anchors.left: parent.left
            anchors.leftMargin: Theme.componentMargin
            anchors.verticalCenter: parent.verticalCenter

            width: 40
            height: 40
            radius: width / 2
            color: Qt.rgba(1, 1, 1, 0.25)

            IconSvg {
                anchors.centerIn: parent
                width: 24
                height: 24
                color: "white"
                source: scard.icon
            }
        }

        Column {
            anchors.left: iconBadge.right
            anchors.leftMargin: Theme.componentMargin
            anchors.right: chevron.left
            anchors.rightMargin: Theme.componentMargin
            anchors.verticalCenter: parent.verticalCenter
            spacing: 0

            Text {
                width: parent.width
                text: scard.title
                textFormat: Text.PlainText
                color: "white"
                font.pixelSize: Theme.fontSizeContentBig
                font.bold: true
                elide: Text.ElideRight
            }
            Text {
                width: parent.width
                visible: (scard.subtitle.length > 0)
                text: scard.subtitle
                textFormat: Text.PlainText
                color: Qt.rgba(1, 1, 1, 0.75)
                font.pixelSize: Theme.fontSizeContentSmall
                elide: Text.ElideRight
            }
        }

        IconSvg {
            id: chevron
            anchors.right: parent.right
            anchors.rightMargin: Theme.componentMargin
            anchors.verticalCenter: parent.verticalCenter

            width: 24
            height: 24
            color: "white"
            source: "qrc:/IconLibrary/material-symbols/chevron_right.svg"
        }

        MouseArea {
            id: rowArea
            anchors.fill: parent
            hoverEnabled: true
            onClicked: scard.clicked()
        }
    }

    ////////////////////////////////////////////////////////////////////////////
}
