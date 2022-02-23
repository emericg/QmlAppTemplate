import QtQuick 2.15

//import QtGraphicalEffects 1.15 // Qt5
import Qt5Compat.GraphicalEffects // Qt6

import ThemeEngine 1.0
import "qrc:/js/UtilsNumber.js" as UtilsNumber

Item {
    id: control
    implicitWidth: Theme.componentHeight
    implicitHeight: Theme.componentHeight

    width: compact ? height : (contentRow.width + 12 + ((source.length && !text) ? 0 : 16))

    // actions
    signal clicked()
    signal pressAndHold()

    // states
    property bool hovered: false
    property bool pressed: false

    // settings
    property bool compact: true
    property string text
    property url source
    property int sourceSize: UtilsNumber.alignTo(height * 0.666, 2)

    // colors
    property string iconColor: Theme.colorIcon
    property string backgroundColor: Theme.colorComponent

    // animation
    property string animation // available: rotate, fade
    property bool animationRunning: false

    // hover animation
    property bool hoverAnimation: (isDesktop && !compact)

    // tooltip
    property string tooltipText
    property string tooltipPosition: "bottom"

    ////////////////////////////////////////////////////////////////////////////

    Rectangle {
        id: background
        anchors.fill: control

        radius: control.compact ? (control.height / 2) : Theme.componentRadius
        color: control.backgroundColor
        opacity: (!control.compact || control.hovered) ? 1 : 0
        Behavior on opacity { NumberAnimation { duration: 333 } }

        MouseArea {
            id: mmmm
            anchors.fill: parent

            onClicked: control.clicked()
            onPressAndHold: control.pressAndHold()

            onPressed: {
                mouseBackground.width = background.width*2
            }

            hoverEnabled: isDesktop
            onEntered: {
                control.hovered = true
                if (control.hoverAnimation) {
                    mouseBackground.width = 80
                    mouseBackground.opacity = 0.16
                }
            }
            onExited: {
                control.hovered = false
                if (control.hoverAnimation) {
                    mouseBackground.width = 0
                    mouseBackground.opacity = 0
                }
            }
            onCanceled: {
                control.hovered = false
                if (control.hoverAnimation) {
                    mouseBackground.width = 0
                    mouseBackground.opacity = 0
                }
            }

            Rectangle {
                id: mouseBackground
                width: 0; height: width; radius: width;
                x: mmmm.mouseX - (mouseBackground.width / 2)
                y: mmmm.mouseY - (mouseBackground.width / 2)

                color: "#fff"
                opacity: 0
                Behavior on opacity { NumberAnimation { duration: 133 } }
                Behavior on width { NumberAnimation { duration: 133 } }
            }
        }

        layer.enabled: control.hoverAnimation
        layer.effect: OpacityMask {
            maskSource: Rectangle {
                x: background.x
                y: background.y
                width: background.width
                height: background.height
                radius: background.radius
            }
        }
    }

    ////////////////////////////////////////////////////////////////////////////

    Row {
        id: contentRow
        anchors.centerIn: control
        spacing: 8

        IconSvg {
            id: contentImage
            width: control.sourceSize
            height: control.sourceSize
            anchors.verticalCenter: parent.verticalCenter

            opacity: enabled ? 1.0 : 0.4
            Behavior on opacity { NumberAnimation { duration: 333 } }

            source: control.source
            color: control.iconColor

            SequentialAnimation on opacity {
                running: (control.animation === "fade" && control.animationRunning)
                alwaysRunToEnd: true
                loops: Animation.Infinite

                PropertyAnimation { to: 0.5; duration: 666; }
                PropertyAnimation { to: 1; duration: 666; }
            }
            NumberAnimation on rotation {
                running: (control.animation === "rotate" && control.animationRunning)
                alwaysRunToEnd: true
                loops: Animation.Infinite

                duration: 1500
                from: 0
                to: 360
                easing.type: Easing.Linear
            }
        }

        Text {
            id: contentText
            anchors.verticalCenter: parent.verticalCenter
            visible: !control.compact

            text: control.text
            textFormat: Text.PlainText
            color: control.iconColor
            font.pixelSize: Theme.fontSizeComponent
            font.bold: true
            elide: Text.ElideRight
        }
    }

    ////////////////////////////////////////////////////////////////////////////

    Item {
        id: tooltip
        anchors.fill: background

        visible: control.tooltipText
        property bool tooltipVisible: (control.compact && control.hovered)
        onTooltipVisibleChanged: ttT.checkPosition()

        opacity: (tooltipVisible) ? 1 : 0
        Behavior on opacity { OpacityAnimator { duration: 133 } }

        state: control.tooltipPosition
        states: [
            State {
                name: "top"
                AnchorChanges {
                    target: ttA
                    anchors.bottom: parent.top
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                AnchorChanges {
                    target: ttT
                    anchors.bottom: parent.top
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            },
            State {
                name: "topLeft"
                AnchorChanges {
                    target: ttA
                    anchors.bottom: parent.top
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                AnchorChanges {
                    target: ttT
                    anchors.top: parent.bottom
                    anchors.left: parent.left
                }
            },
            State {
                name: "topRight"
                AnchorChanges {
                    target: ttA
                    anchors.bottom: parent.top
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                AnchorChanges {
                    target: ttT
                    anchors.top: parent.bottom
                    anchors.right: parent.right
                }
            },
            State {
                name: "bottom"
                AnchorChanges {
                    target: ttA
                    anchors.top: parent.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                AnchorChanges {
                    target: ttT
                    anchors.top: parent.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            },
            State {
                name: "bottomLeft"
                AnchorChanges {
                    target: ttA
                    anchors.top: parent.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                AnchorChanges {
                    target: ttT
                    anchors.top: parent.bottom
                    anchors.left: parent.left
                }
            },
            State {
                name: "bottomRight"
                AnchorChanges {
                    target: ttA
                    anchors.top: parent.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                AnchorChanges {
                    target: ttT
                    anchors.top: parent.bottom
                    anchors.right: parent.right
                }
            },
            State {
                name: "left"
                AnchorChanges {
                    target: ttA
                    anchors.right: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                }
                AnchorChanges {
                    target: ttT
                    anchors.right: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                }
            },
            State {
                name: "right"
                AnchorChanges {
                    target: ttA
                    anchors.left: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                }
                AnchorChanges {
                    target: ttT
                    anchors.left: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
        ]

        Rectangle {
            id: ttA
            anchors.margins: 4
            width: 12; height: 12; rotation: 45
            color: control.backgroundColor
        }
        Rectangle {
            id: ttBg
            anchors.fill: ttT
            anchors.margins: -6
            radius: 4
            color: control.backgroundColor
        }
        Text {
            id: ttT
            anchors.topMargin: 16
            anchors.leftMargin: (tooltip.state === "topLeft" || tooltip.state === "bottomLeft") ? 8 : 16
            anchors.rightMargin: (tooltip.state === "topRight" || tooltip.state === "bottomRight") ? 8 : 16
            anchors.bottomMargin: 16

            text: control.tooltipText
            textFormat: Text.PlainText
            color: control.iconColor

            function checkPosition() {
                if (!control.tooltipText) return
                if (!control.hovered) return

                var obj = mapToItem(appContent, x, y)
                var thestart = obj.x
                var theend = obj.x + 12*2 + ttT.width

                if (tooltip.state === "top") {
                    if (thestart < 0) {
                        tooltip.state = "topLeft"
                    } else if (theend > appContent.width) {
                        tooltip.state = "topRight"
                    } else {
                        tooltip.state = "top"
                    }
                } else if (tooltip.state === "bottom") {
                    if (thestart < 0) {
                        tooltip.state = "bottomLeft"
                    } else if (theend > appContent.width) {
                        tooltip.state = "bottomRight"
                    } else {
                        tooltip.state = "bottom"
                    }
                }
            }
        }
    }
}
