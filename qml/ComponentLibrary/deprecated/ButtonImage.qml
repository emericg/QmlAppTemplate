import QtQuick
import QtQuick.Effects
import QtQuick.Controls.impl
import QtQuick.Templates as T

import ThemeEngine

T.Button {
    id: control

    implicitWidth: Theme.componentHeight
    implicitHeight: Theme.componentHeight

    focusPolicy: Qt.NoFocus

    // image
    property url source
    property int sourceSize: 32

    // settings
    property string hoverMode: "off" // available: off, circle, glow
    property string highlightMode: "off" // available: off

    // colors
    property color highlightColor: Theme.colorPrimary

    ////////////////

    background: Item {
        implicitWidth: Theme.componentHeight
        implicitHeight: Theme.componentHeight

        opacity: control.enabled ? 1 : 0.66

        layer.enabled: true
        layer.effect: MultiEffect {
            autoPaddingEnabled: true
            blurEnabled: true
            blur: 1.0
        }

        Rectangle {
            anchors.centerIn: parent
            width: Math.round(control.sourceSize * (control.pressed ? 0.9 : 1))
            height: Math.round(control.sourceSize * (control.pressed ? 0.9 : 1))

            //visible: (control.hoverMode === "circle")

            radius: control.width
            color: control.highlightColor

            opacity: control.hovered ? 0.33 : 0
            Behavior on opacity { OpacityAnimator { duration: 333 } }
        }
    }

    ////////////////

    contentItem: Item {
        Image {
            id: contentImage
            anchors.centerIn: parent

            width: Math.round(control.sourceSize * (control.pressed ? 0.9 : 1))
            height: Math.round(control.sourceSize * (control.pressed ? 0.9 : 1))

            source: control.source
            sourceSize: Qt.size(control.sourceSize, control.sourceSize)
            fillMode: Image.PreserveAspectFit

            opacity: control.enabled ? 1 : 0.66
            Behavior on opacity { OpacityAnimator { duration: 333 } }
        }
    }

    ////////////////
}
