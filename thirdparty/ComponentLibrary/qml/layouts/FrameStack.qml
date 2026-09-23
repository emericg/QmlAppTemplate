pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Templates as T

import ComponentLibrary

/*!
 * \brief A tray that stacks its children vertically and draws a card behind each of them.
 *
 * Children are laid out in an internal Column, and should bind their width to their parent.
 * In separated mode each child gets its own rounded card, spaced apart.
 * In joined mode the children share a single card, split by thin separators.
 * FrameStackItem is a convenient child type, but any item can be used.
 */
T.Frame {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            contentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             contentHeight + topPadding + bottomPadding)

    padding: 4
    spacing: 4

    property bool joined: false
    property int radius: 12
    readonly property int innerRadius: Math.max(0, control.radius - control.padding)

    // colors
    property color colorTray: Theme.colorForeground
    property color colorTrayBorder: Theme.colorSeparator
    property color colorCard: Theme.colorComponentBackground
    property color colorCardBorder: Theme.colorComponentBorder
    property color colorSeparator: Theme.colorComponentBorder

    default property alias stackData: column.data

    ////////////////

    background: Rectangle {
        radius: control.radius
        color: control.colorTray
        border.width: 1
        border.color: control.colorTrayBorder
    }

    ////////////////

    contentItem: Item {
        implicitWidth: column.implicitWidth
        implicitHeight: column.implicitHeight

        Rectangle { // joined card
            width: column.width
            height: column.height
            visible: control.joined

            radius: control.innerRadius
            color: control.colorCard
            border.width: 1
            border.color: control.colorCardBorder
        }

        Repeater { // per child decorations
            model: column.children

            delegate: Item {
                id: deco

                required property Item modelData

                readonly property bool shown: modelData.visible &&
                                              modelData.width > 0 && modelData.height > 0

                y: modelData.y
                width: column.width
                height: modelData.height
                visible: shown

                Rectangle { // separated card
                    anchors.fill: parent
                    visible: !control.joined

                    radius: control.innerRadius
                    color: control.colorCard
                    border.width: 1
                    border.color: control.colorCardBorder
                }

                Rectangle { // joined separator
                    width: parent.width
                    height: 1
                    visible: control.joined && deco.modelData.y > 0
                    color: control.colorSeparator
                }
            }
        }

        Column {
            id: column
            width: parent.width
            spacing: control.joined ? 0 : control.spacing
        }
    }

    ////////////////
}
