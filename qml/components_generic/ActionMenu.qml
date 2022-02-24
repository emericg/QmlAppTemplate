import QtQuick 2.15
import QtQuick.Controls 2.15
import Qt.labs.qmlmodels 1.0

import ThemeEngine 1.0

Popup {
    id: actionMenu
    width: 220

    padding: 0
    margins: 0

    modal: true
    focus: isMobile
    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
    parent: Overlay.overlay
    locale: Qt.locale()

    signal menuSelected(var index)

    property var model: null

    ////////////////////////////////////////////////////////////////////////////

    background: Rectangle {
        color: Theme.colorBackground
        radius: Theme.componentRadius
        border.color: Theme.colorSeparator
        border.width: Theme.componentBorderWidth
    }

    ////////////////////////////////////////////////////////////////////////////

    contentItem: Column {
        padding: Theme.componentBorderWidth
        spacing: 4

        DelegateChooser {
            id: chooser
            role: "t"
            DelegateChoice {
                roleValue: "sep"
                Rectangle {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    height: Theme.componentBorderWidth
                    color: Theme.colorSeparator
                }
            }
            DelegateChoice {
                roleValue: "itm"
                ActionMenuItem {
                    index: idx
                    text: txt
                    source: src
                    onClicked: {
                        actionMenu.menuSelected(idx)
                        actionMenu.close()
                    }
                }
            }
        }

        Repeater {
            model: actionMenu.model
            delegate: chooser
        }
    }

    ////////////////////////////////////////////////////////////////////////////
}
