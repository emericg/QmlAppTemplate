import QtQuick

import ComponentLibrary

Item {
    id: root
    height: Theme.componentHeightXL + Theme.componentMarginXS

    property string propertyName
    property string propertyLabel: propertyName

    property string defaultValue
    readonly property bool modified: (Theme[propertyName] !== defaultValue)

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

    Text {
        id: controls
        anchors.right: parent.right
        anchors.rightMargin: Theme.componentMargin
        anchors.verticalCenter: parent.verticalCenter

        text: Theme[root.propertyName] + " px"
        color: Theme.colorText
        font.pixelSize: Theme[root.propertyName]
        verticalAlignment: Text.AlignVCenter
    }

    ////////////////
}
