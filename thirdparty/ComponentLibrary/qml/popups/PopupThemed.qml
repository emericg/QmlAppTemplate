import QtQuick
import QtQuick.Effects
import QtQuick.Controls

import ComponentLibrary

Popup {
    id: popupThemed

    x: Theme.singleColumn ? 0 : (Theme.appWidth / 2) - (width / 2)
    y: Theme.singleColumn ? (Theme.appHeight - height)
                          : ((Theme.appHeight / 2) - (height / 2))

    width: {
        if (Theme.singleColumn) return Theme.appWidth
        if (Theme.isTablet && Theme.screenOrientation === Qt.LandscapeOrientation) return 512
        return 720
    }
    padding: 0
    margins: 0

    dim: true
    modal: true
    focus: true
    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

    parent: Overlay.overlay

    ////////////////////////////////////////////////////////////////////////////

    enter: Transition { NumberAnimation { property: "opacity"; from: 0.5; to: 1.0; duration: Theme.animationFastSpeed; } }
    //exit: Transition { NumberAnimation { property: "opacity"; from: 1.0; to: 0.0; duration: Theme.animationMediumSpeed; } }

    Overlay.modal: Item {
        Rectangle {
            anchors.fill: parent
            anchors.margins: Theme.windowBorders
            radius: Theme.windowCornersRadius
            color: "#000000"
            opacity: Theme.isLight ? 0.24 : 0.48
        }
    }

    ////////////////////////////////////////////////////////////////////////////

    background: Rectangle {
        color: Theme.colorBackground
        border.color: Theme.colorSeparator
        border.width: Theme.singleColumn ? 0 : Theme.componentBorderWidth
        radius: Theme.singleColumn ? 0 : Theme.componentRadius

        ////

        Rectangle { // top separator (singleColumn)
            anchors.left: parent.left
            anchors.right: parent.right
            height: Theme.componentBorderWidth
            visible: Theme.singleColumn
            color: Theme.colorSeparator
        }

        layer.enabled: !Theme.singleColumn
        layer.effect: MultiEffect { // shadow
            autoPaddingEnabled: true
            blurMax: 64
            shadowEnabled: true
            shadowColor: Theme.isLight ? "#aa000000" : "#cc000000"
        }

        ////
    }

    ////////////////////////////////////////////////////////////////////////////
}
