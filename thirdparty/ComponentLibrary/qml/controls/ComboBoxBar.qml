import QtQuick
import QtQuick.Templates as T

import ComponentLibrary

/*!
 * \brief A ComboBoxThemed filling a single column layout, side to side.
 *
 * Taller, without radius nor side borders, separated from the content by a line above and below.
 * Meant to be anchored to the screen edges, its texts aligned with the screen margins.
 *
 * \property edge The screen edge the bar is along: Qt.TopEdge (default), opening its list below it,
 *           or Qt.BottomEdge, opening it above it. Any other edge is handled as Qt.TopEdge.
 */
ComboBoxThemed {
    id: control

    leftPadding: Theme.componentMarginXL
    rightPadding: Theme.componentMarginXL

    radius: 0

    colorBackground: control.down ? Theme.colorComponentDown : Qt.lighter(Theme.colorTabletmenu, Theme.isLight ? 1.02 : 1.1)
    colorBackgroundBorder: Theme.colorSeparator

    property int edge: Qt.TopEdge
    indicator.rotation: (popup.visible === (edge !== Qt.BottomEdge)) ? 180 : 0

    ////////////////

    background: Rectangle {
        implicitWidth: 200
        implicitHeight: Theme.componentHeightXL

        opacity: control.enabled ? 1 : 0.66
        color: control.colorBackground

        Rectangle { // top separator
            anchors.top: parent.top
            width: parent.width
            height: 1
            color: control.colorBackgroundBorder
        }
        Rectangle { // bottom separator
            anchors.bottom: parent.bottom
            width: parent.width
            height: 1
            color: control.colorBackgroundBorder
        }
    }

    ////////////////

    popup: T.Popup {
        y: (control.edge !== Qt.BottomEdge) ? control.height : -height
        width: control.width
        height: contentItem.implicitHeight ? contentItem.implicitHeight + 2 : 0
        padding: 1

        topMargin: Math.max(Theme.screenPaddingStatusbar, Theme.screenPaddingTop)
        bottomMargin: Math.max(Theme.screenPaddingNavbar, Theme.screenPaddingBottom)

        contentItem: ListView {
            implicitHeight: contentHeight
            clip: true
            currentIndex: control.highlightedIndex
            model: control.popup.visible ? control.delegateModel : null
        }

        background: Rectangle {
            color: Theme.colorComponentBackground

            Rectangle { // separator, on the side away from the control
                y: (control.edge !== Qt.BottomEdge) ? (parent.height - height) : 0
                width: parent.width
                height: 1
                color: control.colorBackgroundBorder
            }
        }
    }

    ////////////////
}
