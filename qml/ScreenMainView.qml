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
        ScrollBar.vertical: ScrollBarThemed { visible: Theme.isDesktop }

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

            Flow { // galleries
                id: galleries
                anchors.left: parent.left
                anchors.leftMargin: Theme.componentMarginXL
                anchors.right: parent.right
                anchors.rightMargin: Theme.componentMarginXL
                spacing: Theme.componentMargin

                readonly property int cardCount: Theme.isDesktop ? 3 : 2
                readonly property int columns: Math.max(1, Math.min(cardCount, Math.floor((width + spacing) / (280 + spacing))))

                readonly property real cardWidth: (width - (columns - 1) * spacing) / columns
                readonly property real cardHeight: 440

                MediaCardTop {
                    width: galleries.cardWidth
                    height: galleries.cardHeight

                    mediaHeight: galleries.cardHeight * 0.54
                    gradientStops: GradientPresets.ocean
                    pattern: "circles-concentric"
                    patternTileSize: 64
                    iconSource: "qrc:/IconLibrary/material-symbols/hardware/computer.svg"

                    tagText: qsTr("Gallery")
                    tagColor: Theme.colorMaterialBlue
                    title: qsTr("Desktop components")
                    description: qsTr("One screen for many components.")

                    primaryText: qsTr("Explore")
                    onPrimaryClicked: screenDesktopComponents.loadScreen()
                    onClicked: screenDesktopComponents.loadScreen()
                }

                MediaCardTop {
                    width: galleries.cardWidth
                    height: galleries.cardHeight

                    mediaHeight: galleries.cardHeight * 0.54
                    gradientStops: GradientPresets.grape
                    pattern: "grid-diagonal"
                    patternTileSize: 64
                    iconSource: "qrc:/IconLibrary/material-symbols/hardware/smartphone-fill.svg"

                    tagText: qsTr("Gallery")
                    tagColor: Theme.colorMaterialPurple
                    title: qsTr("Mobile components")
                    description: qsTr("Controls and layouts tuned for mobile navigation.")

                    primaryText: qsTr("Explore")
                    onPrimaryClicked: screenMobileComponents.loadScreen()
                    onClicked: screenMobileComponents.loadScreen()
                }

                MediaCardTop {
                    width: galleries.cardWidth
                    height: galleries.cardHeight

                    mediaHeight: galleries.cardHeight * 0.54
                    gradientStops: GradientPresets.ember
                    pattern: "maze"
                    patternTileSize: 512
                    iconSource: "qrc:/IconLibrary/material-symbols/build-fill.svg"

                    tagText: qsTr("Sandbox")
                    tagColor: Theme.colorMaterialOrange
                    title: qsTr("Playgrounds")
                    description: qsTr("A scratch area to experiment.")

                    primaryText: qsTr("Open")
                    onPrimaryClicked: screenPlayground.loadScreen()
                    onClicked: screenPlayground.loadScreen()
                }
            }

            ////////////////

            Flow { // tools
                id: tools
                anchors.left: parent.left
                anchors.leftMargin: Theme.componentMarginXL
                anchors.right: parent.right
                anchors.rightMargin: Theme.componentMarginXL
                spacing: Theme.componentMarginS

                readonly property int columns: Math.max(1, Math.floor((width + spacing) / (320 + spacing)))
                readonly property real cardWidth: (width - (columns - 1) * spacing) / columns

                SimpleCardList {
                    width: tools.cardWidth
                    accentColor: Theme.colorMaterialTeal
                    title: qsTr("Host info")
                    subtitle: qsTr("Details about the current device.")
                    icon: "qrc:/IconLibrary/material-icons/duotone/info.svg"
                    onClicked: screenHostInfos.loadScreen()
                }
                SimpleCardList {
                    width: tools.cardWidth
                    accentColor: Theme.colorMaterialIndigo
                    title: qsTr("Fonts info")
                    subtitle: qsTr("Preview the bundled font families.")
                    icon: "qrc:/IconLibrary/material-icons/duotone/info.svg"
                    onClicked: screenFontInfos.loadScreen()
                }
                SimpleCardList {
                    width: tools.cardWidth
                    accentColor: Theme.colorMaterialGreen
                    title: qsTr("Settings")
                    subtitle: qsTr("Theme, language and preferences.")
                    icon: "qrc:/IconLibrary/material-icons/duotone/tune.svg"
                    onClicked: screenSettings.loadScreen()
                }
                SimpleCardList {
                    width: tools.cardWidth
                    accentColor: Theme.colorMaterialBrown
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
