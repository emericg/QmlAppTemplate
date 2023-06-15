import QtQuick
import QtQuick.Templates as T
import QtQuick.Controls.impl
import QtQuick.Controls.Material
import QtQuick.Controls.Material.impl

import ThemeEngine

T.ItemDelegate {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding,
                             implicitIndicatorHeight + topPadding + bottomPadding)

    padding: Theme.componentMargin
    spacing: Theme.componentMargin
    verticalPadding: 0

    icon.width: 32
    icon.height: 32
    icon.color: enabled ? Material.foreground : Material.hintTextColor

    ////////////////

    background: Rectangle {
        implicitHeight: Theme.componentHeightXL

        color: control.highlighted ? control.Material.listHighlightColor : "transparent"

        RippleThemed {
            width: parent.width
            height: parent.height

            clip: visible
            pressed: control.pressed
            anchor: control
            active: enabled && (control.down || control.visualFocus || control.hovered)
            color: control.Material.rippleColor
        }
    }

    ////////////////

    contentItem: Row {
        anchors.verticalCenter: parent.verticalCenter
        width: screenMobileComponents.width
        spacing: Theme.componentMargin

        RoundButtonIcon {
            anchors.verticalCenter: parent.verticalCenter
            width: Theme.componentHeight
            height: Theme.componentHeight

            source: model.icon
            sourceSize: icon.width
            background: true
        }

        Column {
            anchors.verticalCenter: parent.verticalCenter

            Text {
                text: model.title
                textFormat: Text.PlainText
                font.pixelSize: Theme.fontSizeComponent
                color: Theme.colorText
            }
            Text {
                text: model.text
                textFormat: Text.PlainText
                font.pixelSize: Theme.fontSizeComponent
                color: Theme.colorSubText
            }
        }
    }

    ////////////////
}
