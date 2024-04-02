import QtQuick
import QtQuick.Controls

import ThemeEngine

Loader {
    id: screenSettings
    anchors.fill: parent

    function loadScreen() {
        // load screen
        screenSettings.active = true

        // change screen
        appContent.state = "Settings"
    }

    function backAction() {
        if (screenSettings.status === Loader.Ready)
            screenSettings.item.backAction()
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

        function backAction() {
            screenMainView.loadScreen()
        }

        Column {
            id: contentColumn
            anchors.left: parent.left
            anchors.right: parent.right

            topPadding: 16
            bottomPadding: 16
            spacing: 8

            property int padIcon: singleColumn ? Theme.componentMarginL : Theme.componentMarginL
            property int padText: appHeader.headerPosition

            ////////////////

            //ListTitle {
            //    text: qsTr("Application")
            //    source: "qrc:/assets/icons_material/baseline-settings-20px.svg"
            //}

            ////////////////

            Item { // element_appTheme
                anchors.left: parent.left
                anchors.leftMargin: screenPaddingLeft
                anchors.right: parent.right
                anchors.rightMargin: screenPaddingRight
                height: Theme.componentHeightXL

                IconSvg {
                    anchors.left: parent.left
                    anchors.leftMargin: contentColumn.padIcon
                    anchors.verticalCenter: parent.verticalCenter

                    width: 24
                    height: 24
                    color: Theme.colorIcon
                    source: "qrc:/assets/icons_material/duotone-style-24px.svg"
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

                Row {
                    id: appTheme_selector
                    anchors.right: parent.right
                    anchors.rightMargin: Theme.componentMargin
                    anchors.verticalCenter: parent.verticalCenter

                    z: 1
                    spacing: Theme.componentMargin

                    Rectangle { // theme mobile light
                        width: wideWideMode ? 80 : 32
                        height: 32
                        anchors.verticalCenter: parent.verticalCenter

                        radius: 2
                        color: (Theme.currentTheme === ThemeEngine.THEME_MOBILE_LIGHT) ? Theme.colorForeground : "#dddddd"
                        border.color: Theme.colorSecondary
                        border.width: (Theme.currentTheme === ThemeEngine.THEME_MOBILE_LIGHT) ? 2 : 0

                        Text {
                            anchors.centerIn: parent
                            visible: wideWideMode
                            text: qsTr("light")
                            color: "#313236"
                            font.bold: true
                            font.pixelSize: Theme.fontSizeContentSmall
                        }
                        MouseArea {
                            anchors.fill: parent
                            onClicked: settingsManager.appTheme = "THEME_MOBILE_LIGHT"
                        }
                    }
                    Rectangle { // theme mobile dark
                        width: wideWideMode ? 80 : 32
                        height: 32
                        anchors.verticalCenter: parent.verticalCenter

                        radius: 2
                        color: (Theme.currentTheme === ThemeEngine.THEME_MOBILE_DARK) ? Theme.colorForeground : "#313236"
                        border.color: Theme.colorSecondary
                        border.width: (Theme.currentTheme === ThemeEngine.THEME_MOBILE_DARK) ? 2 : 0

                        Text {
                            anchors.centerIn: parent
                            visible: wideWideMode
                            text: qsTr("dark")
                            color: "#dddddd"
                            font.bold: true
                            font.pixelSize: Theme.fontSizeContentSmall
                        }
                        MouseArea {
                            anchors.fill: parent
                            onClicked: settingsManager.appTheme = "THEME_MOBILE_DARK"
                        }
                    }
                }
            }

            ////////

            Item { // element_appTheme
                anchors.left: parent.left
                anchors.leftMargin: screenPaddingLeft
                anchors.right: parent.right
                anchors.rightMargin: screenPaddingRight
                height: Theme.componentHeightXL

                visible: isMobile

                IconSvg {
                    anchors.left: parent.left
                    anchors.leftMargin: contentColumn.padIcon
                    anchors.verticalCenter: parent.verticalCenter

                    width: 24
                    height: 24
                    color: Theme.colorIcon
                    source: "qrc:/assets/icons_material/duotone-style-24px.svg"
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

                ComboBoxThemed {
                    //anchors.left: parent.left
                    //anchors.leftMargin: contentColumn.padText
                    anchors.right: parent.right
                    anchors.rightMargin: Theme.componentMargin
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
            }

            ////////

            Item { // element_appThemeAuto
                anchors.left: parent.left
                anchors.leftMargin: screenPaddingLeft
                anchors.right: parent.right
                anchors.rightMargin: screenPaddingRight
                height: Theme.componentHeightXL

                IconSvg {
                    anchors.left: parent.left
                    anchors.leftMargin: contentColumn.padIcon
                    anchors.verticalCenter: parent.verticalCenter

                    width: 24
                    height: 24
                    color: Theme.colorIcon
                    source: "qrc:/assets/icons_material/duotone-brightness_4-24px.svg"
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

                SwitchThemedDesktop {
                    id: switch_appThemeAuto
                    anchors.right: parent.right
                    anchors.rightMargin: 4
                    anchors.verticalCenter: parent.verticalCenter
                    z: 1

                    checked: settingsManager.appThemeAuto
                    onClicked: {
                        settingsManager.appThemeAuto = checked
                        Theme.loadTheme(settingsManager.appTheme)
                    }
                }
            }
            Text { // legend_appThemeAuto
                anchors.left: parent.left
                anchors.leftMargin: screenPaddingLeft + contentColumn.padText
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

            Item { // element_appThemeCSD
                anchors.left: parent.left
                anchors.leftMargin: screenPaddingLeft
                anchors.right: parent.right
                anchors.rightMargin: screenPaddingRight
                height: Theme.componentHeightXL

                visible: isDesktop

                IconSvg {
                    anchors.left: parent.left
                    anchors.leftMargin: contentColumn.padIcon
                    anchors.verticalCenter: parent.verticalCenter

                    width: 24
                    height: 24
                    color: Theme.colorIcon
                    source: "qrc:/assets/icons_material/baseline-close-24px.svg"
                }

                Text {
                    anchors.left: parent.left
                    anchors.leftMargin: contentColumn.padText
                    anchors.right: switch_appThemeCSD.left
                    anchors.rightMargin: Theme.componentMargin
                    anchors.verticalCenter: parent.verticalCenter

                    text: qsTr("Client Side Decoration")
                    textFormat: Text.PlainText
                    font.pixelSize: Theme.fontSizeContent
                    color: Theme.colorText
                    wrapMode: Text.WordWrap
                    verticalAlignment: Text.AlignVCenter
                }

                SwitchThemedDesktop {
                    id: switch_appThemeCSD
                    anchors.right: parent.right
                    anchors.rightMargin: 4
                    anchors.verticalCenter: parent.verticalCenter
                    z: 1

                    checked: settingsManager.appThemeCSD
                    onClicked: settingsManager.appThemeCSD = checked
                }
            }
            Text { // legend_appThemeCSD
                anchors.left: parent.left
                anchors.leftMargin: screenPaddingLeft + contentColumn.padText
                anchors.right: parent.right
                anchors.rightMargin: Theme.componentMargin

                topPadding: -12
                bottomPadding: 0
                visible: isDesktop

                text: qsTr("qetxyjcgkcul.")
                textFormat: Text.PlainText
                wrapMode: Text.WordWrap
                color: Theme.colorSubText
                font.pixelSize: Theme.fontSizeContentSmall
            }

            ////////

            ListSeparator { }

            Item { // element_language
                anchors.left: parent.left
                anchors.leftMargin: screenPaddingLeft
                anchors.right: parent.right
                anchors.rightMargin: screenPaddingRight
                height: Theme.componentHeightXL

                IconSvg {
                    anchors.left: parent.left
                    anchors.leftMargin: contentColumn.padIcon
                    anchors.verticalCenter: parent.verticalCenter

                    width: 24
                    height: 24
                    color: Theme.colorIcon
                    source: "qrc:/assets/icons_material/duotone-translate-24px.svg"
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
                    width: wideMode ? 256 : 160
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
                            if (cbAppLanguage.get(i).text === settingsManager.appLanguage) {
                                currentIndex = i
                            }
                        }
                    }
                    onActivated: {
                        utilsLanguage.loadLanguage(cbAppLanguage.get(currentIndex).text)
                        settingsManager.appLanguage = cbAppLanguage.get(currentIndex).text
                    }
                }
            }

            ListSeparator { }

            ////////

            Item {
                anchors.left: parent.left
                anchors.leftMargin: screenPaddingLeft
                anchors.right: parent.right
                anchors.rightMargin: screenPaddingRight
                height: Theme.componentHeightXL

                IconSvg {
                    anchors.left: parent.left
                    anchors.leftMargin: contentColumn.padIcon
                    anchors.verticalCenter: parent.verticalCenter

                    width: 24
                    height: 24
                    color: Theme.colorIcon
                    source: "qrc:/assets/icons_material/baseline-accessibility-24px.svg"
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

                SwitchThemedDesktop {
                    id: switch_aaa
                    anchors.right: parent.right
                    anchors.rightMargin: 4
                    anchors.verticalCenter: parent.verticalCenter
                    z: 1
                }
            }

            ////////////////

            Item {
                anchors.left: parent.left
                anchors.leftMargin: screenPaddingLeft
                anchors.right: parent.right
                anchors.rightMargin: screenPaddingRight
                height: Theme.componentHeightXL

                IconSvg {
                    anchors.left: parent.left
                    anchors.leftMargin: contentColumn.padIcon
                    anchors.verticalCenter: parent.verticalCenter

                    width: 24
                    height: 24
                    color: Theme.colorIcon
                    source: "qrc:/assets/icons_material/baseline-accessibility-24px.svg"
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
}
