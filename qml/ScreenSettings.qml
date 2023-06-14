import QtQuick
import QtQuick.Controls

import ThemeEngine 1.0

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
        ScrollBar.vertical: ScrollBar { visible: isDesktop; }

        function backAction() {
            //
        }

        Column {
            id: contentColumn

            anchors.left: parent.left
            anchors.right: parent.right

            topPadding: 12
            bottomPadding: 12
            spacing: 8

            ////////////////

            SectionTitle {
                anchors.leftMargin: singleColumn ? 0 : 12
                anchors.rightMargin: singleColumn ? 0 : 12

                text: qsTr("Application")
                source: "qrc:/assets/icons_material/baseline-settings-20px.svg"
            }

            ////////////////

            Item {
                id: element_appTheme
                height: 48
                anchors.left: parent.left
                anchors.leftMargin: screenPaddingLeft
                anchors.right: parent.right
                anchors.rightMargin: screenPaddingRight

                IconSvg {
                    id: image_appTheme
                    width: 24
                    height: 24
                    anchors.left: parent.left
                    anchors.leftMargin: 16
                    anchors.verticalCenter: parent.verticalCenter

                    color: Theme.colorIcon
                    source: "qrc:/assets/icons_material/duotone-style-24px.svg"
                }

                Text {
                    id: text_appTheme
                    height: 40
                    anchors.left: image_appTheme.right
                    anchors.leftMargin: 24
                    anchors.right: appTheme_selector.left
                    anchors.rightMargin: 16
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
                    anchors.rightMargin: 16
                    anchors.verticalCenter: parent.verticalCenter

                    z: 1
                    spacing: 10

                    Rectangle {
                        id: rectangleSnow
                        width: wideWideMode ? 80 : 32
                        height: 32
                        anchors.verticalCenter: parent.verticalCenter

                        radius: 2
                        color: "white"
                        border.color: (settingsManager.appTheme === "THEME_SNOW") ? Theme.colorSubText : "#ccc"
                        border.width: 2

                        Text {
                            anchors.centerIn: parent
                            visible: wideWideMode
                            text: qsTr("snow")
                            textFormat: Text.PlainText
                            color: (settingsManager.appTheme === "THEME_SNOW") ? Theme.colorSubText : "#ccc"
                            font.bold: true
                            font.pixelSize: Theme.fontSizeContentSmall
                        }
                        MouseArea {
                            anchors.fill: parent
                            onClicked: settingsManager.appTheme = "THEME_SNOW"
                        }
                    }
                    Rectangle {
                        id: rectangleDay
                        width: wideWideMode ? 80 : 32
                        height: 32
                        anchors.verticalCenter: parent.verticalCenter

                        radius: 2
                        color: "#FFE400" // day theme colorSecondary
                        border.color: Theme.colorPrimary
                        border.width: (settingsManager.appTheme === "THEME_DAY") ? 2 : 0

                        Text {
                            anchors.centerIn: parent
                            visible: wideWideMode
                            text: qsTr("day")
                            textFormat: Text.PlainText
                            color: "white"
                            font.bold: true
                            font.pixelSize: Theme.fontSizeContentSmall
                        }
                        MouseArea {
                            anchors.fill: parent
                            onClicked: settingsManager.appTheme = "THEME_DAY"
                        }
                    }
                    Rectangle {
                        id: rectangleNight
                        width: wideWideMode ? 80 : 32
                        height: 32
                        anchors.verticalCenter: parent.verticalCenter

                        radius: 2
                        color: "#555151"
                        border.color: Theme.colorPrimary
                        border.width: (settingsManager.appTheme === "THEME_NIGHT") ? 2 : 0

                        Text {
                            anchors.centerIn: parent
                            visible: wideWideMode
                            text: qsTr("night")
                            textFormat: Text.PlainText
                            color: (settingsManager.appTheme === "THEME_NIGHT") ? Theme.colorPrimary : "#ececec"
                            font.bold: true
                            font.pixelSize: Theme.fontSizeContentSmall
                        }
                        MouseArea {
                            anchors.fill: parent
                            onClicked: settingsManager.appTheme = "THEME_NIGHT"
                        }
                    }
                }
            }

            ////////

            ComboBoxThemed {
                id: comboBoxAppTheme
                anchors.left: parent.left
                anchors.leftMargin: screenPaddingLeft + 64
                anchors.right: parent.right
                anchors.rightMargin: screenPaddingRight + 16

                //height: 48
                visible: isMobile

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

            ////////

            Item {
                id: element_appThemeAuto
                height: 48
                anchors.left: parent.left
                anchors.leftMargin: screenPaddingLeft
                anchors.right: parent.right
                anchors.rightMargin: screenPaddingRight

                IconSvg {
                    id: image_appThemeAuto
                    width: 24
                    height: 24
                    anchors.left: parent.left
                    anchors.leftMargin: 16
                    anchors.verticalCenter: parent.verticalCenter

                    color: Theme.colorIcon
                    source: "qrc:/assets/icons_material/duotone-brightness_4-24px.svg"
                }

                Text {
                    id: text_appThemeAuto
                    height: 40
                    anchors.left: image_appThemeAuto.right
                    anchors.leftMargin: 24
                    anchors.right: switch_appThemeAuto.left
                    anchors.rightMargin: 16
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
                    anchors.rightMargin: 0
                    anchors.verticalCenter: parent.verticalCenter
                    z: 1

                    checked: settingsManager.appThemeAuto
                    onClicked: {
                        settingsManager.appThemeAuto = checked
                        Theme.loadTheme(settingsManager.appTheme)
                    }
                }
            }
            Text {
                id: legend_appThemeAuto
                anchors.left: parent.left
                anchors.leftMargin: screenPaddingLeft + 64
                anchors.right: parent.right
                anchors.rightMargin: 16

                topPadding: -16
                bottomPadding: isMobile ? 12 : 0
                visible: element_appThemeAuto.visible

                text: qsTr("Dark mode will switch on automatically between 9 PM and 9 AM.")
                textFormat: Text.PlainText
                wrapMode: Text.WordWrap
                color: Theme.colorSubText
                font.pixelSize: Theme.fontSizeContentSmall
            }

            ////////

            Item {
                id: element_appThemeCSD
                height: 48
                anchors.left: parent.left
                anchors.leftMargin: screenPaddingLeft
                anchors.right: parent.right
                anchors.rightMargin: screenPaddingRight

                IconSvg {
                    id: image_appThemeCSD
                    width: 24
                    height: 24
                    anchors.left: parent.left
                    anchors.leftMargin: 16
                    anchors.verticalCenter: parent.verticalCenter

                    color: Theme.colorIcon
                    source: "qrc:/assets/icons_material/baseline-close-24px.svg"
                }

                Text {
                    id: text_appThemeCSD
                    height: 40
                    anchors.left: image_appThemeCSD.right
                    anchors.leftMargin: 24
                    anchors.right: switch_appThemeCSD.left
                    anchors.rightMargin: 16
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
                    anchors.rightMargin: 0
                    anchors.verticalCenter: parent.verticalCenter
                    z: 1

                    checked: settingsManager.appThemeCSD
                    onClicked: settingsManager.appThemeCSD = checked
                }
            }
            Text {
                id: legend_appThemeCSD
                anchors.left: parent.left
                anchors.leftMargin: screenPaddingLeft + 64
                anchors.right: parent.right
                anchors.rightMargin: 16

                topPadding: -16
                bottomPadding: isMobile ? 12 : 0
                visible: element_appThemeCSD.visible

                text: qsTr("qetxyjcgkcul.")
                textFormat: Text.PlainText
                wrapMode: Text.WordWrap
                color: Theme.colorSubText
                font.pixelSize: Theme.fontSizeContentSmall
            }

            ////////
/*
            Rectangle { // separator
                height: 1
                anchors.left: parent.left
                anchors.right: parent.right
                color: Theme.colorSeparator
            }
*/
            ////////

            Item {
                id: element_language
                height: 48
                anchors.left: parent.left
                anchors.leftMargin: screenPaddingLeft
                anchors.right: parent.right
                anchors.rightMargin: screenPaddingRight

                IconSvg {
                    id: image_language
                    width: 24
                    height: 24
                    anchors.left: parent.left
                    anchors.leftMargin: 16
                    anchors.verticalCenter: parent.verticalCenter

                    color: Theme.colorIcon
                    source: "qrc:/assets/icons_material/duotone-translate-24px.svg"
                }

                Text {
                    id: text_language
                    height: 40
                    anchors.left: image_language.right
                    anchors.leftMargin: 24
                    anchors.right: combobox_language.left
                    anchors.rightMargin: 16
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
                    anchors.rightMargin: 12
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
                            if (cbAppLanguage.get(i).text === settingsManager.appLanguage)
                                currentIndex = i
                        }
                    }
                    property bool cbinit: false
                    onCurrentIndexChanged: {
                        if (cbinit) {
                            utilsLanguage.loadLanguage(cbAppLanguage.get(currentIndex).text)
                            settingsManager.appLanguage = cbAppLanguage.get(currentIndex).text
                        } else {
                            cbinit = true
                        }
                    }
                }
            }

            ////////////////

            SectionTitle {
                anchors.leftMargin: singleColumn ? 0 : 12
                anchors.rightMargin: singleColumn ? 0 : 12

                text: qsTr("Other fake settings")
                source: "qrc:/assets/icons_material/baseline-settings-20px.svg"
            }

            ////////////////

            Item {
                height: 48
                anchors.left: parent.left
                anchors.leftMargin: screenPaddingLeft
                anchors.right: parent.right
                anchors.rightMargin: screenPaddingRight

                IconSvg {
                    id: image_aaa
                    width: 24
                    height: 24
                    anchors.left: parent.left
                    anchors.leftMargin: 16
                    anchors.verticalCenter: parent.verticalCenter

                    color: Theme.colorIcon
                    source: "qrc:/assets/icons_material/baseline-accessibility-24px.svg"
                }

                Text {
                    height: 40
                    anchors.left: image_aaa.right
                    anchors.leftMargin: 24
                    anchors.right: switch_aaa.left
                    anchors.rightMargin: 16
                    anchors.verticalCenter: parent.verticalCenter

                    text: qsTr("A desktop switch")
                    textFormat: Text.PlainText
                    font.pixelSize: Theme.fontSizeContent
                    color: Theme.colorText
                    wrapMode: Text.WordWrap
                    verticalAlignment: Text.AlignVCenter
                }

                SwitchThemedMobile {
                    id: switch_aaa
                    anchors.right: parent.right
                    anchors.rightMargin: 0
                    anchors.verticalCenter: parent.verticalCenter
                    z: 1
                }
            }

            ////////////////

            Item {
                height: 48
                anchors.left: parent.left
                anchors.leftMargin: screenPaddingLeft
                anchors.right: parent.right
                anchors.rightMargin: screenPaddingRight

                IconSvg {
                    id: image_bbb
                    width: 24
                    height: 24
                    anchors.left: parent.left
                    anchors.leftMargin: 16
                    anchors.verticalCenter: parent.verticalCenter

                    color: Theme.colorIcon
                    source: "qrc:/assets/icons_material/baseline-accessibility-24px.svg"
                }

                Text {
                    height: 40
                    anchors.left: image_bbb.right
                    anchors.leftMargin: 24
                    anchors.right: spinbox_bbb.left
                    anchors.rightMargin: 16
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
                    anchors.rightMargin: 12
                    anchors.verticalCenter: parent.verticalCenter
                    z: 1

                    from: 1
                    to: 10
                    value: 5
                    legend: " h."
                }
            }

            ////////////////
        }
    }

    ////////////////////////////////////////////////////////////////////////////
}
