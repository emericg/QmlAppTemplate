import QtQuick
import QtQuick.Controls

import ThemeEngine

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

        function backAction() {
            screenMainView.loadScreen()
        }

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
                        source: "qrc:/assets/icons_material/baseline-warning-24px.svg"

                        textColor: Theme.colorActionbarContent
                        iconColor: Theme.colorActionbarContent
                        backgroundColor: Theme.colorActionbarHighlight

                        compact: false
                        onClicked: compact = !compact
                    }

                    ButtonCompactable {
                        text: "twotwo"
                        source: "qrc:/assets/icons_material/baseline-warning-24px.svg"

                        compact: false
                        onClicked: compact = !compact
                    }
                }

                Row { // right
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
                        text: "Enable components"
                    }
                }

                RoundButtonIcon {
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

        // CONTENT /////////////////////////////////////////////////////////////////

        Flickable {
            anchors.top: menusArea.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom

            enabled: appHeader.componentsEnabled
            contentWidth: parent.width
            contentHeight: contentColumn.height

            boundsBehavior: isDesktop ? Flickable.OvershootBounds : Flickable.DragAndOvershootBounds
            ScrollBar.vertical: ScrollBar { visible: isDesktop; }

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
                            if (currentText === "SNOW") settingsManager.appTheme = "THEME_SNOW"
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

                Rectangle { // separator
                    height: 2
                    color: Theme.colorSeparator
                    anchors.left: parent.left
                    anchors.leftMargin: -24
                    anchors.right: parent.right
                    anchors.rightMargin: -24
                }

                ////

                Flow {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    spacing: Theme.componentMargin

                    ButtonWireframe {
                        fullColor: true
                        text: "ButtonWireframe"
                    }

                    ButtonWireframeIcon {
                        fullColor: true
                        text: "ButtonWireframeIcon"
                        source: "qrc:/assets/icons_material/baseline-accessibility-24px.svg"
                    }

                    ButtonWireframe {
                        text: "ButtonWireframe"
                    }

                    ButtonWireframeIcon {
                        width: 128
                        text: "ButtonWireframeIcon"
                        source: "qrc:/assets/icons_material/baseline-accessibility-24px.svg"
                    }

                    ButtonText {
                        text: "ButtonText"
                    }
                }

                ////

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
                            source: "qrc:/assets/icons_material/baseline-accessibility-24px.svg"
                            backgroundVisible: true
                            highlightMode: "color"
                        }
                        RoundButtonIcon {
                            width: 48
                            height: 48
                            source: "qrc:/assets/icons_material/baseline-accessibility-24px.svg"
                            backgroundVisible: false
                            highlightMode: "circle"
                        }
                        RoundButtonIcon {
                            width: 48
                            height: 48
                            source: "qrc:/assets/icons_material/baseline-accessibility-24px.svg"
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
                            source: "qrc:/assets/icons_material/baseline-accessibility-24px.svg"
                            highlightMode: "color"
                        }
                        RoundButtonIcon {
                            source: "qrc:/assets/icons_material/baseline-accessibility-24px.svg"
                            backgroundVisible: true
                            highlightMode: "circle"
                        }
                        RoundButtonIcon {
                            source: "qrc:/assets/icons_material/baseline-accessibility-24px.svg"
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

                    SelectorMenuThemed {
                        height: 40
                        anchors.verticalCenter: parent.verticalCenter

                        currentSelection: 1
                        model: ListModel {
                            id: lmSelectorMenuImg1
                            ListElement { idx: 1; src: "qrc:/assets/icons_material/baseline-accessibility-24px.svg"; sz: 20; }
                            ListElement { idx: 2; src: "qrc:/assets/icons_material/baseline-accessibility-24px.svg"; sz: 26; }
                            ListElement { idx: 3; src: "qrc:/assets/icons_material/baseline-accessibility-24px.svg"; sz: 32; }
                        }

                        onMenuSelected: (index) => {
                            //console.log("SelectorMenu clicked #" + index)
                            currentSelection = index
                        }
                    }

                    SelectorMenuThemed {
                        height: 32
                        anchors.verticalCenter: parent.verticalCenter

                        currentSelection: 1
                        model: ListModel {
                            id: lmSelectorMenuTxt1
                            ListElement { idx: 1; txt: "4/3"; src: ""; sz: 0; }
                            ListElement { idx: 2; txt: "16/9"; src: ""; sz: 0; }
                            ListElement { idx: 3; txt: "21/9"; src: ""; sz: 0; }
                        }

                        onMenuSelected: (index) => {
                            //console.log("SelectorMenu clicked #" + index)
                            currentSelection = index
                        }
                    }

                    SelectorMenu {
                        height: 40
                        anchors.verticalCenter: parent.verticalCenter

                        currentSelection: 1
                        model: ListModel {
                            id: lmSelectorMenuImg2
                            ListElement { idx: 1; src: "qrc:/assets/icons_material/baseline-accessibility-24px.svg"; sz: 20; }
                            ListElement { idx: 2; src: "qrc:/assets/icons_material/baseline-accessibility-24px.svg"; sz: 26; }
                            ListElement { idx: 3; src: "qrc:/assets/icons_material/baseline-accessibility-24px.svg"; sz: 32; }
                        }

                        onMenuSelected: (index) => {
                            //console.log("SelectorMenu clicked #" + index)
                            currentSelection = index
                        }
                    }

                    SelectorMenu {
                        height: 32
                        anchors.verticalCenter: parent.verticalCenter

                        model: ListModel {
                            id: lmSelectorMenuTxt2
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

                Row {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    spacing: Theme.componentMargin

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

                    ItemTagButton {
                        anchors.verticalCenter: parent.verticalCenter
                        text: "TAG3"
                        //color: Theme.colorForeground
                    }

                    ItemTagButton {
                        anchors.verticalCenter: parent.verticalCenter
                        text: "TAG4"
                        //color: Theme.colorForeground
                    }
                }

                ////

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
                        source: "qrc:/assets/logos/logo.svg"
                        sourceSize: 96
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
                    spacing: Theme.componentMargin

                    AndroidButton {
                        anchors.verticalCenter: parent.verticalCenter
                        text: "AndroidButton"
                    }

                    AndroidButtonIcon {
                        anchors.verticalCenter: parent.verticalCenter
                        text: "AndroidButtonIcon"
                        source: "qrc:/assets/icons_material/baseline-accessibility-24px.svg"
                    }

                    AndroidTextField {
                        anchors.verticalCenter: parent.verticalCenter
                        title: "AndroidTextField"
                        text: "some text"
                        placeholderText: "placeholder text"
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
                    spacing: Theme.componentMargin

                    TextFieldThemed {
                        anchors.verticalCenter: parent.verticalCenter
                        width: 256
                        placeholderText: "placeholder text"
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
                        text: "ButtonThemed"
                    }

                    ButtonIconThemed {
                        anchors.verticalCenter: parent.verticalCenter
                        text: "ButtonIconThemed"
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

                    SpinBoxThemedMobile {
                        anchors.verticalCenter: parent.verticalCenter
                        //legend: "°"
                    }

                    SpinBoxThemedDesktop {
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

                ////////////////
            }
        }
    }

    ////////////////////////////////////////////////////////////////////////////
}
