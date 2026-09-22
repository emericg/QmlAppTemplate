import QtQuick

import ComponentLibrary

Column {
    id: sidebarSubMenu

    anchors.left: parent.left
    anchors.right: parent.right
    spacing: 8

    //height: checked ? cccccc.height : Theme.componentHeight
    //Behavior on height { NumberAnimation { duration: Theme.animationSlowSpeed } }

    property string category
    property string text: "submenu"
    property url source: "qrc:/ComponentLibraryAssets/icons/menu.svg"

    property bool checked: false
    property int selected: 0

    signal clicked()

    /////////

    property var submenus

    ////////

    DesktopSidebarMenu {
        text: sidebarSubMenu.text
        source: sidebarSubMenu.source
        checked: sidebarSubMenu.checked
        onClicked: sidebarSubMenu.clicked()
    }

    ////////

    Repeater {
        model: sidebarSubMenu.submenus
        delegate: DesktopSidebarItem_button {
            text: modelData.text

            checked: sidebarSubMenu.checked && sidebarSubMenu.selected === index
            onClicked: {
                sidebarSubMenu.selected = index
                modelData.onClicked()
            }
        }
    }

    ////////
}
