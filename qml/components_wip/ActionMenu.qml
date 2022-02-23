import QtQuick 2.15

import ThemeEngine 1.0

Rectangle {
    id: actionMenu
    width: 220
    height: menuHolder.height
    visible: isOpen
    focus: isOpen && !isMobile

    color: Theme.colorBackground
    radius: Theme.componentRadius
    border.color: Theme.colorSeparator
    border.width: Theme.componentBorderWidth

    signal menuSelected(var index)
    property int menuWidth: 0
    property bool isOpen: false

    function open() { isOpen = true; updateSize(); }
    function close() { isOpen = false; }
    function openClose() { isOpen = !isOpen; updateSize(); }

    function updateSize() {
        if (isOpen) {
            menuWidth = 0
            if (actionUpdate.visible && menuWidth < actionUpdate.contentWidth) menuWidth = actionUpdate.contentWidth
            if (actionHistoryRefresh.visible && menuWidth < actionHistoryRefresh.contentWidth) menuWidth = actionHistoryRefresh.contentWidth
            if (actionHistoryClear.visible && menuWidth < actionHistoryClear.contentWidth) menuWidth = actionHistoryClear.contentWidth
            if (actionLed.visible && menuWidth < actionLed.contentWidth) menuWidth = actionLed.contentWidth
            menuWidth += 96
            actionMenu.width = menuWidth
        }
    }

    ////////////////////////////////////////////////////////////////////////////

    Column {
        id: menuHolder
        width: parent.width
        height: children.height * children.length

        topPadding: 8
        bottomPadding: 8
        spacing: 4

        ActionMenuItem {
            id: actionUpdate
            index: 0
            button_text: qsTr("Update data")
            button_source: "qrc:/assets/icons_material/baseline-refresh-24px.svg"
            onButtonClicked: {
                menuSelected(index)
                close()
            }
        }

        ////////

        Rectangle {
            width: parent.width; height: 1;
            color: Theme.colorSeparator
        }

        ActionMenuItem {
            id: actionHistoryRefresh
            index: 1
            button_text: qsTr("Update history")
            button_source: "qrc:/assets/icons_material/duotone-date_range-24px.svg"
            onButtonClicked: {
                menuSelected(index)
                close()
            }
        }

        ActionMenuItem {
            id: actionHistoryClear
            index: 2
            button_text: qsTr("Clear history")
            button_source: "qrc:/assets/icons_material/duotone-date_clear-24px.svg"
            onButtonClicked: {
                menuSelected(index)
                close()
            }
        }

        ////////

        Rectangle {
            width: parent.width; height: 1;
            color: Theme.colorSeparator
        }

        ActionMenuItem {
            id: actionLed
            index: 4
            button_text: qsTr("Blink LED")
            button_source: "qrc:/assets/icons_material/duotone-emoji_objects-24px.svg"
            onButtonClicked: {
                menuSelected(index)
                close()
            }
        }
    }
}
