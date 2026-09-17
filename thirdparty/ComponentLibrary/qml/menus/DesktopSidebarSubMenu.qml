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
        delegate: DesktopSidebarMenu {
            anchors.left: parent.left
            anchors.leftMargin: 12
            height: Theme.componentHeight

            text: modelData.text
            font.bold: checked
            //visible: sidebarSubMenu.checked

            source: checked ? "qrc:/ComponentLibraryAssets/icons/circle-fill.svg"
                            : "qrc:/ComponentLibraryAssets/icons/circle.svg"
            sourceSize: 12

            checked: sidebarSubMenu.checked && sidebarSubMenu.selected === index
            onClicked: {
                sidebarSubMenu.selected = index
                modelData.onClicked()
            }
        }
    }

    ////////
}
