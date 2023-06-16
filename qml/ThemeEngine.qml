pragma Singleton

import QtQuick
import QtQuick.Controls.Material

Item {
    enum ThemeNames {
        // WatchFlower
        THEME_SNOW = 0,
        THEME_PLANT = 1,
        THEME_RAIN = 2,
        THEME_DAY = 3,
        THEME_NIGHT = 4,

        // Offloadbuddy
        THEME_LIGHT_AND_WARM = 5,
        THEME_DARK_AND_SPOOKY = 6,
        THEME_PLAIN_AND_BORING = 7,
        THEME_BLOOD_AND_TEARS = 8,
        THEME_MIGHTY_KITTENS = 9,

        THEME_LAST
    }
    property int currentTheme: -1

    ////////////////

    property bool isHdpi: (utilsScreen.screenDpi >= 128 || utilsScreen.screenPar >= 2.0)
    property bool isDesktop: (Qt.platform.os !== "ios" && Qt.platform.os !== "android")
    property bool isMobile: (Qt.platform.os === "ios" || Qt.platform.os === "android")
    property bool isPhone: ((Qt.platform.os === "ios" || Qt.platform.os === "android") && (utilsScreen.screenSize < 7.0))
    property bool isTablet: ((Qt.platform.os === "ios" || Qt.platform.os === "android") && (utilsScreen.screenSize >= 7.0))

    ////////////////

    // Status bar (mobile)
    property int themeStatusbar
    property color colorStatusbar

    // Header
    property color colorHeader
    property color colorHeaderContent
    property color colorHeaderHighlight

    // Side bar (desktop)
    property color colorSidebar
    property color colorSidebarContent
    property color colorSidebarHighlight

    // Action bar
    property color colorActionbar
    property color colorActionbarContent
    property color colorActionbarHighlight

    // Tablet bar (mobile)
    property color colorTabletmenu
    property color colorTabletmenuContent
    property color colorTabletmenuHighlight

    // Content
    property color colorBackground
    property color colorForeground

    property color colorPrimary
    property color colorSecondary
    property color colorSuccess
    property color colorWarning
    property color colorError

    property color colorText
    property color colorSubText
    property color colorIcon
    property color colorSeparator

    property color colorLowContrast
    property color colorHighContrast

    // App specific
    property color colorBox: "white"
    property color colorBoxBorder: "#f4f4f4"
    property color colorDeviceWidget
    property string sidebarSelector // 'arrow' or 'bar'

    ////////////////

    // Palette colors
    property color colorLightGreen: "#09debc"
    property color colorGreen
    property color colorDarkGreen: "#1ea892"
    property color colorBlue
    property color colorYellow
    property color colorOrange
    property color colorRed
    property color colorGrey: "#555151"
    property color colorLightGrey: "#a9bcb8"

    // Fixed colors
    readonly property color colorMaterialBlue: "#2196f3"
    readonly property color colorMaterialThisblue: "#448aff"
    readonly property color colorMaterialIndigo: "#3f51b5"
    readonly property color colorMaterialPurple: "#9c27b0"
    readonly property color colorMaterialDeepPurple: "#673ab7"
    readonly property color colorMaterialRed: "#f44336"
    readonly property color colorMaterialOrange: "#ff9800"
    readonly property color colorMaterialLightGreen: "#8bc34a"

    readonly property color colorMaterialLightGrey: "#f8f8f8"
    readonly property color colorMaterialGrey: "#eeeeee"
    readonly property color colorMaterialDarkGrey: "#ececec"

    readonly property color colorNeutralDay: "#e4e4e4"
    readonly property color colorNeutralNight: "#ffb300"

    ////////////////

    // Qt Quick Controls & theming
    property color colorComponent
    property color colorComponentText
    property color colorComponentContent
    property color colorComponentBorder
    property color colorComponentDown
    property color colorComponentBackground

    property int componentMargin: isHdpi ? 12 : 16
    property int componentMarginL: isHdpi ? 16 : 20
    property int componentMarginXL: isHdpi ? 20 : 24

    property int componentHeight: (isDesktop && isHdpi) ? 36 : 40
    property int componentHeightL: (isDesktop && isHdpi) ? 44 : 48
    property int componentHeightXL: (isDesktop && isHdpi) ? 48 : 56

    property int componentRadius: 4
    property int componentBorderWidth: 2

    property int componentFontSize: isMobile ? 14 : 15
    property int componentFontSize: isMobile ? 14 : 15

    ////////////////

    // Fonts (sizes in pixel)
    readonly property int fontSizeHeader: isMobile ? 22 : 26
    readonly property int fontSizeTitle: isMobile ? 24 : 28
    readonly property int fontSizeContentVeryVerySmall: 10
    readonly property int fontSizeContentVerySmall: 12
    readonly property int fontSizeContentSmall: 14
    readonly property int fontSizeContent: 16
    readonly property int fontSizeContentBig: 18
    readonly property int fontSizeContentVeryBig: 20
    readonly property int fontSizeContentVeryVeryBig: 22

    // Fonts
    property font headerFont: Qt.font({
        family: 'Encode Sans',
        weight: Font.Black,
        italic: false,
        pixelSize: fontSizeHeader
    })

    ////////////////////////////////////////////////////////////////////////////

    function getThemeIndex(name) {
        if (name === "THEME_DEFAULT") return ThemeEngine.THEME_LIGHT_AND_WARM

        if (name === "THEME_SNOW") return ThemeEngine.THEME_SNOW
        if (name === "THEME_PLANT") return ThemeEngine.THEME_PLANT
        if (name === "THEME_RAIN") return ThemeEngine.THEME_RAIN
        if (name === "THEME_DAY") return ThemeEngine.THEME_DAY
        if (name === "THEME_NIGHT") return ThemeEngine.THEME_NIGHT

        if (name === "THEME_LIGHT_AND_WARM") return ThemeEngine.THEME_LIGHT_AND_WARM
        if (name === "THEME_DARK_AND_SPOOKY") return ThemeEngine.THEME_DARK_AND_SPOOKY
        if (name === "THEME_PLAIN_AND_BORING") return ThemeEngine.THEME_PLAIN_AND_BORING
        if (name === "THEME_BLOOD_AND_TEARS") return ThemeEngine.THEME_BLOOD_AND_TEARS
        if (name === "THEME_MIGHTY_KITTENS") return ThemeEngine.THEME_MIGHTY_KITTENS

        return -1
    }
    function getThemeName(index) {
        if (index === ThemeEngine.THEME_SNOW) return "THEME_SNOW"
        if (index === ThemeEngine.THEME_PLANT) return "THEME_PLANT"
        if (index === ThemeEngine.THEME_RAIN) return "THEME_RAIN"
        if (index === ThemeEngine.THEME_DAY) return "THEME_DAY"
        if (index === ThemeEngine.THEME_NIGHT) return "THEME_NIGHT"

        if (index === ThemeEngine.THEME_LIGHT_AND_WARM) return "THEME_LIGHT_AND_WARM"
        if (index === ThemeEngine.THEME_DARK_AND_SPOOKY) return "THEME_DARK_AND_SPOOKY"
        if (index === ThemeEngine.THEME_PLAIN_AND_BORING) return "THEME_PLAIN_AND_BORING"
        if (index === ThemeEngine.THEME_BLOOD_AND_TEARS) return "THEME_BLOOD_AND_TEARS"
        if (index === ThemeEngine.THEME_MIGHTY_KITTENS) return "THEME_MIGHTY_KITTENS"

        return ""
    }

    ////////////////////////////////////////////////////////////////////////////

    Component.onCompleted: loadTheme(settingsManager.appTheme)
    Connections {
        target: settingsManager
        function onAppThemeChanged() { loadTheme(settingsManager.appTheme) }
    }

    function loadTheme(newIndex) {
        console.log("ThemeEngine.loadTheme(" + newIndex + ")")
        var themeIndex = -1

        // Get the theme index
        if ((typeof newIndex === 'string' || newIndex instanceof String)) {
            themeIndex = getThemeIndex(newIndex)
        } else {
            themeIndex = newIndex
        }

        // Validate the result
        if (themeIndex < 0 || themeIndex >= ThemeEngine.THEME_LAST) {
            themeIndex = ThemeEngine.THEME_LIGHT_AND_WARM // default theme for this app
        }

        // Handle day/night themes
        if (settingsManager.appThemeAuto) {
            var rightnow = new Date()
            var hour = Qt.formatDateTime(rightnow, "hh")
            if (hour >= 21 || hour <= 8) {
                themeIndex = ThemeEngine.THEME_NIGHT
            }
        }

        // Do not reload the same theme
        if (themeIndex === currentTheme) return


        if (themeIndex === ThemeEngine.THEME_SNOW) {

            colorGreen = "#85c700"
            colorBlue = "#4cafe9"
            colorYellow = "#facb00"
            colorOrange = "#ffa635"
            colorRed = "#ff7657"

            themeStatusbar = Material.Light
            colorStatusbar = "white"

            colorHeader = "white"
            colorHeaderContent = "#444"
            colorHeaderHighlight = colorMaterialDarkGrey

            colorSidebar = "white"
            colorSidebarContent = "#444"
            colorSidebarHighlight = colorMaterialDarkGrey

            colorActionbar = colorGreen
            colorActionbarContent = "white"
            colorActionbarHighlight = "#7ab800"

            colorTabletmenu = "#ffffff"
            colorTabletmenuContent = "#9d9d9d"
            colorTabletmenuHighlight = "#0079fe"

            colorBackground = "white"
            colorForeground = colorMaterialLightGrey

            colorPrimary = colorYellow
            colorSecondary = "#ffe800"
            colorSuccess = colorGreen
            colorWarning = colorOrange
            colorError = colorRed

            colorText = "#474747"
            colorSubText = "#666666"
            colorIcon = "#474747"
            colorSeparator = colorMaterialDarkGrey
            colorLowContrast = "white"
            colorHighContrast = "#303030"

            colorDeviceWidget = "#fdfdfd"

            componentRadius = (componentHeight / 2)

            colorComponent = "#EFEFEF"
            colorComponentText = "black"
            colorComponentContent = "black"
            colorComponentBorder = "#EAEAEA"
            colorComponentDown = "#DADADA"
            colorComponentBackground = "#FAFAFA"

        } else if (themeIndex === ThemeEngine.THEME_PLANT) {

            colorGreen = "#07bf97"
            colorBlue = "#4CA1D5"
            colorYellow = "#ffba5a"
            colorOrange = "#ffa635"
            colorRed = "#ff7657"

            themeStatusbar = Material.Dark
            colorStatusbar = "#009688"

            colorHeader = colorGreen
            colorHeaderContent = "white"
            colorHeaderHighlight = "#009688"

            colorSidebar = colorGreen
            colorSidebarContent = "white"
            colorSidebarHighlight = "#009688"

            colorActionbar = "#00b5c4"
            colorActionbarContent = "white"
            colorActionbarHighlight = "#069fac"

            colorTabletmenu = "#f3f3f3"
            colorTabletmenuContent = "#9d9d9d"
            colorTabletmenuHighlight = "#0079fe"

            colorBackground = (Qt.platform.os === "android" || Qt.platform.os === "ios") ? "white" : colorMaterialLightGrey
            colorForeground = (Qt.platform.os === "android" || Qt.platform.os === "ios") ? colorMaterialLightGrey : colorMaterialGrey

            colorPrimary = colorGreen
            colorSecondary = colorLightGreen
            colorSuccess = colorGreen
            colorWarning = colorOrange
            colorError = colorRed

            colorText = "#333333"
            colorSubText = "#666666"
            colorIcon = "#333333"
            colorSeparator = "#e8e8e8"
            colorLowContrast = "white"
            colorHighContrast = "black"

            colorDeviceWidget = "#fdfdfd"

            componentRadius = 4

            colorComponent = "#EAEAEA"
            colorComponentText = "black"
            colorComponentContent = "black"
            colorComponentBorder = "#E3E3E3"
            colorComponentDown = "#D0D0D0"
            colorComponentBackground = "#F1F1F1"

        } else if (themeIndex === ThemeEngine.THEME_RAIN) {

            colorGreen = "#8cd200"
            colorBlue = "#4cafe9"
            colorYellow = "#ffcf00"
            colorOrange = "#ffa635"
            colorRed = "#ff7657"

            themeStatusbar = Material.Dark
            colorStatusbar = "#1e3c77"

            colorHeader = "#325da9"
            colorHeaderHighlight = "#0f295c"
            colorHeaderContent = "white"

            colorSidebar = "#ffcf00"
            colorSidebarContent = "white"
            colorSidebarHighlight = colorNeutralNight

            colorActionbar = colorBlue
            colorActionbarContent = "white"
            colorActionbarHighlight = "#4c8ee9"

            colorTabletmenu = "#f3f3f3"
            colorTabletmenuContent = "#9d9d9d"
            colorTabletmenuHighlight = "#0079fe"

            colorBackground = "white"
            colorForeground = colorMaterialLightGrey

            colorPrimary = "#325da9"
            colorSecondary = "#446eb7"
            colorSuccess = colorGreen
            colorWarning = colorOrange
            colorError = colorRed

            colorText = "#474747"
            colorSubText = "#666666"
            colorIcon = "#474747"
            colorSeparator = colorMaterialDarkGrey
            colorLowContrast = "white"
            colorHighContrast = "#303030"

            colorDeviceWidget = "#fdfdfd"

            componentRadius = 6

            colorComponent = "#EFEFEF"
            colorComponentText = "black"
            colorComponentContent = "black"
            colorComponentBorder = "#E8E8E8"
            colorComponentDown = "#DDDDDD"
            colorComponentBackground = "#FAFAFA"

        } else if (themeIndex === ThemeEngine.THEME_DAY) {

            colorGreen = "#8cd200"
            colorBlue = "#4cafe9"
            colorYellow = "#ffcf00"
            colorOrange = "#ffa635"
            colorRed = "#ff7657"

            themeStatusbar = Material.Dark
            colorStatusbar = colorNeutralNight

            colorHeader = "#ffcf00"
            colorHeaderContent = "white"
            colorHeaderHighlight = colorNeutralNight

            colorSidebar = "#ffcf00"
            colorSidebarContent = "white"
            colorSidebarHighlight = colorNeutralNight

            colorActionbar = colorGreen
            colorActionbarContent = "white"
            colorActionbarHighlight = "#7ab800"

            colorTabletmenu = "#f3f3f3"
            colorTabletmenuContent = "#9d9d9d"
            colorTabletmenuHighlight = "#0079fe"

            colorBackground = "white"
            colorForeground = colorMaterialLightGrey

            colorPrimary = colorYellow
            colorSecondary = "#ffe800"
            colorSuccess = colorGreen
            colorWarning = colorOrange
            colorError = colorRed

            colorText = "#474747"
            colorSubText = "#666666"
            colorIcon = "#474747"
            colorSeparator = colorMaterialDarkGrey
            colorLowContrast = "white"
            colorHighContrast = "#303030"

            colorDeviceWidget = "#fdfdfd"

            componentRadius = 6

            colorComponent = "#EFEFEF"
            colorComponentText = "black"
            colorComponentContent = "black"
            colorComponentBorder = "#E8E8E8"
            colorComponentDown = "#DDDDDD"
            colorComponentBackground = "#FAFAFA"

        } else if (themeIndex === ThemeEngine.THEME_NIGHT) {

            colorGreen = "#58CF77"
            colorBlue = "#4dceeb"
            colorYellow = "#fcc632"
            colorOrange = "#ff8f35"
            colorRed = "#e8635a"

            themeStatusbar = Material.Dark
            colorStatusbar = "#725595"

            colorHeader = "#b16bee"
            colorHeaderContent = "white"
            colorHeaderHighlight = "#725595"

            colorSidebar = "#b16bee"
            colorSidebarContent = "white"
            colorSidebarHighlight = "#725595"

            colorActionbar = colorBlue
            colorActionbarContent = "white"
            colorActionbarHighlight = "#4dabeb"

            colorTabletmenu = "#292929"
            colorTabletmenuContent = "#808080"
            colorTabletmenuHighlight = "#bb86fc"

            colorBackground = "#313236"
            colorForeground = "#292929"

            colorPrimary = "#bb86fc"
            colorSecondary = "#b16bee"
            colorSuccess = colorGreen
            colorWarning = colorOrange
            colorError = colorRed

            colorText = "#EEE"
            colorSubText = "#AAA"
            colorIcon = "#EEE"
            colorSeparator = "#404040"
            colorLowContrast = "#111"
            colorHighContrast = "white"

            colorDeviceWidget = "#333"

            componentRadius = 4

            colorComponent = "#757575"
            colorComponentText = "#eee"
            colorComponentContent = "white"
            colorComponentBorder = "#777"
            colorComponentDown = "#595959"
            colorComponentBackground = "#292929"

        }



        if (themeIndex === ThemeEngine.THEME_LIGHT_AND_WARM) {

            themeStatusbar = Material.Dark
            colorStatusbar = "#BBB"

            colorHeader =               "#DADADA"
            colorHeaderContent =        "#353637"
            colorHeaderHighlight =      Qt.darker(colorHeader, 1.1)

            colorSidebar =              "#3A3A3A"
            colorSidebarContent =       "white"
            colorSidebarHighlight =     Qt.lighter(colorSidebar, 1.5)

            colorActionbar =            "#8CD200"
            colorActionbarContent =     "white"
            colorActionbarHighlight =   "#73AD00"

            colorTabletmenu =           "#f3f3f3"
            colorTabletmenuContent =    "#9d9d9d"
            colorTabletmenuHighlight =  "#0079fe"

            colorBackground =           "#F4F4F4"
            colorForeground =           "#E9E9E9"

            colorPrimary =              "#FFCA28"
            colorSecondary =            "#FFDD28"
            colorSuccess =              "#8CD200"
            colorWarning =              "#FFAC00"
            colorError =                "#E64B39"

            colorText =                 "#222"
            colorSubText =              "#555"
            colorIcon =                 "#333"
            colorSeparator =            "#E4E4E4"
            colorLowContrast =          "white"
            colorHighContrast =         "black"

            colorComponent =            "#EAEAEA"
            colorComponentText =        "black"
            colorComponentContent =     "black"
            colorComponentBorder =      "#DDD"
            colorComponentDown =        "#E6E6E6"
            colorComponentBackground =  "#FAFAFA"

            componentRadius = 6
            sidebarSelector = ""

        } else if (themeIndex === ThemeEngine.THEME_DARK_AND_SPOOKY) {

            themeStatusbar = Material.Dark
            colorStatusbar = "black"

            colorHeader =               "#282828"
            colorHeaderContent =        "#C0C0C0"
            colorHeaderHighlight =      Qt.lighter(colorHeader, 1.4)

            colorSidebar =              "#2E2E2E"
            colorSidebarContent =       "white"
            colorSidebarHighlight =     Qt.lighter(colorSidebar, 1.5)

            colorActionbar =            "#ff894a"
            colorActionbarContent =     "white"
            colorActionbarHighlight =   Qt.darker(colorActionbar, 1.3)

            colorTabletmenu =           "#f3f3f3"
            colorTabletmenuContent =    "#9d9d9d"
            colorTabletmenuHighlight =  "#FF9F1A"

            colorBackground =           "#3F3F3F"
            colorForeground =           "#555555"

            colorPrimary =              "#FF9F1A" // indigo: "#6C5ECD"
            colorSecondary =            "#FFB81A" // indigo2: "#9388E5"
            colorSuccess =              colorMaterialLightGreen
            colorWarning =              "#FE8F2D"
            colorError =                "#D33E39"

            colorText =                 "white"
            colorSubText =              "#AAA"
            colorIcon =                 "white"
            colorSeparator =            "#666" // darker: "#333" // lighter: "#666"
            colorLowContrast =          "black"
            colorHighContrast =         "white"

            colorComponent =            "#666"
            colorComponentText =        "white"
            colorComponentContent =     "white"
            colorComponentBorder =      "#6C6C6C"
            colorComponentDown =        "#7C7C7C"
            colorComponentBackground =  "#333"

            componentRadius = 3
            sidebarSelector = ""

        } else if (themeIndex === ThemeEngine.THEME_PLAIN_AND_BORING) {

            themeStatusbar = Material.Dark
            colorStatusbar = "#BBB"

            colorHeader =               "#CBCBCB"
            colorHeaderContent =        "#353637"
            colorHeaderHighlight =      Qt.darker(colorHeader, 1.1)

            colorSidebar =              "#2e2e2e"
            colorSidebarContent =       "white"
            colorSidebarHighlight =     Qt.darker(colorSidebar, 1.5)

            colorActionbar =            "#dadada"
            colorActionbarContent =     "#444"
            colorActionbarHighlight =   Qt.darker(colorActionbar, 1.1)

            colorTabletmenu =           "#f3f3f3"
            colorTabletmenuContent =    "#9d9d9d"
            colorTabletmenuHighlight =  "#0079fe"

            colorBackground =           "#EEEEEE"
            colorForeground =           "#E0E0E0"

            colorPrimary =              "#ffca28"
            colorSecondary =            "#ffdb28"
            colorSuccess =              colorMaterialLightGreen
            colorWarning =              "#ffac00"
            colorError =                "#dc4543"

            colorText =                 "#222222"
            colorSubText =              "#555555"
            colorIcon =                 "#333333"
            colorSeparator =            "#E4E4E4"
            colorLowContrast =          "white"
            colorHighContrast =         "black"

            colorComponent =            "#DBDBDB"
            colorComponentText =        "black"
            colorComponentContent =     "black"
            colorComponentBorder =      "#c1c1c1"
            colorComponentDown =        "#E4E4E4"
            colorComponentBackground =  "#FAFAFA"

            componentRadius = 4
            sidebarSelector = "arrow"

        } else if (themeIndex === ThemeEngine.THEME_BLOOD_AND_TEARS) {

            themeStatusbar = Material.Dark
            colorStatusbar = "black"

            colorHeader =               "#141414"
            colorHeaderContent =        "white"
            colorHeaderHighlight =      "#222"

            colorSidebar =              "#181818"
            colorSidebarContent =       "#DDD"
            colorSidebarHighlight =     "#333"

            colorActionbar =            "#009EE2"
            colorActionbarContent =     "white"
            colorActionbarHighlight =   "#0089C3"

            colorTabletmenu =           "#f3f3f3"
            colorTabletmenuContent =    "#9d9d9d"
            colorTabletmenuHighlight =  "#009EE2"

            colorBackground =           "#222"
            colorForeground =           "#333"

            colorPrimary =              "#009EE2"
            colorSecondary =            "#00BEE2"
            colorSuccess =              colorMaterialLightGreen
            colorWarning =              "#FFDB63"
            colorError =                "#FA6871"

            colorText =                 "#D2D2D2"
            colorSubText =              "#A3A3A3"
            colorIcon =                 "#A0A0A0"
            colorSeparator =            "#666"
            colorLowContrast =          "black"
            colorHighContrast =         "white"

            colorComponent =            "white"
            colorComponentText =        "black"
            colorComponentContent =     "black"
            colorComponentBorder =      "#E4E4E4"
            colorComponentDown =        "#DDD"
            colorComponentBackground =  "white"

            componentRadius = 2
            sidebarSelector = "bar"

        } else if (themeIndex === ThemeEngine.THEME_MIGHTY_KITTENS) {

            themeStatusbar = Material.Dark
            colorStatusbar = "#944197"

            colorHeader =               "#FFB4DC"
            colorHeaderContent =        "#944197"
            colorHeaderHighlight =      Qt.darker(colorHeader, 1.1)

            colorSidebar =              "#E31D8D"
            colorSidebarContent =       "#FFAED6"
            colorSidebarHighlight =     Qt.darker(colorSidebar, 1.15)

            colorActionbar =            "#FFE400"
            colorActionbarContent =     "white"
            colorActionbarHighlight =   Qt.darker(colorActionbar, 1.1)

            colorTabletmenu =           "white"
            colorTabletmenuContent =    "#FFAAD4"
            colorTabletmenuHighlight =  "#944197"

            colorBackground =           "white"
            colorForeground =           "#FFDDEE"

            colorPrimary =              "#FFE400"
            colorSecondary =            "#FFF600"
            colorSuccess =              colorMaterialLightGreen
            colorWarning =              "#944197"
            colorError =                "#FA6871"

            colorText =                 "#932A97"
            colorSubText =              "#B746BB"
            colorIcon =                 "#FFDD48"
            colorSeparator =            "#FFDCED"
            colorLowContrast =          "white"
            colorHighContrast =         "#944197"

            colorComponent =            "#FF87D0"
            colorComponentText =        "#944197"
            colorComponentContent =     "white"
            colorComponentBorder =      "#F592C1"
            colorComponentDown =        "#FF9ED9"
            colorComponentBackground =  "#FFF4F9"

            componentRadius = (componentHeight / 2)
            sidebarSelector = ""
        }


        // This will emit the signal 'onCurrentThemeChanged'
        currentTheme = themeIndex
    }
}
