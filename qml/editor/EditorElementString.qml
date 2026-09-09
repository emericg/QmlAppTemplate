import QtQuick

import ComponentLibrary

Item {
    id: root
    height: Theme.componentHeightXL + Theme.componentMarginXS

    property string propertyName
    property string propertyLabel: propertyName

    property string defaultValue
    readonly property bool modified: (Theme[propertyName] !== defaultValue)

    Component.onCompleted: defaultValue = Theme[propertyName]

    // Re-snapshot the baseline and resync the field whenever the theme is changed
    Connections {
        target: Theme
        function onCurrentThemeChanged() {
            root.defaultValue = Theme[root.propertyName]
            field.text = Theme[root.propertyName]
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

        TextFieldThemed {
            id: field
            anchors.verticalCenter: parent.verticalCenter
            width: 180

            text: Theme[root.propertyName]
            onEditingFinished: {
                Theme[root.propertyName] = field.text
                focus = false
            }
        }

        RoundButtonIconThemed {
            anchors.verticalCenter: parent.verticalCenter
            width: Theme.componentHeightS
            height: Theme.componentHeightS

            source: "qrc:/IconLibrary/material-icons/duotone/restart_alt.svg"
            enabled: root.modified

            onClicked: {
                Theme[root.propertyName] = root.defaultValue
                field.text = root.defaultValue
            }
        }
    }

    ////////////////
}
