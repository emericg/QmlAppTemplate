import QtQuick
import ThemeEngine

ButtonImpl {
    property color color: Theme.colorPrimary

    colorBackground: "transparent"
    colorHighlight: color
    colorBorder: color
    colorText: color
    flat: true
}
