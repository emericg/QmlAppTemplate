import QtQuick
import QtQuick.Layouts

import ComponentLibrary

Column {
    id: sidebarSubMenu

    anchors.left: parent.left
    anchors.right: parent.right
    spacing: 8

    //height: checked ? cccccc.height : Theme.componentHeight
    //Behavior on height { NumberAnimation { duration: 333 } }

    property string category
    property string text: "menu"
    property string source: "qrc:/assets/icons/material-symbols/menu.svg"

    property bool checked: false
    property int selected: 0

    signal clicked()

    /////////

    property var submenus

    ////////

    DesktopSidebarMenu {
        text: sidebarSubMenu.text
        checked: sidebarSubMenu.checked
        onClicked: sidebarSubMenu.clicked()
    }

    ////////

    Repeater {
        model: sidebarSubMenu.submenus
        delegate: DesktopSidebarMenu {
            height: Theme.componentHeight

            text: modelData.text
            font.bold: checked
            //visible: sidebarSubMenu.checked

            source: "qrc:/assets/icons/material-symbols/arrow_right.svg"
            sourceSize: 20

            checked: sidebarSubMenu.checked && sidebarSubMenu.selected === index
            onClicked: {
                sidebarSubMenu.selected = index
                modelData.onClicked()
            }
        }
    }

    ////////
}
