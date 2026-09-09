import QtQuick

import ComponentLibrary

Item {
    id: root
    height: Theme.componentHeightXL + Theme.componentMarginXS

    property string propertyName
    property string propertyLabel: propertyName

    // Pristine value from the current theme, restored by the reset button.
    // Snapshotted (not bound) so user edits don't move the baseline.
    property bool defaultValue
    readonly property bool modified: (Theme[propertyName] !== defaultValue)

    Component.onCompleted: defaultValue = Theme[propertyName]

    // Re-snapshot the baseline and resync the switch whenever the theme is changed
    Connections {
        target: Theme
        function onCurrentThemeChanged() {
            root.defaultValue = Theme[root.propertyName]
            control.checked = Theme[root.propertyName]
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

        SwitchThemed {
            id: control
            anchors.verticalCenter: parent.verticalCenter

            checked: Theme[root.propertyName]
            onClicked: Theme[root.propertyName] = control.checked
        }

        RoundButtonIconThemed {
            anchors.verticalCenter: parent.verticalCenter
            width: Theme.componentHeightS
            height: Theme.componentHeightS

            source: "qrc:/IconLibrary/material-icons/duotone/restart_alt.svg"
            enabled: root.modified

            onClicked: {
                Theme[root.propertyName] = root.defaultValue
                control.checked = root.defaultValue
            }
        }
    }

    ////////////////
}
