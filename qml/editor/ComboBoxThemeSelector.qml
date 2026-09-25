import QtQuick

import ComponentLibrary

ComboBoxThemed {
    model: ListModel {
        id: cbAppTheme
        ListElement { text: "MOBILE LIGHT"; }
        ListElement { text: "MOBILE DARK"; }

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
