import QtQuick
import QtQuick.Controls

import ComponentLibrary
import AppUtils

Loader {
    id: screenSettings
    anchors.fill: parent

    function loadScreen() {
        // load screen
        screenSettings.active = true

        // change screen
        appContent.state = "ScreenSettings"
    }

    function backAction() {
        if (screenSettings.status === Loader.Ready)
            return screenSettings.item.backAction()

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
            spacing: Theme.isPhone ? Theme.componentMarginXS : Theme.componentMarginXL

            property int padIcon: Theme.singleColumn ? Theme.componentMarginL : Theme.componentMarginL
            property int padText: appHeader.headerPosition

            ////////////////

            ListTitle {
                anchors.left: parent.left
                anchors.leftMargin: 0
                anchors.right: parent.right
                anchors.rightMargin: 0

                text: qsTr("Application")
                source: "qrc:/IconLibrary/material-symbols/settings.svg"
            }

            ////////////////

            Item { // element_appTheme
                anchors.left: parent.left
                anchors.right: parent.right
                height: Theme.componentHeightXL

                IconSvg {
                    anchors.left: parent.left
                    anchors.leftMargin: contentColumn.padIcon
                    anchors.verticalCenter: parent.verticalCenter

                    width: 24
                    height: 24
                    color: Theme.colorIcon
                    source: "qrc:/IconLibrary/material-icons/duotone/style.svg"
                }

                Text {
                    anchors.left: parent.left
                    anchors.leftMargin: contentColumn.padText
                    anchors.verticalCenter: parent.verticalCenter

                    text: qsTr("Theme")
                    textFormat: Text.PlainText
                    font.pixelSize: Theme.fontSizeContent
                    color: Theme.colorText
                    wrapMode: Text.WordWrap
                    verticalAlignment: Text.AlignVCenter
                }

                ////
/*
                Row {
                    id: appTheme_selector
                    anchors.right: parent.right
                    anchors.rightMargin: Theme.componentMargin
                    anchors.verticalCenter: parent.verticalCenter

                    z: 1
                    spacing: Theme.componentMargin

                    ThemeSwatch {
                        anchors.verticalCenter: parent.verticalCenter
                        width: Theme.wide ? 80 : 32

                        themeId: Theme.THEME_MOBILE_LIGHT
                        themeName: "THEME_MOBILE_LIGHT"
                        label: qsTr("light")
                        previewColor: "#dddddd"
                        labelColor: "#313236"
                    }
                    ThemeSwatch {
                        anchors.verticalCenter: parent.verticalCenter
                        width: Theme.wide ? 80 : 32

                        themeId: Theme.THEME_MOBILE_DARK
                        themeName: "THEME_MOBILE_DARK"
                        label: qsTr("dark")
                        previewColor: "#313236"
                        labelColor: "#dddddd"
                    }
                }
*/
                ////

                ComboBoxThemed {
                    anchors.right: parent.right
                    anchors.rightMargin: Theme.componentMargin
                    anchors.verticalCenter: parent.verticalCenter

                    visible: Theme.isPhone

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

                        ListElement { text: "ADWAITA"; }
                        ListElement { text: "MACOS"; }
                        ListElement { text: "WINDOWS"; }
                    }

                    Component.onCompleted: {
                        currentIndex = Theme.getThemeIndex(SettingsManager.appTheme) - 1
                    }
                    onActivated: {
                        if (currentText === "MOBILE LIGHT") SettingsManager.appTheme = "THEME_MOBILE_LIGHT"
                        else if (currentText === "MOBILE DARK") SettingsManager.appTheme = "THEME_MOBILE_DARK"

                        else if (currentText === "DESKTOP LIGHT") SettingsManager.appTheme = "THEME_DESKTOP_LIGHT"
                        else if (currentText === "DESKTOP DARK") SettingsManager.appTheme = "THEME_DESKTOP_DARK"

                        else if (currentText === "SNOW") SettingsManager.appTheme = "THEME_SNOW"
                        else if (currentText === "PLANT") SettingsManager.appTheme = "THEME_PLANT"
                        else if (currentText === "RAIN") SettingsManager.appTheme = "THEME_RAIN"
                        else if (currentText === "DAY") SettingsManager.appTheme = "THEME_DAY"
                        else if (currentText === "NIGHT") SettingsManager.appTheme = "THEME_NIGHT"

                        else if (currentText === "LIGHT AND WARM") SettingsManager.appTheme = "THEME_LIGHT_AND_WARM"
                        else if (currentText === "DARK AND SPOOKY") SettingsManager.appTheme = "THEME_DARK_AND_SPOOKY"
                        else if (currentText === "PLAIN AND BORING") SettingsManager.appTheme = "THEME_PLAIN_AND_BORING"
                        else if (currentText === "BLOOD AND TEARS") SettingsManager.appTheme = "THEME_BLOOD_AND_TEARS"
                        else if (currentText === "MIGHTY KITTENS") SettingsManager.appTheme = "THEME_MIGHTY_KITTENS"

                        else if (currentText === "ADWAITA") SettingsManager.appTheme = "THEME_ADWAITA"
                        else if (currentText === "MACOS") SettingsManager.appTheme = "THEME_MACOS"
                        else if (currentText === "WINDOWS") SettingsManager.appTheme = "THEME_WINDOWS"
                    }
                }

                ////
            }

            Flow { // element_appThemeFlow
                anchors.left: parent.left
                anchors.leftMargin: contentColumn.padIcon
                anchors.right: parent.right
                anchors.rightMargin: Theme.componentMargin

                visible: !Theme.isPhone

                spacing: Theme.componentMarginS

                ThemeSwatch {
                    themeId: Theme.THEME_MOBILE_LIGHT; themeName: "THEME_MOBILE_LIGHT"
                    label: qsTr("Mobile light"); previewColor: "#f8f8f8"; labelColor: "#303030"
                }
                ThemeSwatch {
                    themeId: Theme.THEME_MOBILE_DARK; themeName: "THEME_MOBILE_DARK"
                    label: qsTr("Mobile dark"); previewColor: "#313236"; labelColor: "white"
                }

                ThemeSwatch {
                    themeId: Theme.THEME_DESKTOP_LIGHT; themeName: "THEME_DESKTOP_LIGHT"
                    label: qsTr("Desktop light"); previewColor: "#f9f8f7"; labelColor: "#373737"
                }
                ThemeSwatch {
                    themeId: Theme.THEME_DESKTOP_DARK; themeName: "THEME_DESKTOP_DARK"
                    label: qsTr("Desktop dark"); previewColor: "#2e2a2e"; labelColor: "#eee"
                }

                ThemeSwatch {
                    themeId: Theme.THEME_SNOW; themeName: "THEME_SNOW"
                    label: qsTr("Snow"); previewColor: "white"; labelColor: "#474747"
                }
                ThemeSwatch {
                    themeId: Theme.THEME_PLANT; themeName: "THEME_PLANT"
                    label: qsTr("Plant"); previewColor: "#f8f8f8"; labelColor: "#333333"
                }
                ThemeSwatch {
                    themeId: Theme.THEME_RAIN; themeName: "THEME_RAIN"
                    label: qsTr("Rain"); previewColor: "white"; labelColor: "#474747"
                }
                ThemeSwatch {
                    themeId: Theme.THEME_DAY; themeName: "THEME_DAY"
                    label: qsTr("Day"); previewColor: "white"; labelColor: "#474747"
                }
                ThemeSwatch {
                    themeId: Theme.THEME_NIGHT; themeName: "THEME_NIGHT"
                    label: qsTr("Night"); previewColor: "#313236"; labelColor: "#EEE"
                }

                ThemeSwatch {
                    themeId: Theme.THEME_LIGHT_AND_WARM; themeName: "THEME_LIGHT_AND_WARM"
                    label: qsTr("Light and warm"); previewColor: "#F4F4F4"; labelColor: "#222"
                }
                ThemeSwatch {
                    themeId: Theme.THEME_DARK_AND_SPOOKY; themeName: "THEME_DARK_AND_SPOOKY"
                    label: qsTr("Dark and spooky"); previewColor: "#3F3F3F"; labelColor: "white"
                }
                ThemeSwatch {
                    themeId: Theme.THEME_PLAIN_AND_BORING; themeName: "THEME_PLAIN_AND_BORING"
                    label: qsTr("Plain and boring"); previewColor: "#fefefe"; labelColor: "#222222"
                }
                ThemeSwatch {
                    themeId: Theme.THEME_BLOOD_AND_TEARS; themeName: "THEME_BLOOD_AND_TEARS"
                    label: qsTr("Blood and tears"); previewColor: "#222"; labelColor: "#D4D4D4"
                }
                ThemeSwatch {
                    themeId: Theme.THEME_MIGHTY_KITTENS; themeName: "THEME_MIGHTY_KITTENS"
                    label: qsTr("Mighty kittens"); previewColor: "white"; labelColor: "#932A97"
                }

                ThemeSwatch {
                    themeId: Theme.THEME_ADWAITA; themeName: "THEME_ADWAITA"
                    label: qsTr("Adwaita"); previewColor: "#ffffff"; labelColor: "#373737"
                }
                ThemeSwatch {
                    themeId: Theme.THEME_MACOS; themeName: "THEME_MACOS"
                    label: qsTr("macOS"); previewColor: "#ffffff"; labelColor: "#222222"
                }
                ThemeSwatch {
                    themeId: Theme.THEME_WINDOWS; themeName: "THEME_WINDOWS"
                    label: qsTr("Windows"); previewColor: "#f2f2f2"; labelColor: "#373737"
                }
            }

            ////////

            Item { // element_appThemeAuto
                anchors.left: parent.left
                anchors.right: parent.right
                height: Theme.componentHeightXL

                IconSvg {
                    anchors.left: parent.left
                    anchors.leftMargin: contentColumn.padIcon
                    anchors.verticalCenter: parent.verticalCenter

                    width: 24
                    height: 24
                    color: Theme.colorIcon
                    source: "qrc:/IconLibrary/material-icons/duotone/brightness_4.svg"
                }

                Text {
                    anchors.left: parent.left
                    anchors.leftMargin: contentColumn.padText
                    anchors.right: switch_appThemeAuto.left
                    anchors.rightMargin: Theme.componentMargin
                    anchors.verticalCenter: parent.verticalCenter

                    text: qsTr("Automatic dark mode")
                    textFormat: Text.PlainText
                    font.pixelSize: Theme.fontSizeContent
                    color: Theme.colorText
                    wrapMode: Text.WordWrap
                    verticalAlignment: Text.AlignVCenter
                }

                SwitchThemed {
                    id: switch_appThemeAuto
                    anchors.right: parent.right
                    anchors.rightMargin: Theme.componentMargin
                    anchors.verticalCenter: parent.verticalCenter
                    z: 1

                    checked: SettingsManager.appThemeAuto
                    onClicked: {
                        SettingsManager.appThemeAuto = checked
                        Theme.loadTheme(SettingsManager.appTheme)
                    }
                }
            }
            Text { // legend_appThemeAuto
                anchors.left: parent.left
                anchors.leftMargin: contentColumn.padText
                anchors.right: parent.right
                anchors.rightMargin: Theme.componentMargin

                topPadding: -12
                bottomPadding: 0

                text: qsTr("Dark mode will switch on automatically between 9 PM and 9 AM.")
                textFormat: Text.PlainText
                wrapMode: Text.WordWrap
                color: Theme.colorSubText
                font.pixelSize: Theme.fontSizeContentSmall
            }

            ////////

            ListSeparator { }

            Item { // element_language
                anchors.left: parent.left
                anchors.right: parent.right
                height: Theme.componentHeightXL

                IconSvg {
                    anchors.left: parent.left
                    anchors.leftMargin: contentColumn.padIcon
                    anchors.verticalCenter: parent.verticalCenter

                    width: 24
                    height: 24
                    color: Theme.colorIcon
                    source: "qrc:/IconLibrary/material-icons/duotone/translate.svg"
                }

                Text {
                    anchors.left: parent.left
                    anchors.leftMargin: contentColumn.padText
                    anchors.right: combobox_language.left
                    anchors.rightMargin: Theme.componentMargin
                    anchors.verticalCenter: parent.verticalCenter

                    text: qsTr("Language")
                    textFormat: Text.PlainText
                    font.pixelSize: Theme.fontSizeContent
                    color: Theme.colorText
                    wrapMode: Text.WordWrap
                    verticalAlignment: Text.AlignVCenter
                }

                ComboBoxThemed {
                    id: combobox_language
                    width: Theme.wideMode ? 256 : 160
                    anchors.right: parent.right
                    anchors.rightMargin: Theme.componentMargin
                    anchors.verticalCenter: parent.verticalCenter

                    z: 1
                    wheelEnabled: false

                    model: ListModel {
                        id: cbAppLanguage
                        ListElement {
                            text: qsTr("auto", "short for automatic");
                        }
                        ListElement { text: "Chinese (traditional)"; }
                        ListElement { text: "Chinese (simplified)"; }
                        ListElement { text: "Dansk"; }
                        ListElement { text: "Deutsch"; }
                        ListElement { text: "English"; }
                        ListElement { text: "Español"; }
                        ListElement { text: "Français"; }
                        ListElement { text: "Frysk"; }
                        ListElement { text: "Nederlands"; }
                        ListElement { text: "Norsk (Bokmål)"; }
                        ListElement { text: "Norsk (Nynorsk)"; }
                        ListElement { text: "Pусский"; }
                    }

                    Component.onCompleted: {
                        for (var i = 0; i < cbAppLanguage.count; i++) {
                            if (cbAppLanguage.get(i).text === SettingsManager.appLanguage) {
                                currentIndex = i
                            }
                        }
                    }
                    onActivated: {
                        UtilsLanguage.loadLanguage(cbAppLanguage.get(currentIndex).text)
                        SettingsManager.appLanguage = cbAppLanguage.get(currentIndex).text
                    }
                }
            }

            ////////////////

            ListTitle {
                anchors.left: parent.left
                anchors.leftMargin: 0
                anchors.right: parent.right
                anchors.rightMargin: 0

                text: qsTr("Test settings")
                source: "qrc:/IconLibrary/material-symbols/settings.svg"
            }

            ////////////////

            Item {
                anchors.left: parent.left
                anchors.right: parent.right
                height: Theme.componentHeightXL

                IconSvg {
                    anchors.left: parent.left
                    anchors.leftMargin: contentColumn.padIcon
                    anchors.verticalCenter: parent.verticalCenter

                    width: 24
                    height: 24
                    color: Theme.colorIcon
                    source: "qrc:/IconLibrary/material-symbols/accessibility.svg"
                }

                Text {
                    anchors.left: parent.left
                    anchors.leftMargin: contentColumn.padText
                    anchors.right: switch_aaa.left
                    anchors.rightMargin: Theme.componentMargin
                    anchors.verticalCenter: parent.verticalCenter

                    text: qsTr("A desktop switch")
                    textFormat: Text.PlainText
                    font.pixelSize: Theme.fontSizeContent
                    color: Theme.colorText
                    wrapMode: Text.WordWrap
                    verticalAlignment: Text.AlignVCenter
                }

                SwitchThemed {
                    id: switch_aaa
                    anchors.right: parent.right
                    anchors.rightMargin: Theme.componentMargin
                    anchors.verticalCenter: parent.verticalCenter
                    z: 1
                }
            }

            ////////////////

            Item {
                anchors.left: parent.left
                anchors.right: parent.right
                height: Theme.componentHeightXL

                IconSvg {
                    anchors.left: parent.left
                    anchors.leftMargin: contentColumn.padIcon
                    anchors.verticalCenter: parent.verticalCenter

                    width: 24
                    height: 24
                    color: Theme.colorIcon
                    source: "qrc:/IconLibrary/material-symbols/accessibility.svg"
                }

                Text {
                    anchors.left: parent.left
                    anchors.leftMargin: contentColumn.padText
                    anchors.right: spinbox_bbb.left
                    anchors.rightMargin: Theme.componentMargin
                    anchors.verticalCenter: parent.verticalCenter

                    text: qsTr("A spinbox with a legend!")
                    textFormat: Text.PlainText
                    font.pixelSize: Theme.fontSizeContent
                    color: Theme.colorText
                    wrapMode: Text.WordWrap
                    verticalAlignment: Text.AlignVCenter
                }

                SpinBoxThemedMobile {
                    id: spinbox_bbb
                    anchors.right: parent.right
                    anchors.rightMargin: Theme.componentMargin
                    anchors.verticalCenter: parent.verticalCenter
                    z: 1

                    from: 1
                    to: 10
                    value: 5
                    legend: "h."
                }
            }

            ////////////////

            ListSeparator {
                //
            }

            ////////////////
        }
    }

    ////////////////////////////////////////////////////////////////////////////

    component ThemeSwatch: Rectangle {
        id: swatch

        required property int themeId           // Theme.THEME_* enum value, for the selected highlight
        required property string themeName      // "THEME_*" string passed to SettingsManager.appTheme

        property string label: ""
        property color previewColor: "#dddddd"
        property color labelColor: "#313236"
        property bool wide: Theme.wideWideMode

        width: wide ? 160 : 32
        height: wide ? 40 : 32
        radius: 2

        color: (Theme.currentTheme === swatch.themeId) ? Theme.colorForeground : swatch.previewColor
        border.color: Theme.colorSecondary
        border.width: (Theme.currentTheme === swatch.themeId) ? 2 : 0

        Text {
            anchors.fill: parent
            anchors.margins: 4
            visible: swatch.wide

            text: swatch.label
            color: swatch.labelColor
            font.bold: true
            font.pixelSize: Theme.fontSizeContentSmall
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideRight
        }

        MouseArea {
            anchors.fill: parent
            onClicked: SettingsManager.appTheme = swatch.themeName
        }
    }

    ////////////////////////////////////////////////////////////////////////////
}
