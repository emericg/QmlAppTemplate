import QtQuick
import QtQuick.Layouts

import ComponentLibrary

Column {
    id: sidebarSubMenu

    anchors.left: parent.left
    anchors.right: parent.right
    spacing: 8

    property string category
    property string text: "menu"
    property string source: "qrc:/assets/icons/material-symbols/menu.svg"

    property bool checked: false

    signal clicked()

    /////////

    property var submenu

    ////////

    DesktopSidebarMenu {
        text: sidebarSubMenu.text
        checked: sidebarSubMenu.checked
        onClicked: sidebarSubMenu.clicked()
    }

    ////////

    Repeater {
        model: sidebarSubMenu.submenu
        delegate: DesktopSidebarMenu {
            height: Theme.componentHeight

            text: modelData.text
            font.bold: checked

            source: "qrc:/assets/icons/material-symbols/arrow_right.svg"
            sourceSize: 20

            checked: false
            onClicked: modelData.clicked()
        }
    }

    ////////
}
