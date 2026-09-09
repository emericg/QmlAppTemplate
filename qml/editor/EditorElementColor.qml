import QtQuick
import QtQuick.Dialogs

import ComponentLibrary

Item {
    id: root
    height: Theme.componentHeightXL + Theme.componentMarginXS

    property string propertyName
    property string propertyLabel: propertyName

    property color defaultValue
    readonly property bool modified: (Theme[propertyName] + "") !== (defaultValue + "")

    Component.onCompleted: defaultValue = Theme[propertyName]

    // Re-snapshot the baseline whenever the theme is changed
    Connections {
        target: Theme
        function onCurrentThemeChanged() {
            root.defaultValue = Theme[root.propertyName]
        }
    }

    ////////////////

    TextSelectable {
        anchors.left: parent.left
        anchors.leftMargin: Theme.componentMargin
        anchors.right: controls.left
        anchors.rightMargin: Theme.componentMargin
        anchors.verticalCenter: parent.verticalCenter

        text: root.propertyLabel
    }

    ////////////////

    Row {
        id: controls

        anchors.right: parent.right
        anchors.rightMargin: Theme.componentMargin
        anchors.verticalCenter: parent.verticalCenter
        spacing: Theme.componentMarginS

        Text {
            anchors.verticalCenter: parent.verticalCenter
            text: {
                let c = Theme[root.propertyName]
                return c ? c.toString() : ""
            }
            color: Theme.colorSubText
            font.pixelSize: Theme.fontSizeContentSmall
        }

        Rectangle {
            anchors.verticalCenter: parent.verticalCenter
            width: 56
            height: Theme.componentHeightS
            radius: Theme.componentRadius

            color: Theme[root.propertyName]
            border.width: Theme.componentBorderWidth
            border.color: Theme.colorComponentBorder

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: colorDialog.open()
            }
        }

        RoundButtonIconThemed {
            anchors.verticalCenter: parent.verticalCenter
            width: Theme.componentHeightS
            height: Theme.componentHeightS

            source: "qrc:/IconLibrary/material-icons/duotone/restart_alt.svg"
            enabled: root.modified

            onClicked: Theme[root.propertyName] = root.defaultValue
        }
    }

    ////////////////

    ColorDialog {
        id: colorDialog
        options: ColorDialog.ShowAlphaChannel
        selectedColor: Theme[root.propertyName]
        onAccepted: Theme[root.propertyName] = colorDialog.selectedColor
    }
}
