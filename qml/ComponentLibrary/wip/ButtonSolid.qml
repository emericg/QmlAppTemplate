import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import QtQuick.Controls.impl
import QtQuick.Templates as T

import ThemeEngine
import "qrc:/utils/UtilsNumber.js" as UtilsNumber

T.Button {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            rowrowrow.width + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    leftPadding: 12
    rightPadding: 12
    spacing: 6

    font.pixelSize: Theme.componentFontSize
    font.bold: false

    focusPolicy: Qt.NoFocus

    // settings
    flat: false
    property int alignment: Qt.AlignCenter // Qt.AlignLeft // Qt.AlignRight
    property int layoutDirection: Qt.LeftToRight // Qt.RightToLeft

    // icon
    property url source
    property int sourceSize: UtilsNumber.alignTo(height * 0.5, 2)

    // colors
    property color colorBackground: Theme.colorPrimary
    property color colorHighlight: "white"
    property color colorText: "white"

    // animation
    property string animation // available: rotate, fade, both
    property bool animationRunning: false

    ////////////////

    background: Item {
        implicitWidth: 80
        implicitHeight: Theme.componentHeight

        Rectangle {
            anchors.fill: parent
            radius: Theme.componentRadius
            color: control.colorBackground
            border.width: control.flat ? 0 : Theme.componentBorderWidth
            border.color: Qt.darker(color, 1.02)

            layer.enabled: !control.flat
            layer.effect: MultiEffect {
                autoPaddingEnabled: true
                shadowEnabled: true
                shadowColor: "#33000000"
            }
        }

        RippleThemed {
            width: parent.width
            height: parent.height

            anchor: control
            pressed: control.pressed
            active: control.enabled && (control.down || control.visualFocus)
            color: Qt.rgba(control.colorHighlight.r, control.colorHighlight.g, control.colorHighlight.b, 0.1)

            layer.enabled: true
            layer.effect: MultiEffect {
                maskEnabled: true
                maskInverted: false
                maskThresholdMin: 0.5
                maskSpreadAtMin: 1.0
                maskSpreadAtMax: 0.0
                maskSource: ShaderEffectSource {
                    sourceItem: Rectangle {
                        x: background.x
                        y: background.y
                        width: background.width
                        height: background.height
                        radius: Theme.componentRadius
                    }
                }
            }
        }
    }

    ////////////////

    contentItem: Item {
        RowLayout {
            id: rowrowrow
            anchors.right: (control.alignment === Qt.AlignRight) ? parent.right : undefined
            anchors.horizontalCenter: (control.alignment === Qt.AlignCenter) ? parent.horizontalCenter : undefined
            anchors.verticalCenter: parent.verticalCenter

            spacing: control.spacing
            layoutDirection: {
                if (control.alignment === Qt.AlignRight) return Qt.RightToLeft
                return Qt.LeftToRight
            }

            IconSvg {
                Layout.maximumWidth: control.sourceSize
                Layout.maximumHeight: control.sourceSize
                Layout.alignment: Qt.AlignVCenter

                color: control.colorText
                opacity: control.enabled ? 1 : 0.66

                visible: control.source.toString().length
                source: control.source

                SequentialAnimation on opacity {
                    running: (control.animationRunning &&
                              (control.animation === "fade" || control.animation === "both"))
                    alwaysRunToEnd: true
                    loops: Animation.Infinite

                    PropertyAnimation { to: 0.5; duration: 666; }
                    PropertyAnimation { to: 1; duration: 666; }
                }
                NumberAnimation on rotation {
                    running: (control.animationRunning &&
                              (control.animation === "rotate" || control.animation === "both"))
                    alwaysRunToEnd: true
                    loops: Animation.Infinite

                    duration: 1500
                    from: 0
                    to: 360
                    easing.type: Easing.Linear
                }
            }

            Text {
                Layout.alignment: Qt.AlignVCenter

                color: control.colorText
                opacity: control.enabled ? 1 : 0.66

                visible: control.text
                text: control.text
                textFormat: Text.PlainText

                font: control.font
                elide: Text.ElideMiddle
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
            }
        }
    }

    ////////////////
}
