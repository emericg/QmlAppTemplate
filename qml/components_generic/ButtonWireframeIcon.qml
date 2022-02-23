import QtQuick 2.15
import QtQuick.Controls.impl 2.15
import QtQuick.Templates 2.15 as T

//import QtGraphicalEffects 1.15 // Qt5
import Qt5Compat.GraphicalEffects // Qt6

import ThemeEngine 1.0
import "qrc:/js/UtilsNumber.js" as UtilsNumber

T.Button {
    id: control
    implicitWidth: {
        if (source && text) return contentTextInvisible.contentWidth + sourceSize + 32
        if (!source && text) return contentTextInvisible.contentWidth + 24
        return height
    }
    implicitHeight: Theme.componentHeight

    font.pixelSize: Theme.fontSizeComponent
    font.bold: fullColor ? true : false

    focusPolicy: Qt.NoFocus

    // settings
    property url source
    property int sourceSize: UtilsNumber.alignTo(height * 0.666, 2)
    property bool sourceRightToLeft: false

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
/*
        onPressAndHold: control.pressAndHold()
        onEntered: control.hovered = true
        onExited: control.hovered = false
        onCanceled: control.hovered = false
*/
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

            //width: mousearea.pressed ? (control.width * 2) : 0
            //height: width; radius: width;
            //opacity: (control.down || control.hovered) ? 0.16 : 0

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

        Text { // this one is just used for reference
            id: contentTextInvisible
            text: control.text
            textFormat: Text.PlainText
            font: control.font
            visible: false
        }

        Row {
            id: contentRow
            height: parent.height
            anchors.horizontalCenter: parent.horizontalCenter

            layoutDirection: (control.sourceRightToLeft) ? Qt.RightToLeft : Qt.LeftToRight
            spacing: 8

            IconSvg {
                id: contentImage
                width: control.sourceSize
                height: control.sourceSize
                anchors.verticalCenter: parent.verticalCenter

                visible: control.source
                source: control.source
                opacity: enabled ? 1.0 : 0.66
                color: control.fullColor ? control.fulltextColor : control.primaryColor
            }
            Text {
                id: contentText
                height: parent.height
                width: (control.implicitWidth - 24 - (control.source ? control.sourceSize + 8 : 0))
                visible: control.text
                anchors.verticalCenter: parent.verticalCenter

                text: control.text
                textFormat: Text.PlainText
                font: control.font
                opacity: enabled ? (control.down && !control.hoverAnimation ? 0.8 : 1.0) : 0.66
                color: control.fullColor ? control.fulltextColor : control.primaryColor
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter

                //elide: Text.ElideRight
                wrapMode: Text.WordWrap
            }
        }
    }
}
