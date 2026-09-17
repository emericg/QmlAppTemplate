import QtQuick
import QtQuick.Effects

import ComponentLibrary

Item {
    id: hazardBand

    property color colorBackground: "#1a1a1a"
    property color colorStripe: "#f2c21a"
    property int radius: 0

    property real stripeAngle: 45
    property real stripeWidth: 40
    property real stripeSpacing: 40

    property bool antialiasing: false

    ////////

    readonly property real pitch: hazardBand.stripeWidth + hazardBand.stripeSpacing

    readonly property real stripeThickness: Math.max(1, hazardBand.stripeWidth * Math.cos(Math.min(Math.abs(hazardBand.stripeAngle), 80) * Math.PI / 180))

    readonly property real overhang: hazardBand.height * 2

    readonly property int stripeCount: Math.ceil((hazardBand.width + 2 * hazardBand.overhang) / hazardBand.pitch) + 1

    property real stripeOffset: 0

    ////////

    Rectangle {
        anchors.fill: parent

        color: hazardBand.colorBackground
        radius: control.radius

        ////

        Repeater {
            model: hazardBand.stripeCount

            Rectangle {
                x: index * hazardBand.pitch - hazardBand.overhang + hazardBand.stripeOffset
                y: (hazardBand.height - height) / 2

                width: hazardBand.stripeThickness
                height: hazardBand.height * 3

                color: hazardBand.colorStripe
                rotation: hazardBand.stripeAngle
                antialiasing: false
            }
        }

        ////

        clip: !control.radius

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

    ////////
}
/*
HazardBand {
    id: control

    anchors.fill: parent
    z: -1

    property int radius: Theme.singleColumn ? 0 : 12

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
*/
