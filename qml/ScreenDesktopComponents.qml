import QtQuick
import QtQuick.Controls

import ComponentLibrary
import QmlAppTemplate

Loader {
    id: screenDesktopComponents
    anchors.fill: parent

    function loadScreen() {
        // load screen
        screenDesktopComponents.active = true

        // change screen
        appContent.state = "DesktopComponents"
    }

    function backAction() {
        if (screenDesktopComponents.status === Loader.Ready)
            screenDesktopComponents.item.backAction()
    }

    ////////////////////////////////////////////////////////////////////////////

    active: false
    asynchronous: false

    sourceComponent: Item {
        anchors.fill: parent

        ////////

        function backAction() {
            if (isDesktop) screenDesktopComponents.loadScreen()
            else if (isMobile) screenMobileComponents.loadScreen()
        }

        ////////

        // MENUS ///////////////////////////////////////////////////////////////

        Column {
            id: menusArea
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            z: 20

            Rectangle {
                id: rectangleActions
                anchors.left: parent.left
                anchors.right: parent.right

                height: 56
                Behavior on height { NumberAnimation { duration: 133 } }

                clip: true
                visible: (height > 0)
                color: Theme.colorActionbar

                // prevent clicks below this area
                MouseArea { anchors.fill: parent; acceptedButtons: Qt.AllButtons; }

                Row { // left
                    anchors.left: parent.left
                    anchors.leftMargin: 24
                    anchors.verticalCenter: parent.verticalCenter
                    visible: !singleColumn
                    spacing: 16

                    Text {
                        anchors.verticalCenter: parent.verticalCenter

                        text: "Action bar"
                        font.bold: true
                        font.pixelSize: Theme.fontSizeContentBig
                        color: Theme.colorActionbarContent
                        verticalAlignment: Text.AlignVCenter
                    }
                }

                Row { // middle
                    anchors.centerIn: parent
                    visible: !singleColumn
                    spacing: 16

                    ButtonCompactable {
                        text: "oneone"
                        source: "qrc:/IconLibrary/material-symbols/warning-fill.svg"

                        textColor: Theme.colorActionbarContent
                        iconColor: Theme.colorActionbarContent
                        backgroundColor: Theme.colorActionbarHighlight

                        compact: false
                        onClicked: compact = !compact
                    }

                    ButtonCompactable {
                        text: "twotwo"
                        source: "qrc:/IconLibrary/material-symbols/warning-fill.svg"

                        compact: false
                        onClicked: compact = !compact
                    }
                }

                Row { // right
                    anchors.right: itemImageButtonX.left
                    anchors.rightMargin: 24
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 16

                    ButtonSolid {
                        colorHighlight: Theme.colorActionbarHighlight
                        source: "qrc:/IconLibrary/material-symbols/warning-fill.svg"
                    }
                    ButtonSolid {
                        colorHighlight: Theme.colorActionbarHighlight
                        text: "Action 1"
                        source: "qrc:/IconLibrary/material-symbols/warning-fill.svg"
                    }
                    ButtonSolid {
                        colorHighlight: Theme.colorActionbarHighlight
                        text: "Action 2"
                    }
                }

                RoundButtonIcon {
                    id: itemImageButtonX
                    width: 40
                    height: 40
                    anchors.right: parent.right
                    anchors.rightMargin: 24
                    anchors.verticalCenter: parent.verticalCenter

                    source: "qrc:/IconLibrary/material-symbols/close.svg"
                    iconColor: "white"
                    backgroundColor: Theme.colorActionbarHighlight

                    onClicked: {
                        rectangleActions.height = 0
                    }
                }
            }
        }

        // COLOR PALETTE ///////////////////////////////////////////////////////////

        Rectangle {
            id: rectangleColors

            anchors.top: parent.top
            anchors.topMargin: menusArea.height + 24
            anchors.right: parent.right
            anchors.rightMargin: 24

            width: palette.width + 4
            height: palette.height + 4

            z: 5
            color: Theme.colorHighContrast
            visible: isDesktop

            Column {
                id: palette
                anchors.centerIn: parent

                Rectangle {
                    id: header
                    width: 64
                    height: 64
                    color: Theme.colorHeader
                }
                Rectangle {
                    id: fg
                    width: 64
                    height: 64
                    color: Theme.colorForeground
                }
                Rectangle {
                    id: bg
                    width: 64
                    height: 64
                    color: Theme.colorBackground
                }
                Rectangle {
                    id: primary
                    width: 64
                    height: 64
                    color: Theme.colorPrimary

                    Rectangle {
                        id: secondary
                        width: 24
                        height: 24
                        anchors.right: parent.right
                        anchors.bottom: parent.bottom
                        color: Theme.colorSecondary
                    }
                }
                Rectangle {
                    id: success
                    width: 64
                    height: 64
                    color: Theme.colorSuccess

                    Rectangle {
                        id: warning
                        width: 32
                        height: 30
                        anchors.left: parent.left
                        anchors.bottom: parent.bottom
                        color: Theme.colorWarning
                    }
                    Rectangle {
                        id: error
                        width: 32
                        height: 30
                        anchors.right: parent.right
                        anchors.bottom: parent.bottom
                        color: Theme.colorError
                    }
                }
            }
        }

        // CONTENT /////////////////////////////////////////////////////////////

        Column {
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.margins: Theme.componentMarginXL
            spacing: Theme.componentMarginXL
            z: 10

            ButtonFab {
                anchors.right: parent.right
                source: "qrc:/IconLibrary/material-symbols/add.svg"
            }

            ButtonFabExtended {
                anchors.right: parent.right
                text: "Extended FAB"
                source: "qrc:/IconLibrary/material-symbols/add.svg"
            }
        }

        Flickable {
            anchors.top: menusArea.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom

            //enabled: appHeader.componentsEnabled

            LayoutMirroring.enabled: appHeader.componentsMirrored
            //layoutDirection: Qt.RightToLeft

            contentWidth: parent.width
            contentHeight: contentColumn.height

            boundsBehavior: isDesktop ? Flickable.OvershootBounds : Flickable.DragAndOvershootBounds
            ScrollBar.vertical: ScrollBarThemed { visible: isDesktop }

            Column {
                id: contentColumn

                anchors.left: parent.left
                anchors.right: parent.right
                anchors.margins: Theme.componentMargin

                topPadding: Theme.componentMargin
                bottomPadding: Theme.componentMargin
                spacing: Theme.componentMargin

                ////////////////

                Row {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    spacing: Theme.componentMargin

                    Text {
                        anchors.verticalCenter: parent.verticalCenter
                        visible: isDesktop

                        text: "Application theme"
                        font.pixelSize: Theme.fontSizeContent
                        font.bold: true
                        color: Theme.colorText
                    }

                    ComboBoxThemed {
                        id: comboBoxAppTheme
                        width: 256
                        anchors.verticalCenter: parent.verticalCenter

                        model: ListModel {
                            id: cbAppTheme
                            ListElement { text: "MOBILE LIGHT"; }
                            ListElement { text: "MOBILE DARK"; }

                            ListElement { text: "MATERIAL LIGHT"; }
                            ListElement { text: "MATERIAL DARK"; }

                            ListElement { text: "DESKTOP LIGHT"; }
                            ListElement { text: "DESKTOP DARK"; }

                            ListElement { text: "SNOW"; }
                            ListElement { text: "PLANT"; }
                            ListElement { text: "RAIN"; }
                            ListElement { text: "DAY"; }
                            ListElement { text: "NIGHT"; }

                            ListElement { text: "LIGHT AND WARM"; }
                            ListElement { text: "DARK AND SPOOKY"; }
                            ListElement { text: "PLAIN AND BORING"; }
                            ListElement { text: "BLOOD AND TEARS"; }
                            ListElement { text: "MIGHTY KITTENS"; }
                        }

                        Component.onCompleted: {
                            currentIndex = Theme.getThemeIndex(settingsManager.appTheme)
                        }
                        onActivated: {
                            if (currentText === "MOBILE LIGHT") settingsManager.appTheme = "THEME_MOBILE_LIGHT"
                            else if (currentText === "MOBILE DARK") settingsManager.appTheme = "THEME_MOBILE_DARK"

                            else if (currentText === "MATERIAL LIGHT") settingsManager.appTheme = "THEME_MATERIAL_LIGHT"
                            else if (currentText === "MATERIAL DARK") settingsManager.appTheme = "THEME_MATERIAL_DARK"

                            else if (currentText === "DESKTOP LIGHT") settingsManager.appTheme = "THEME_DESKTOP_LIGHT"
                            else if (currentText === "DESKTOP DARK") settingsManager.appTheme = "THEME_DESKTOP_DARK"

                            else if (currentText === "SNOW") settingsManager.appTheme = "THEME_SNOW"
                            else if (currentText === "PLANT") settingsManager.appTheme = "THEME_PLANT"
                            else if (currentText === "RAIN") settingsManager.appTheme = "THEME_RAIN"
                            else if (currentText === "DAY") settingsManager.appTheme = "THEME_DAY"
                            else if (currentText === "NIGHT") settingsManager.appTheme = "THEME_NIGHT"

                            else if (currentText === "LIGHT AND WARM") settingsManager.appTheme = "THEME_LIGHT_AND_WARM"
                            else if (currentText === "DARK AND SPOOKY") settingsManager.appTheme = "THEME_DARK_AND_SPOOKY"
                            else if (currentText === "PLAIN AND BORING") settingsManager.appTheme = "THEME_PLAIN_AND_BORING"
                            else if (currentText === "BLOOD AND TEARS") settingsManager.appTheme = "THEME_BLOOD_AND_TEARS"
                            else if (currentText === "MIGHTY KITTENS") settingsManager.appTheme = "THEME_MIGHTY_KITTENS"
                        }
                    }

                    Text {
                        anchors.verticalCenter: parent.verticalCenter

                        text: "OS theme is"
                        font.pixelSize: Theme.fontSizeContent
                        font.bold: true
                        color: Theme.colorText
                    }

                    SelectorMenu {
                        anchors.verticalCenter: parent.verticalCenter
                        readOnly: true

                        currentSelection: utilsApp.isOsThemeDark()
                        model: ListModel {
                            ListElement { idx: 0; txt: "light"; sz: 0; }
                            ListElement { idx: 1; txt: "dark"; sz: 0; }
                        }
                    }
                }

                ////////////////
/*
                ListSeparator {
                    height: Theme.componentBorderWidth
                    anchors.leftMargin: -24
                    anchors.rightMargin: -24
                }

                Flow {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    spacing: Theme.componentMargin

                    ButtonOutline {
                        source: "qrc:/IconLibrary/material-symbols/accessibility.svg"
                        color: Theme.colorMaterialGreen
                    }

                    ButtonOutline {
                        text: "ButtonOutline"
                        color: Theme.colorMaterialBlue
                    }

                    ButtonOutline {
                        text: "ButtonOutline"
                        source: "qrc:/IconLibrary/material-symbols/accessibility.svg"
                        color: Theme.colorMaterialRed
                    }

                    ButtonOutline {
                        text: "ButtonOutline"
                        source: "qrc:/IconLibrary/material-symbols/accessibility.svg"
                        color: Theme.colorMaterialDeepOrange
                        layoutDirection: Qt.RightToLeft
                    }

                    ButtonOutline {
                        width: 200
                        text: "ButtonOutline"
                        source: "qrc:/IconLibrary/material-symbols/accessibility.svg"
                        color: Theme.colorMaterialOrange
                        layoutAlignment: Qt.AlignLeft
                        layoutDirection: Qt.LeftToRight
                    }
                    ButtonOutline {
                        width: 200
                        text: "ButtonOutline"
                        source: "qrc:/IconLibrary/material-symbols/accessibility.svg"
                        color: Theme.colorMaterialDeepPurple
                        layoutAlignment: Qt.AlignCenter
                        layoutDirection: Qt.RightToLeft
                    }
                    ButtonOutline {
                        width: 200
                        text: "ButtonOutline"
                        source: "qrc:/IconLibrary/material-symbols/accessibility.svg"
                        color: Theme.colorMaterialGrey
                        layoutAlignment: Qt.AlignRight
                        layoutDirection: Qt.RightToLeft
                    }
                }

                Flow {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    spacing: Theme.componentMargin

                    ButtonClear {
                        source: "qrc:/IconLibrary/material-symbols/accessibility.svg"
                        color: Theme.colorMaterialGreen
                    }

                    ButtonClear {
                        text: "ButtonClear"
                        color: Theme.colorMaterialBlue
                    }

                    ButtonClear {
                        text: "ButtonClear"
                        source: "qrc:/IconLibrary/material-symbols/accessibility.svg"
                        color: Theme.colorMaterialRed
                    }

                    ButtonClear {
                        text: "ButtonClear"
                        source: "qrc:/IconLibrary/material-symbols/accessibility.svg"
                        color: Theme.colorMaterialDeepOrange
                        layoutDirection: Qt.RightToLeft
                    }

                    ButtonClear {
                        width: 200
                        text: "ButtonClear"
                        source: "qrc:/IconLibrary/material-symbols/accessibility.svg"
                        color: Theme.colorMaterialOrange
                        layoutAlignment: Qt.AlignLeft
                        layoutDirection: Qt.LeftToRight
                        layoutFillWidth: true
                    }
                    ButtonClear {
                        width: 200
                        text: "ButtonClear"
                        source: "qrc:/IconLibrary/material-symbols/accessibility.svg"
                        color: Theme.colorMaterialDeepPurple
                    }
                    ButtonClear {
                        width: 200
                        text: "ButtonClear"
                        source: "qrc:/IconLibrary/material-symbols/accessibility.svg"
                        color: Theme.colorMaterialGrey
                        layoutAlignment: Qt.AlignRight
                        layoutDirection: Qt.RightToLeft
                        layoutFillWidth: true
                    }
                }

                Flow {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    spacing: Theme.componentMargin

                    ButtonFlat {
                        source: "qrc:/IconLibrary/material-symbols/accessibility.svg"
                        color: Theme.colorMaterialGreen
                    }

                    ButtonFlat {
                        text: "ButtonFlat"
                        color: Theme.colorMaterialBlue
                    }

                    ButtonFlat {
                        text: "ButtonFlat"
                        source: "qrc:/IconLibrary/material-symbols/accessibility.svg"
                        color: Theme.colorMaterialRed
                    }

                    ButtonFlat {
                        text: "ButtonFlat"
                        source: "qrc:/IconLibrary/material-symbols/accessibility.svg"
                        color: Theme.colorMaterialDeepOrange
                        layoutDirection: Qt.RightToLeft
                    }

                    ButtonFlat {
                        width: 200
                        text: "ButtonFlat"
                        source: "qrc:/IconLibrary/material-symbols/accessibility.svg"
                        color: Theme.colorMaterialOrange
                        layoutAlignment: Qt.AlignLeft
                        layoutDirection: Qt.LeftToRight
                    }
                    ButtonFlat {
                        width: 200
                        text: "ButtonFlat"
                        source: "qrc:/IconLibrary/material-symbols/accessibility.svg"
                        color: Theme.colorMaterialDeepPurple
                        layoutAlignment: Qt.AlignCenter
                        layoutDirection: Qt.RightToLeft
                    }
                    ButtonFlat {
                        width: 200
                        text: "ButtonFlat"
                        source: "qrc:/IconLibrary/material-symbols/accessibility.svg"
                        color: Theme.colorMaterialGrey
                        layoutAlignment: Qt.AlignRight
                        layoutDirection: Qt.RightToLeft
                    }
                }

                Flow {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    spacing: Theme.componentMargin

                    ButtonSolid {
                        source: "qrc:/IconLibrary/material-symbols/accessibility.svg"
                    }

                    ButtonSolid {
                        text: "ButtonSolid"
                    }
                    ButtonSolid {
                        text: "ButtonSolid"
                        source: "qrc:/IconLibrary/material-symbols/accessibility.svg"
                    }
                    ButtonSolid {
                        text: "ButtonSolid"
                        source: "qrc:/IconLibrary/material-symbols/accessibility.svg"
                        layoutDirection: Qt.RightToLeft
                    }

                    ButtonSolid {
                        width: 200
                        text: "ButtonSolid"
                        source: "qrc:/IconLibrary/material-symbols/accessibility.svg"
                        layoutAlignment: Qt.AlignLeft
                    }
                    ButtonSolid {
                        width: 200
                        text: "ButtonSolid"
                        source: "qrc:/IconLibrary/material-symbols/accessibility.svg"
                        layoutAlignment: Qt.AlignCenter
                        layoutDirection: Qt.RightToLeft
                    }
                    ButtonSolid {
                        width: 200
                        text: "ButtonSolid"
                        source: "qrc:/IconLibrary/material-symbols/accessibility.svg"
                        layoutAlignment: Qt.AlignRight
                        layoutDirection: Qt.RightToLeft
                    }
                }

                Flow {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    spacing: Theme.componentMargin

                    ButtonWireframe {
                        source: "qrc:/IconLibrary/material-symbols/accessibility.svg"
                    }

                    ButtonWireframe {
                        text: "ButtonWireframe"
                    }
                    ButtonWireframe {
                        text: "ButtonWireframe"
                        source: "qrc:/IconLibrary/material-symbols/accessibility.svg"
                    }
                    ButtonWireframe {
                        text: "ButtonWireframe"
                        source: "qrc:/IconLibrary/material-symbols/accessibility.svg"
                        layoutDirection: Qt.RightToLeft
                    }

                    ButtonWireframe {
                        width: 200
                        text: "ButtonWireframe"
                        source: "qrc:/IconLibrary/material-symbols/accessibility.svg"
                        layoutAlignment: Qt.AlignLeft
                        layoutDirection: Qt.LeftToRight
                    }
                    ButtonWireframe {
                        width: 200
                        text: "ButtonWireframe"
                        source: "qrc:/IconLibrary/material-symbols/accessibility.svg"
                        layoutAlignment: Qt.AlignCenter
                        layoutDirection: Qt.RightToLeft
                    }
                    ButtonWireframe {
                        width: 200
                        text: "ButtonWireframe"
                        source: "qrc:/IconLibrary/material-symbols/accessibility.svg"
                        layoutAlignment: Qt.AlignRight
                        layoutDirection: Qt.RightToLeft
                    }
                }

                Flow {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    spacing: Theme.componentMargin

                    ButtonDesktop {
                        source: "qrc:/IconLibrary/material-symbols/accessibility.svg"
                    }

                    ButtonDesktop {
                        text: "ButtonDesktop"
                    }
                    ButtonDesktop {
                        text: "ButtonDesktop"
                        source: "qrc:/IconLibrary/material-symbols/accessibility.svg"
                    }
                    ButtonDesktop {
                        text: "ButtonDesktop"
                        source: "qrc:/IconLibrary/material-symbols/accessibility.svg"
                        layoutDirection: Qt.RightToLeft
                    }

                    ButtonDesktop {
                        width: 200
                        text: "ButtonDesktop"
                        source: "qrc:/IconLibrary/material-symbols/accessibility.svg"
                        layoutAlignment: Qt.AlignLeft
                        layoutDirection: Qt.LeftToRight
                    }
                    ButtonDesktop {
                        width: 200
                        text: "ButtonDesktop"
                        source: "qrc:/IconLibrary/material-symbols/accessibility.svg"
                        layoutAlignment: Qt.AlignCenter
                        layoutDirection: Qt.RightToLeft
                    }
                    ButtonDesktop {
                        width: 200
                        text: "ButtonDesktop"
                        source: "qrc:/IconLibrary/material-symbols/accessibility.svg"
                        layoutAlignment: Qt.AlignRight
                        layoutDirection: Qt.RightToLeft
                    }
                }
*/
                ////////////////

                ListSeparator {
                    height: Theme.componentBorderWidth
                    anchors.leftMargin: -24
                    anchors.rightMargin: -24
                }

                Flow {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    spacing: Theme.componentMargin

                    ButtonClear {
                        source: "qrc:/IconLibrary/material-symbols/accessibility.svg"
                        color: Theme.colorMaterialGreen
                    }

                    ButtonClear {
                        text: "ButtonClear"
                        color: Theme.colorMaterialBlue
                    }

                    ButtonClear {
                        text: "ButtonClear"
                        source: "qrc:/IconLibrary/material-symbols/accessibility.svg"
                        color: Theme.colorMaterialRed
                    }

                    ButtonClear {
                        text: "ButtonClear"
                        source: "qrc:/IconLibrary/material-symbols/accessibility.svg"
                        color: Theme.colorMaterialDeepOrange
                        layoutDirection: Qt.RightToLeft
                    }

                    ButtonClear {
                        width: 200
                        text: "ButtonClear"
                        source: "qrc:/IconLibrary/material-symbols/accessibility.svg"
                        color: Theme.colorMaterialOrange
                        layoutAlignment: Qt.AlignLeft
                        layoutDirection: Qt.LeftToRight
                        layoutFillWidth: true
                    }
                    ButtonClear {
                        width: 200
                        text: "ButtonClear"
                        source: "qrc:/IconLibrary/material-symbols/accessibility.svg"
                        color: Theme.colorMaterialDeepPurple
                    }
                    ButtonClear {
                        width: 200
                        text: "ButtonClear"
                        source: "qrc:/IconLibrary/material-symbols/accessibility.svg"
                        color: Theme.colorMaterialGrey
                        layoutAlignment: Qt.AlignRight
                        layoutDirection: Qt.RightToLeft
                        layoutFillWidth: true
                    }
                }

                Flow {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    spacing: Theme.componentMargin

                    ButtonClear {
                        source: "qrc:/IconLibrary/material-symbols/accessibility.svg"
                    }

                    ButtonClear {
                        text: "ButtonClear"
                        source: "qrc:/IconLibrary/material-symbols/accessibility.svg"
                    }

                    ButtonOutline {
                        text: "ButtonOutline"
                        source: "qrc:/IconLibrary/material-symbols/accessibility.svg"
                    }

                    ButtonFlat {
                        text: "ButtonFlat"
                        source: "qrc:/IconLibrary/material-symbols/accessibility.svg"
                    }

                    ButtonSolid {
                        text: "ButtonSolid"
                        source: "qrc:/IconLibrary/material-symbols/accessibility.svg"
                    }

                    ButtonWireframe {
                        text: "ButtonWireframe"
                        source: "qrc:/IconLibrary/material-symbols/accessibility.svg"
                    }

                    ButtonDesktop {
                        text: "ButtonDesktop"
                        source: "qrc:/IconLibrary/material-symbols/accessibility.svg"
                    }
                }

                Flow {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    spacing: Theme.componentMarginXL

                    Row {
                        spacing: Theme.componentMargin

                        RoundButtonClear {
                            source: "qrc:/IconLibrary/material-symbols/accessibility.svg"
                            tooltipText: "this one has a tooltip!"
                            width: 48; height: 48;
                        }

                        RoundButtonOutline {
                            source: "qrc:/IconLibrary/material-symbols/accessibility.svg"
                            width: 48; height: 48;
                        }

                        RoundButtonFlat {
                            source: "qrc:/IconLibrary/material-symbols/accessibility.svg"
                            width: 48; height: 48;
                        }

                        RoundButtonSunken {
                            source: "qrc:/IconLibrary/material-symbols/accessibility.svg"
                            width: 48; height: 48;

                            tooltipText: "invisiblllllle!"
                            tooltipPosition: "bottom"
                        }
                    }

                    Row {
                        spacing: Theme.componentMargin

                        RoundButtonSolid {
                            source: "qrc:/IconLibrary/material-symbols/accessibility.svg"
                            width: 48; height: 48;
                        }

                        RoundButtonWireframe {
                            source: "qrc:/IconLibrary/material-symbols/accessibility.svg"
                            width: 48; height: 48;

                            tooltipText: "this one has a tooltip!"
                            tooltipPosition: "bottom"
                        }

                        RoundButtonDesktop {
                            source: "qrc:/IconLibrary/material-symbols/accessibility.svg"
                            width: 48; height: 48;

                            tooltipText: "another tooltip!"
                            tooltipPosition: "right"
                        }
                    }

                    Row {
                        spacing: Theme.componentMargin

                        SquareButtonClear {
                            source: "qrc:/IconLibrary/material-symbols/accessibility.svg"
                            tooltipText: "this one has a tooltip!"
                            width: 48; height: 48;
                        }

                        SquareButtonOutline {
                            source: "qrc:/IconLibrary/material-symbols/accessibility.svg"
                            width: 48; height: 48;
                        }

                        SquareButtonFlat {
                            source: "qrc:/IconLibrary/material-symbols/accessibility.svg"
                            width: 48; height: 48;
                        }

                        SquareButtonSunken {
                            source: "qrc:/IconLibrary/material-symbols/accessibility.svg"
                            width: 48; height: 48;

                            tooltipText: "invisiblllllle!"
                            tooltipPosition: "bottom"
                        }
                    }

                    Row {
                        spacing: Theme.componentMargin

                        SquareButtonSolid {
                            source: "qrc:/IconLibrary/material-symbols/accessibility.svg"
                            width: 48; height: 48;
                        }

                        SquareButtonWireframe {
                            source: "qrc:/IconLibrary/material-symbols/accessibility.svg"
                            width: 48; height: 48;

                            tooltipText: "this one has a tooltip!"
                            tooltipPosition: "bottom"
                        }

                        SquareButtonDesktop {
                            source: "qrc:/IconLibrary/material-symbols/accessibility.svg"
                            width: 48; height: 48;

                            tooltipText: "another tooltip!"
                            tooltipPosition: "right"
                        }
                    }
                }

                ////////////////

                ListSeparator {
                    height: Theme.componentBorderWidth
                    anchors.leftMargin: -24
                    anchors.rightMargin: -24
                }

                Flow {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    spacing: Theme.componentMargin

                    ButtonSunken {
                        source: "qrc:/IconLibrary/material-symbols/accessibility.svg"
                    }

                    ButtonSunken {
                        text: "ButtonSunken"
                    }
                    ButtonSunken {
                        text: "ButtonSunken"
                        source: "qrc:/IconLibrary/material-symbols/accessibility.svg"
                    }
                    ButtonSunken {
                        text: "ButtonSunken"
                        source: "qrc:/IconLibrary/material-symbols/accessibility.svg"
                        layoutDirection: Qt.RightToLeft
                    }

                    ButtonSunken {
                        text: "ButtonSunken"
                        source: "qrc:/IconLibrary/material-symbols/accessibility.svg"
                        colorHighlight: "white"
                        layoutDirection: Qt.LeftToRight
                    }
                    ButtonSunken {
                        text: "ButtonSunken"
                        source: "qrc:/IconLibrary/material-symbols/accessibility.svg"
                        colorHighlight: "white"
                        layoutDirection: Qt.RightToLeft
                    }
                }

                Flow {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    spacing: Theme.componentMargin

                    ButtonChip {
                        text: "ButtonChip"
                        highlighted: true
                    }

                    ButtonChip {
                        text: "ButtonChip"
                    }

                    ButtonChip {
                        text: "ButtonChip"
                        leftIcon: "qrc:/IconLibrary/material-symbols/supervised_user_circle.svg"
                    }

                    ButtonChip {
                        text: "ButtonChip"
                        leftIcon: "qrc:/IconLibrary/material-symbols/supervised_user_circle.svg"
                        rightIcon: "qrc:/IconLibrary/material-symbols/close.svg"
                    }
                }

                ////////////////

                ListSeparator {
                    height: Theme.componentBorderWidth
                    anchors.leftMargin: -24
                    anchors.rightMargin: -24
                }

                Row {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    spacing: Theme.componentMargin

                    Row {
                        height: 48
                        spacing: 16

                        RoundButtonIcon {
                            width: 48
                            height: 48
                            source: "qrc:/IconLibrary/material-symbols/accessibility.svg"
                            backgroundVisible: true
                            highlightMode: "color"
                        }
                        RoundButtonIcon {
                            width: 48
                            height: 48
                            source: "qrc:/IconLibrary/material-symbols/accessibility.svg"
                            backgroundVisible: false
                            highlightMode: "circle"
                        }
                        RoundButtonIcon {
                            width: 48
                            height: 48
                            source: "qrc:/IconLibrary/material-symbols/accessibility.svg"
                            highlightMode: "color"
                            highlightColor: Theme.colorError

                            tooltipText: "this one has a tooltip!"
                        }
                    }

                    Item {
                        width: 16
                        height: 16
                    }

                    Row {
                        height: 48
                        spacing: 16

                        RoundButtonText {
                            width: 48
                            height: 48
                            text: "+"
                            backgroundVisible: true
                            highlightMode: "color"
                        }
                        RoundButtonText {
                            width: 48
                            height: 48
                            text: "-"
                            backgroundVisible: false
                            highlightMode: "circle"
                        }
                        RoundButtonText {
                            width: 48
                            height: 48
                            text: "a"
                            highlightMode: "color"
                            highlightColor: Theme.colorError
                            borderVisible: true

                            tooltipText: "this one has a tooltip!"
                        }
                    }

                    Item {
                        width: 16
                        height: 16
                    }

                    Row {
                        height: 48
                        spacing: 16

                        RoundButtonIcon {
                            source: "qrc:/IconLibrary/material-symbols/accessibility.svg"
                            highlightMode: "color"
                        }
                        RoundButtonIcon {
                            source: "qrc:/IconLibrary/material-symbols/accessibility.svg"
                            backgroundVisible: true
                            highlightMode: "circle"
                        }
                        RoundButtonIcon {
                            source: "qrc:/IconLibrary/material-symbols/accessibility.svg"
                            highlightMode: "color"
                            highlightColor: Theme.colorError

                            tooltipText: "another tooltip!"
                        }
                    }

                    Item {
                        width: 16
                        height: 16
                    }

                    Row {
                        height: 48
                        spacing: 16

                        RoundButtonText {
                            text: "+"
                            backgroundVisible: true
                            highlightMode: "color"
                        }
                        RoundButtonText {
                            text: "-"
                            backgroundVisible: false
                            highlightMode: "circle"
                        }
                        RoundButtonText {
                            text: "a"
                            highlightMode: "color"
                            highlightColor: Theme.colorError
                            borderVisible: true

                            tooltipText: "this one has a tooltip!"
                        }
                    }
                }

                ////

                Row {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    spacing: Theme.componentMargin

                    SelectorMenu {
                        height: 40
                        anchors.verticalCenter: parent.verticalCenter

                        currentSelection: 1
                        model: ListModel {
                            id: lmSelectorMenuImg1
                            ListElement { idx: 1; src: "qrc:/IconLibrary/material-symbols/accessibility.svg"; sz: 20; }
                            ListElement { idx: 2; src: "qrc:/IconLibrary/material-symbols/accessibility.svg"; sz: 26; }
                            ListElement { idx: 3; src: "qrc:/IconLibrary/material-symbols/accessibility.svg"; sz: 32; }
                        }

                        onMenuSelected: (index) => {
                            //console.log("SelectorMenu clicked #" + index)
                            currentSelection = index
                        }
                    }

                    SelectorMenu {
                        height: 32
                        anchors.verticalCenter: parent.verticalCenter

                        currentSelection: 1
                        model: ListModel {
                            ListElement { idx: 1; txt: "4/3"; src: ""; sz: 0; }
                            ListElement { idx: 2; txt: "16/9"; src: ""; sz: 0; }
                            ListElement { idx: 3; txt: "21/9"; src: ""; sz: 0; }
                        }

                        onMenuSelected: (index) => {
                            //console.log("SelectorMenu clicked #" + index)
                            currentSelection = index
                        }
                    }

                    SelectorMenuSunken {
                        height: 32
                        anchors.verticalCenter: parent.verticalCenter

                        currentSelection: 1
                        model: ListModel {
                            ListElement { idx: 1; txt: "4/3"; src: ""; sz: 0; }
                            ListElement { idx: 2; txt: "16/9"; src: ""; sz: 0; }
                            ListElement { idx: 3; txt: "21/9"; src: ""; sz: 0; }
                        }

                        onMenuSelected: (index) => {
                            //console.log("SelectorMenu clicked #" + index)
                            currentSelection = index
                        }
                    }

                    SelectorMenuColorful {
                        height: 40
                        anchors.verticalCenter: parent.verticalCenter

                        currentSelection: 1
                        model: ListModel {
                            ListElement { idx: 1; src: "qrc:/IconLibrary/material-symbols/accessibility.svg"; sz: 20; }
                            ListElement { idx: 2; src: "qrc:/IconLibrary/material-symbols/accessibility.svg"; sz: 26; }
                            ListElement { idx: 3; src: "qrc:/IconLibrary/material-symbols/accessibility.svg"; sz: 32; }
                        }

                        onMenuSelected: (index) => {
                            //console.log("SelectorMenu clicked #" + index)
                            currentSelection = index
                        }
                    }

                    SelectorMenuColorful {
                        height: 32
                        anchors.verticalCenter: parent.verticalCenter

                        model: ListModel {
                            ListElement { idx: 1; txt: "4/3"; src: ""; sz: 0; }
                            ListElement { idx: 2; txt: "16/9"; src: ""; sz: 0; }
                            ListElement { idx: 3; txt: "21/9"; src: ""; sz: 0; }
                        }

                        onMenuSelected: (index) => {
                            //console.log("SelectorMenu clicked #" + index)
                            currentSelection = index
                        }
                    }
                }

                ////
/*
                Row {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    spacing: Theme.componentMargin

                    Rectangle { // new effect
                        id: rectangle1

                        width: 64
                        height: 64
                        color: "red"

                        layer.enabled: true
                        layer.effect: MultiEffect {
                            maskEnabled: true
                            maskInverted: false
                            maskThresholdMin: 0.5
                            maskSpreadAtMin: 1.0
                            maskSpreadAtMax: 0.0
                            maskSource: ShaderEffectSource {
                                sourceItem: Rectangle {
                                    height: rectangle1.height
                                    width: rectangle1.width
                                    radius: 64
                                }
                            }

                            blurEnabled: false
                            blur: 0.5
                        }
                    }

                    Rectangle { // old effect
                        id: rectangle2

                        width: 64
                        height: 64
                        color: "red"

                        layer.enabled: true
                        layer.effect: OpacityMask {
                            maskSource: Rectangle {
                                height: rectangle2.height
                                width: rectangle2.width
                                radius: 64
                            }
                        }
                    }
                }
*/
                ////

                Row {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    spacing: Theme.componentMargin

                    TagButtonFlat {
                        anchors.verticalCenter: parent.verticalCenter
                        text: "TAG"
                        //color: Theme.colorForeground
                    }

                    TagButtonFlat {
                        anchors.verticalCenter: parent.verticalCenter
                        text: "TAG"
                        //color: Theme.colorForeground
                    }

                    TagButtonClear {
                        anchors.verticalCenter: parent.verticalCenter
                        text: "TAG"
                        //color: Theme.colorForeground
                    }

                    TagButtonClear {
                        anchors.verticalCenter: parent.verticalCenter
                        text: "TAG"
                        //color: Theme.colorForeground
                    }

                    Row {
                        anchors.verticalCenter: parent.verticalCenter
                        spacing: 8

                        ItemBadge {
                            text: "4"
                            color: Theme.colorMaterialDeepOrange
                        }
                        Text {
                            text: "Notifications"
                            color: Theme.colorText
                            font.pixelSize: Theme.componentFontSize
                        }
                    }
                }

                Row {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    spacing: Theme.componentMargin

                    TagClear {
                        text: "tag"
                        color: Theme.colorMaterialGreen
                    }

                    TagClear {
                        text: "tag"
                        color: Theme.colorMaterialBlue
                    }

                    TagClear {
                        text: "tag"
                        color: Theme.colorMaterialRed
                    }

                    TagClear {
                        text: "tag"
                        color: Theme.colorMaterialDeepPurple
                    }

                    TagClear {
                        text: "tag"
                        color: Theme.colorMaterialGrey
                    }
                }

                Row {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    spacing: Theme.componentMargin

                    TagFlat {
                        text: "tag"
                        color: Theme.colorMaterialGreen
                    }

                    TagFlat {
                        text: "tag"
                        color: Theme.colorMaterialBlue
                    }

                    TagFlat {
                        text: "tag"
                        color: Theme.colorMaterialRed
                    }

                    TagFlat {
                        text: "tag"
                        color: Theme.colorMaterialDeepPurple
                    }

                    TagFlat {
                        text: "tag"
                        color: Theme.colorMaterialGrey
                    }
                }

                Row {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    spacing: Theme.componentMargin

                    TagDesktop {
                        text: "tag"
                    }

                    TagDesktop {
                        text: "TAG"
                    }

                    TagDesktop {
                        text: "rgehetqthshrts"
                    }

                    TagDesktop {
                        width: 64
                        text: "rgehetqthshrts"
                    }
                }

                ItemLicenseBadge {
                    width: 128
                    legend: "license"
                    text: "LGPL 3"
                    onClicked: Qt.openUrlExternally("https://www.gnu.org/licenses/lgpl-3.0.html")
                }

                ////////////////////////

                ListSeparator {
                    height: Theme.componentBorderWidth
                    anchors.leftMargin: -24
                    anchors.rightMargin: -24
                }

                Row {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    spacing: Theme.componentMargin

                    SliderArrow {
                        anchors.verticalCenter: parent.verticalCenter
                        value: 0.7
                        stepSize: 0.1
                    }

                    MiddleSliderArrow {
                        anchors.verticalCenter: parent.verticalCenter
                        value: 0.5
                        stepSize: 0.1
                    }

                    RangeSliderArrow {
                        anchors.verticalCenter: parent.verticalCenter
                        second.value: 0.7
                        first.value: 0.3
                        stepSize: 0.1
                    }
                }

                Row {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    spacing: Theme.componentMargin

                    SliderValueSolid {
                        anchors.verticalCenter: parent.verticalCenter
                        value: 0.6
                        stepSize: 0.1
                    }

                    RangeSliderValueSolid {
                        anchors.verticalCenter: parent.verticalCenter
                        second.value: 0.8
                        first.value: 0.2
                        stepSize: 0.1
                    }
                }

                ////////////////////////

                ListSeparator {
                    height: Theme.componentBorderWidth
                    anchors.leftMargin: -24
                    anchors.rightMargin: -24
                }

                Row {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    spacing: Theme.componentMargin

                    Dial {
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    DialThemed {
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    Tumbler {
                        anchors.verticalCenter: parent.verticalCenter
                        width: 32
                        height: 96

                        model: 8
                    }

                    TumblerThemed {
                        anchors.verticalCenter: parent.verticalCenter
                        width: 32
                        height: 96

                        model: 8
                    }

                    ProgressArc {
                        anchors.verticalCenter: parent.verticalCenter
                        width: 112
                        value: 0.33
                    }

                    ProgressCircle {
                        anchors.verticalCenter: parent.verticalCenter
                        width: 112
                        value: 0.33
                    }

                    ButtonImage {
                        width: 128
                        height: 128
                        hoverMode: "glow"
                        clickMode: "pull"
                        source: "qrc:/assets/gfx/logos/logo.svg"
                        sourceSize: 96
                    }
                }

                ////////////////////////

                ListSeparator {
                    height: Theme.componentBorderWidth
                    anchors.leftMargin: -24
                    anchors.rightMargin: -24
                }

                Row {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    spacing: Theme.componentMargin

                    AndroidButton {
                        anchors.verticalCenter: parent.verticalCenter
                        text: "AndroidButton"
                    }

                    AndroidButtonIcon {
                        anchors.verticalCenter: parent.verticalCenter
                        text: "AndroidButtonIcon"
                        source: "qrc:/IconLibrary/material-symbols/accessibility.svg"
                    }

                    AndroidTextField {
                        anchors.verticalCenter: parent.verticalCenter
                        title: "AndroidTextField"
                        text: "some text"
                        placeholderText: "placeholder text"
                    }
                }

                ////////////////////////

                ListSeparator {
                    height: Theme.componentBorderWidth
                    anchors.leftMargin: -24
                    anchors.rightMargin: -24
                }

                Row {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    spacing: Theme.componentMargin

                    ProgressBarThemed {
                        anchors.verticalCenter: parent.verticalCenter
                        value: 0.5
                    }

                    SliderThemed {
                        anchors.verticalCenter: parent.verticalCenter
                        value: 0.5
                    }

                    MiddleSliderThemed {
                        anchors.verticalCenter: parent.verticalCenter
                        value: 0.5
                    }

                    RangeSliderThemed {
                        anchors.verticalCenter: parent.verticalCenter
                        second.value: 0.75
                        first.value: 0.25
                    }

                    CheckBoxThemed {
                        anchors.verticalCenter: parent.verticalCenter
                        text: "CheckBox"
                    }

                    RadioButtonThemed {
                        anchors.verticalCenter: parent.verticalCenter
                        text: "RadioButton"
                    }

                    SwitchThemed {
                        anchors.verticalCenter: parent.verticalCenter
                        text: "Switch"
                        checked: true
                    }
                }

                Row {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    spacing: Theme.componentMargin

                    TextFieldThemed {
                        anchors.verticalCenter: parent.verticalCenter
                        width: 256
                        placeholderText: "TextFieldThemed"
                    }

                    ComboBoxThemed {
                        anchors.verticalCenter: parent.verticalCenter
                        width: 256

                        model: ListModel {
                            ListElement { text: "ComboBoxThemed"; }
                            ListElement { text: "combobox item1"; }
                            ListElement { text: "combobox item2"; }
                        }
                    }

                    ButtonThemed {
                        anchors.verticalCenter: parent.verticalCenter
                        text: "ButtonThemed"
                    }

                    ButtonIconThemed {
                        anchors.verticalCenter: parent.verticalCenter
                        text: "ButtonIconThemed"
                        source: "qrc:/IconLibrary/material-symbols/accessibility.svg"
                    }

                    RoundButtonThemed {
                        anchors.verticalCenter: parent.verticalCenter
                        text: "+"
                    }

                    RoundButtonIconThemed {
                        anchors.verticalCenter: parent.verticalCenter
                        source: "qrc:/IconLibrary/material-symbols/accessibility.svg"
                    }

                    SpinBoxThemedMobile {
                        anchors.verticalCenter: parent.verticalCenter
                        editable: true
                        //legend: "°"
                    }

                    SpinBoxThemedDesktop {
                        anchors.verticalCenter: parent.verticalCenter
                        editable: true
                        legend: "°"
                    }
                }

                ////////////////////////

                ListSeparator {
                    height: Theme.componentBorderWidth
                    anchors.leftMargin: -24
                    anchors.rightMargin: -24
                }

                Row {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    spacing: Theme.componentMargin

                    ProgressBar {
                        anchors.verticalCenter: parent.verticalCenter
                        value: 0.5
                    }

                    Slider {
                        anchors.verticalCenter: parent.verticalCenter
                        value: 0.5
                    }

                    RangeSlider {
                        anchors.verticalCenter: parent.verticalCenter
                        first.value: 0.25
                        second.value: 0.75
                    }

                    CheckBox {
                        anchors.verticalCenter: parent.verticalCenter
                        text: "CheckBox"
                    }

                    RadioButton {
                        anchors.verticalCenter: parent.verticalCenter
                        text: "RadioButton"
                    }

                    Switch {
                        anchors.verticalCenter: parent.verticalCenter
                        text: "Switch"
                        checked: true
                    }
                }

                Row {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    spacing: Theme.componentMargin

                    TextField {
                        anchors.verticalCenter: parent.verticalCenter
                        width: 256
                        text: "Text Field"
                    }

                    ComboBox {
                        anchors.verticalCenter: parent.verticalCenter
                        width: 256

                        model: ListModel {
                            ListElement { text: "ComboBox"; }
                            ListElement { text: "combobox item1"; }
                            ListElement { text: "combobox item2"; }
                        }
                    }

                    Button {
                        anchors.verticalCenter: parent.verticalCenter
                        text: "Button"
                    }

                    RoundButton {
                        anchors.verticalCenter: parent.verticalCenter
                        text: "+"
                    }

                    SpinBox {
                        anchors.verticalCenter: parent.verticalCenter
                        editable: true
                    }
                }

                ////////////////
            }
        }
    }

    ////////////////////////////////////////////////////////////////////////////
}
