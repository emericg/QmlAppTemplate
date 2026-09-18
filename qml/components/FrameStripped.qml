import QtQuick
import QtQuick.Effects
import QtQuick.Controls.impl
import QtQuick.Templates as T

import ComponentLibrary

T.Frame {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            contentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             contentHeight + topPadding + bottomPadding)

    anchors.left: parent.left
    anchors.right: parent.right

    padding: 0

    property int radius: singleColumn ? 0 : 12

    background: Item {
        implicitWidth: 512
        implicitHeight: 128

        ////

        IconSvg {
            anchors.fill: parent
            source: "qrc:/assets/gfx/pictures/stripes_small.png"
            opacity: 0.040
            fillMode: Image.Tile
            color: Theme.colorGrey
        }

        ////

        layer.enabled: control.radius
        layer.effect: MultiEffect { // mask
            maskEnabled: true
            maskInverted: false
            maskThresholdMin: 0.5
            maskSpreadAtMin: 1.0
            maskSpreadAtMax: 0.0
            maskSource: ShaderEffectSource {
                sourceItem: Rectangle {
                    x: 0
                    y: 0
                    width: control.width
                    height: control.height
                    radius: control.radius
                }
            }
        }

        ////
    }
}
