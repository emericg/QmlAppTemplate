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

                CardWelcome {
                    visible: Theme.isDesktop // the mobile app has no desktop components screen
                    title: qsTr("Desktop components")
                    hint: qsTr("One screen for many components.")
                    icon: "qrc:/IconLibrary/material-symbols/hardware/computer.svg"
                    onClicked: screenDesktopComponents.loadScreen()
                }

                CardWelcome {
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

                CardSimple {
                    width: Math.min(400, parent.width)

                    accentColor: parent.accents[0]
                    title: qsTr("Playgrounds")
                    subtitle: qsTr("A scratch area to experiment.")
                    icon: "qrc:/IconLibrary/material-symbols/build-fill.svg"
                    onClicked: screenPlayground.loadScreen()
                }
                CardSimple {
                    width: Math.min(400, parent.width)

                    accentColor: parent.accents[1]
                    title: qsTr("Host info")
                    subtitle: qsTr("Details about the current device.")
                    icon: "qrc:/IconLibrary/material-icons/duotone/info.svg"
                    onClicked: screenHostInfos.loadScreen()
                }
                CardSimple {
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
                CardSimple {
                    width: Math.min(400, parent.width)

                    accentColor: parent.accents[3]
                    title: qsTr("Settings")
                    subtitle: qsTr("Theme, language and preferences.")
                    icon: "qrc:/IconLibrary/material-icons/duotone/tune.svg"
                    onClicked: screenSettings.loadScreen()
                }
                CardSimple {
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
}
