import QtQuick

import ThemeEngine

Item {
    id: selectorMenu
    implicitWidth: 128
    implicitHeight: 32

    width: contentRow.width

    opacity: enabled ? 1 : 0.66

    property var model: null

    // colors
    property color colorBackground: Theme.colorComponentBackground

    // states
    property int currentSelection: 1
    signal menuSelected(var index)

    ////////////////

    Rectangle { // background
        anchors.fill: parent

        radius: height
        color: selectorMenu.colorBackground

        border.width: 2
        border.color: Theme.colorComponentDown
    }

    ////////////////

    Row {
        id: contentRow
        height: parent.height
        spacing: -4

        Repeater {
            model: selectorMenu.model
            delegate: SelectorMenuColorfulItem {
                height: parent.height
                highlighted: (selectorMenu.currentSelection === idx)
                index: idx ?? 0
                text: txt ?? ""
                source: src ?? ""
                sourceSize: sz ?? 32
                onClicked: selectorMenu.menuSelected(idx)
            }
        }
    }

    ////////////////
}
