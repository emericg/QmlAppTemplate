import QtQuick 2.15
import QtQuick.Controls 2.15

import ThemeEngine 1.0
import "qrc:/js/UtilsString.js" as UtilsString

Item {
    id: screenComponent
    width: 1280
    height: 720

    // MENUS ///////////////////////////////////////////////////////////////////

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

            // left

            Text {
                anchors.left: parent.left
                anchors.leftMargin: 24
                anchors.verticalCenter: parent.verticalCenter

                text: "Action bar"
                font.bold: true
                font.pixelSize: Theme.fontSizeContentBig
                color: Theme.colorActionbarContent
                verticalAlignment: Text.AlignVCenter
            }

            // right

            Row {
                anchors.right: itemImageButtonX.left
                anchors.rightMargin: 24
                anchors.verticalCenter: parent.verticalCenter
                spacing: 16

                ButtonWireframeIcon {
                    fullColor: true
                    primaryColor: Theme.colorActionbarHighlight
                    source: "qrc:/assets/icons_material/baseline-warning-24px.svg"

                    onClicked: {
                        //
                    }
                    onPressAndHold: {
                        //
                    }
                }
                ButtonWireframeIcon {
                    fullColor: true
                    primaryColor: Theme.colorActionbarHighlight
                    text: "Action 1"
                    source: "qrc:/assets/icons_material/baseline-warning-24px.svg"
                }
                ButtonWireframeIcon {
                    fullColor: true
                    primaryColor: Theme.colorActionbarHighlight
                    text: "Action 2"
                }
            }

            ItemImageButton {
                id: itemImageButtonX
                width: 40
                height: 40
                anchors.right: parent.right
                anchors.rightMargin: 24
                anchors.verticalCenter: parent.verticalCenter

                source: "qrc:/assets/icons_material/baseline-close-24px.svg"
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

        width: 64 + 4
        height: 6*64 + 4

        z: 10
        color: "white"
        visible: isDesktop

        Column {
            id: palette
            width: 64
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
                id: warning
                width: 64
                height: 64
                color: Theme.colorWarning
            }
            Rectangle {
                id: error
                width: 64
                height: 64
                color: Theme.colorError
            }
        }
    }

    // CONTENT /////////////////////////////////////////////////////////////////

    Flickable {
        anchors.top: menusArea.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        contentWidth: parent.width
        contentHeight: columnComponents.height

        boundsBehavior: isDesktop ? Flickable.OvershootBounds : Flickable.DragAndOvershootBounds
        ScrollBar.vertical: ScrollBar { visible: isDesktop; }

        Column {
            id: columnComponents

            anchors.left: parent.left
            anchors.leftMargin: 24
            anchors.right: parent.right
            anchors.rightMargin: 24

            topPadding: 24
            bottomPadding: 24
            spacing: 24

            ////

            Row {
                anchors.left: parent.left
                anchors.right: parent.right
                spacing: 24

                Text {
                    anchors.verticalCenter: parent.verticalCenter

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
                        ListElement { text: "PLANT"; }
                        ListElement { text: "SNOW"; }
                        ListElement { text: "DAY"; }
                        ListElement { text: "NIGHT"; }

                        ListElement { text: "LIGHT (desktop)"; }
                        ListElement { text: "DARK (desktop)"; }
                        ListElement { text: "LIGHT (mobile)"; }
                        ListElement { text: "DARK (mobile)"; }

                        ListElement { text: "LIGHT AND WARM"; }
                        ListElement { text: "DARK AND SPOOKY"; }
                        ListElement { text: "PLAIN AND BORING"; }
                        ListElement { text: "BLOOD AND TEARS"; }
                        ListElement { text: "MIGHTY KITTENS"; }
                    }

                    Component.onCompleted: {
                        currentIndex = Theme.getThemeIndex(settingsManager.appTheme)
                        if (currentIndex === -1) { currentIndex = 0 }
                    }

                    property bool cbinit: false

                    onCurrentTextChanged: {
                        if (cbinit) {
                            if (currentText === "PLANT") settingsManager.appTheme = "THEME_PLANT"
                            else if (currentText === "SNOW") settingsManager.appTheme = "THEME_SNOW"
                            else if (currentText === "DAY") settingsManager.appTheme = "THEME_DAY"
                            else if (currentText === "NIGHT") settingsManager.appTheme = "THEME_NIGHT"

                            else if (currentText === "LIGHT AND WARM") settingsManager.appTheme = "THEME_LIGHT_AND_WARM"
                            else if (currentText === "DARK AND SPOOKY") settingsManager.appTheme = "THEME_DARK_AND_SPOOKY"
                            else if (currentText === "PLAIN AND BORING") settingsManager.appTheme = "THEME_PLAIN_AND_BORING"
                            else if (currentText === "BLOOD AND TEARS") settingsManager.appTheme = "THEME_BLOOD_AND_TEARS"
                            else if (currentText === "MIGHTY KITTENS") settingsManager.appTheme = "THEME_MIGHTY_KITTENS"

                            else if (currentText === "LIGHT (desktop)") settingsManager.appTheme = "THEME_LIGHT_DESKTOP"
                            else if (currentText === "DARK (desktop)") settingsManager.appTheme = "THEME_DARK_DESKTOP"
                            else if (currentText === "LIGHT (mobile)") settingsManager.appTheme = "THEME_LIGHT_MOBILE"
                            else if (currentText === "DARK (mobile)") settingsManager.appTheme = "THEME_DARK_MOBILE"
                        } else {
                            cbinit = true
                        }
                    }
                }

                RadioButtonThemed {
                    id: radioButtonLight
                    anchors.verticalCenter: parent.verticalCenter

                    text: "light"
                    checked: true
                }
                RadioButtonThemed {
                    id: radioButtonDark
                    anchors.verticalCenter: parent.verticalCenter

                    text: "dark"
                    checked: false
                }
            }

            ////

            Row {
                anchors.left: parent.left
                anchors.right: parent.right
                spacing: 24

                ButtonWireframe {
                    anchors.verticalCenter: parent.verticalCenter
                    fullColor: true
                    text: "ButtonWireframe"
                }

                ButtonWireframeIcon {
                    anchors.verticalCenter: parent.verticalCenter
                    fullColor: true
                    text: "ButtonWireframeIcon"
                    source: "qrc:/assets/icons_material/baseline-accessibility-24px.svg"
                }

                ButtonWireframe {
                    anchors.verticalCenter: parent.verticalCenter
                    text: "ButtonWireframe"
                }

                ButtonWireframeIcon {
                    anchors.verticalCenter: parent.verticalCenter
                    text: "ButtonWireframeIcon"
                    source: "qrc:/assets/icons_material/baseline-accessibility-24px.svg"
                }

                ButtonText {
                    anchors.verticalCenter: parent.verticalCenter
                    text: "ButtonText"
                }
            }

            ////

            Row {
                anchors.left: parent.left
                anchors.right: parent.right
                spacing: 24

                Row {
                    width: 400
                    height: 48
                    spacing: 16

                    ItemImageButton {
                        width: 48
                        height: 48
                        source: "qrc:/assets/icons_material/baseline-accessibility-24px.svg"
                        background: true
                        highlightMode: "color"
                    }
                    ItemImageButton {
                        width: 48
                        height: 48
                        source: "qrc:/assets/icons_material/baseline-accessibility-24px.svg"
                        background: false
                        highlightMode: "circle"
                    }
                    ItemImageButtonTooltip {
                        width: 48
                        height: 48
                        source: "qrc:/assets/icons_material/baseline-accessibility-24px.svg"
                        highlightMode: "color"
                        highlightColor: Theme.colorError

                        tooltipText: "this one has a tooltip!"
                    }
                }

                Row {
                    width: 400
                    height: 48
                    spacing: 16

                    ItemImageButton {
                        source: "qrc:/assets/icons_material/baseline-accessibility-24px.svg"
                        highlightMode: "color"
                    }
                    ItemImageButton {
                        source: "qrc:/assets/icons_material/baseline-accessibility-24px.svg"
                        background: true
                        highlightMode: "circle"
                    }
                    ItemImageButtonTooltip {
                        source: "qrc:/assets/icons_material/baseline-accessibility-24px.svg"
                        highlightMode: "color"
                        highlightColor: Theme.colorError

                        tooltipText: "another tooltip!"
                    }
                }
            }

            ////

            Row {
                anchors.left: parent.left
                anchors.right: parent.right
                spacing: 24

                SelectorMenuThemed {
                    anchors.verticalCenter: parent.verticalCenter
                    width: rowLilMenuImg.width
                    height: 40

                    Row {
                        id: rowLilMenuImg
                        height: parent.height

                        SelectorMenuThemedItem {
                            id: lilmenu11
                            height: parent.height

                            source: "qrc:/assets/icons_material/duotone-date_range-24px.svg"
                            sourceSize: 18
                            selected: true
                            onClicked: {
                                lilmenu11.selected = true
                                lilmenu22.selected = false
                                lilmenu33.selected = false
                            }
                        }
                        SelectorMenuThemedItem {
                            id: lilmenu22
                            height: parent.height

                            source: "qrc:/assets/icons_material/duotone-date_range-24px.svg"
                            sourceSize: 22
                            onClicked: {
                                lilmenu11.selected = false
                                lilmenu22.selected = true
                                lilmenu33.selected = false
                            }
                        }
                        SelectorMenuThemedItem {
                            id: lilmenu33
                            height: parent.height

                            source: "qrc:/assets/icons_material/duotone-date_range-24px.svg"
                            sourceSize: 26
                            onClicked: {
                                lilmenu11.selected = false
                                lilmenu22.selected = false
                                lilmenu33.selected = true
                            }
                        }
                    }
                }

                SelectorMenuThemed {
                    anchors.verticalCenter: parent.verticalCenter
                    width: rowLilMenuTxt.width

                    Row {
                        id: rowLilMenuTxt
                        height: parent.height

                        SelectorMenuThemedItem {
                            id: lilmenu1

                            text: "4/3"
                            selected: true
                            onClicked: {
                                lilmenu1.selected = true
                                lilmenu2.selected = false
                                lilmenu3.selected = false
                            }
                        }
                        SelectorMenuThemedItem {
                            id: lilmenu2

                            text: "16/9"
                            onClicked: {
                                lilmenu1.selected = false
                                lilmenu2.selected = true
                                lilmenu3.selected = false
                            }
                        }
                        SelectorMenuThemedItem {
                            id: lilmenu3

                            text: "21/9"
                            onClicked: {
                                lilmenu1.selected = false
                                lilmenu2.selected = false
                                lilmenu3.selected = true
                            }
                        }
                    }
                }

                SelectorMenu {
                    anchors.verticalCenter: parent.verticalCenter
                    width: rowLilMenu2Txt.width

                    Row {
                        id: rowLilMenu2Txt
                        height: parent.height

                        SelectorMenuItem {
                            id: lilmenu111

                            text: "4/3"
                            selected: true
                            onClicked: {
                                lilmenu111.selected = true
                                lilmenu222.selected = false
                                lilmenu333.selected = false
                            }
                        }
                        SelectorMenuItem {
                            id: lilmenu222

                            text: "16/9"
                            onClicked: {
                                lilmenu111.selected = false
                                lilmenu222.selected = true
                                lilmenu333.selected = false
                            }
                        }
                        SelectorMenuItem {
                            id: lilmenu333

                            text: "21/9"
                            onClicked: {
                                lilmenu111.selected = false
                                lilmenu222.selected = false
                                lilmenu333.selected = true
                            }
                        }
                    }
                }
            }

            ////

            Row {
                anchors.left: parent.left
                anchors.right: parent.right
                spacing: 24

                ItemBadge {
                    anchors.verticalCenter: parent.verticalCenter
                    width: 128
                    legend: "license"
                    text: "LGPL 3"
                    onClicked: Qt.openUrlExternally("https://www.gnu.org/licenses/lgpl-3.0.html")
                }

                ItemTag {
                    anchors.verticalCenter: parent.verticalCenter
                    text: "TAG1"
                    //color: Theme.colorForeground
                }

                ItemTag {
                    anchors.verticalCenter: parent.verticalCenter
                    text: "TAG2"
                    //color: Theme.colorForeground
                }
            }

            ////

            Row {
                anchors.left: parent.left
                anchors.right: parent.right
                spacing: 24

                SliderArrow {
                    anchors.verticalCenter: parent.verticalCenter
                    value: 0.75
                    stepSize: 0.1
                }

                MiddleSliderArrow {
                    anchors.verticalCenter: parent.verticalCenter
                    value: 0.5
                    stepSize: 0.1
                }

                RangeSliderArrow {
                    anchors.verticalCenter: parent.verticalCenter
                    second.value: 0.75
                    first.value: 0.25
                    stepSize: 0.1
                }
            }

            Row {
                anchors.left: parent.left
                anchors.right: parent.right
                spacing: 24

                SliderValueSolid {
                    anchors.verticalCenter: parent.verticalCenter
                    value: 0.75
                    stepSize: 0.1
                }

                RangeSliderValueSolid {
                    anchors.verticalCenter: parent.verticalCenter
                    second.value: 0.75
                    first.value: 0.25
                    //stepSize: 0.1
                }
            }

            ////////////////////////

            Rectangle { // separator
                height: 2
                color: Theme.colorSeparator
                anchors.left: parent.left
                anchors.leftMargin: -24
                anchors.right: parent.right
                anchors.rightMargin: -24
            }

            Row {
                anchors.left: parent.left
                anchors.right: parent.right
                spacing: 24

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
            }

            ////////////////////////

            Rectangle { // separator
                height: 2
                color: Theme.colorSeparator
                anchors.left: parent.left
                anchors.leftMargin: -24
                anchors.right: parent.right
                anchors.rightMargin: -24
            }

            Row {
                anchors.left: parent.left
                anchors.right: parent.right
                spacing: 24

                ButtonAndroid {
                    anchors.verticalCenter: parent.verticalCenter

                    text: "ButtonAndroid"
                }

                ButtonAndroidIcon {
                    anchors.verticalCenter: parent.verticalCenter

                    text: "ButtonAndroidIcon"
                    source: "qrc:/assets/icons_material/baseline-accessibility-24px.svg"
                }

                TextFieldAndroid {
                    anchors.verticalCenter: parent.verticalCenter

                    width: 256
                    title: "TextFieldAndroid"
                    text: "some text"
                }
            }

            ////////////////////////

            Rectangle { // separator
                height: 2
                color: Theme.colorSeparator
                anchors.left: parent.left
                anchors.leftMargin: -24
                anchors.right: parent.right
                anchors.rightMargin: -24
            }

            Row {
                anchors.left: parent.left
                anchors.right: parent.right
                spacing: 24

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

                SwitchThemedMobile {
                    anchors.verticalCenter: parent.verticalCenter
                    text: "Switch"
                    checked: true
                }

                SwitchThemedDesktop {
                    anchors.verticalCenter: parent.verticalCenter
                    text: "Switch"
                    checked: true
                }
            }

            Row {
                anchors.left: parent.left
                anchors.right: parent.right
                spacing: 24

                TextFieldThemed {
                    anchors.verticalCenter: parent.verticalCenter
                    width: 256
                }

                ComboBoxThemed {
                    anchors.verticalCenter: parent.verticalCenter
                    width: 256

                    model: ListModel {
                        ListElement { text: "combobox item1"; }
                        ListElement { text: "combobox item2"; }
                    }
                }

                ButtonThemed {
                    anchors.verticalCenter: parent.verticalCenter
                    text: "Button"
                }

                ButtonIconThemed {
                    anchors.verticalCenter: parent.verticalCenter

                    text: "ButtonIcon"
                    source: "qrc:/assets/icons_material/baseline-accessibility-24px.svg"
                }

                RoundButtonThemed {
                    anchors.verticalCenter: parent.verticalCenter
                    text: "+"
                }

                RoundButtonIconThemed {
                    anchors.verticalCenter: parent.verticalCenter
                    source: "qrc:/assets/icons_material/baseline-accessibility-24px.svg"
                }

                SpinBoxThemed {
                    anchors.verticalCenter: parent.verticalCenter
                    //legend: "°"
                }
            }

            ////////////////////////

            Rectangle { // separator
                height: 2
                color: Theme.colorSeparator
                anchors.left: parent.left
                anchors.leftMargin: -24
                anchors.right: parent.right
                anchors.rightMargin: -24
            }

            Row {
                anchors.left: parent.left
                anchors.right: parent.right
                spacing: 24

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
                spacing: 24

                TextField {
                    anchors.verticalCenter: parent.verticalCenter
                    width: 256
                    text: "Text Field"
                }

                ComboBox {
                    anchors.verticalCenter: parent.verticalCenter
                    width: 256

                    model: ListModel {
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
                }
            }
        }
    }
}

