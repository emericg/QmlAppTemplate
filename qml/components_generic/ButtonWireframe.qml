import QtQuick 2.15
import QtQuick.Controls.impl 2.15
import QtQuick.Templates 2.15 as T

//import QtGraphicalEffects 1.15 // Qt5
import Qt5Compat.GraphicalEffects // Qt6

import ThemeEngine 1.0

T.Button {
    id: control
    implicitWidth: contentTextInvisible.contentWidth + 24
    implicitHeight: Theme.componentHeight

    font.pixelSize: Theme.fontSizeComponent
    font.bold: fullColor ? true : false

    focusPolicy: Qt.NoFocus

    // colors
    property bool fullColor: false
    property string fulltextColor: "white"
    property string primaryColor: Theme.colorPrimary
    property string secondaryColor: Theme.colorComponentBackground

    // animation
    property bool hoverAnimation: isDesktop

    ////////////////////////////////////////////////////////////////////////////

    MouseArea {
        id: mousearea
        anchors.fill: parent
        enabled: control.hoverAnimation

        hoverEnabled: control.hoverAnimation
        property bool hovered: false

        onClicked: control.clicked()

        onPressed: {
            mouseBackground.width = (control.width * 2)
            mouseBackground.opacity = 0.16
            control.down = true
        }
        onPressAndHold: {
            control.down = true
            control.pressAndHold()
        }
        onReleased: {
            //mouseBackground.width = 0
            //mouseBackground.opacity = 0
            control.down = false
        }
        onEntered: {
            mouseBackground.width = 72
            mouseBackground.opacity = 0.16
            mousearea.hovered = true
        }
        onExited: {
            mouseBackground.width = 0
            mouseBackground.opacity = 0
            control.down = false
            mousearea.hovered = false
        }
        onCanceled: {
            mouseBackground.width = 0
            mouseBackground.opacity = 0
            control.down = false
            mousearea.hovered = false
        }
    }

    ////////////////////////////////////////////////////////////////////////////

    background: Rectangle {
        anchors.fill: control
        radius: Theme.componentRadius
        opacity: enabled ? (control.down && !control.hoverAnimation ? 0.8 : 1.0) : 0.4
        color: control.fullColor ? control.primaryColor : control.secondaryColor
        border.width: Theme.componentBorderWidth
        border.color: control.fullColor ? control.primaryColor : Theme.colorComponentBorder

        Rectangle {
            id: mouseBackground
            width: 0; height: width; radius: width;
            x: mousearea.mouseX - (width / 2)
            y: mousearea.mouseY - (width / 2)

            visible: control.hoverAnimation
            color: "white"
            opacity: 0
            Behavior on opacity { NumberAnimation { duration: 333 } }
            Behavior on width { NumberAnimation { duration: 200 } }
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

    contentItem: Item {
        anchors.fill: control

        Text { // this one is just used for size reference
            id: contentTextInvisible
            text: control.text
            textFormat: Text.PlainText
            font: control.font
            visible: false
        }
        Text {
            id: contentText
            anchors.fill: parent

            text: control.text
            textFormat: Text.PlainText
            font: control.font
            opacity: enabled ? (control.down && !control.hoverAnimation ? 0.8 : 1.0) : 0.66
            color: control.fullColor ? control.fulltextColor : control.primaryColor
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter

            //elide: Text.ElideMiddle
            wrapMode: Text.WordWrap
        }
    }
}
