import QtQuick

import ComponentLibrary

Item {
    id: root
    height: Theme.componentHeightXL + Theme.componentMarginXS

    property string propertyName
    property string propertyLabel: propertyName

    property int from: 0
    property int to: 100
    property int defaultValue
    readonly property bool modified: (Theme[propertyName] !== defaultValue)

    Component.onCompleted: defaultValue = Theme[propertyName]

    // Re-snapshot the baseline and resync the spinbox whenever the theme is changed
    Connections {
        target: Theme
        function onCurrentThemeChanged() {
            root.defaultValue = Theme[root.propertyName]
            spin.value = Theme[root.propertyName]
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

        SpinBoxThemedDesktop {
            id: spin
            anchors.verticalCenter: parent.verticalCenter

            from: root.from
            to: root.to
            editable: true
            legend: "px"

            value: Theme[root.propertyName]
            onValueModified: Theme[root.propertyName] = spin.value
        }

        RoundButtonIconThemed {
            anchors.verticalCenter: parent.verticalCenter
            width: Theme.componentHeightS
            height: Theme.componentHeightS

            source: "qrc:/IconLibrary/material-icons/duotone/restart_alt.svg"
            enabled: root.modified

            onClicked: {
                Theme[root.propertyName] = root.defaultValue
                spin.value = root.defaultValue
            }
        }
    }

    ////////////////
}
