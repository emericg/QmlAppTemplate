import QtQuick 2.15

import ThemeEngine 1.0

Rectangle {
    id: actionMenuItem
    height: 34

    anchors.left: parent.left
    anchors.leftMargin: Theme.componentBorderWidth
    anchors.right: parent.right
    anchors.rightMargin: Theme.componentBorderWidth

    radius: Theme.componentRadius
    color: Theme.colorBackground

    // actions
    signal clicked()
    signal pressAndHold()

    // settings
    property int index
    property string text
    property url source
    property int sourceSize: 20

    ////////////////////////////////////////////////////////////////////////////

    IconSvg {
        id: iButton
        width: actionMenuItem.sourceSize
        height: actionMenuItem.sourceSize
        anchors.left: parent.left
        anchors.leftMargin: 12
        anchors.verticalCenter: parent.verticalCenter

        source: actionMenuItem.source
        color: Theme.colorIcon
    }

    Text {
        id: tButton
        anchors.left: iButton.right
        anchors.leftMargin: 12
        anchors.right: parent.right
        anchors.rightMargin: 12
        anchors.verticalCenter: parent.verticalCenter

        text: actionMenuItem.text
        font.bold: false
        font.pixelSize: Theme.fontSizeComponent
        elide: Text.ElideRight
        color: Theme.colorText
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: isDesktop && visible

        onClicked: actionMenuItem.clicked()
        onPressAndHold: actionMenuItem.pressAndHold()

        onEntered: actionMenuItem.state = "hovered"
        onExited: actionMenuItem.state = "normal"
        onCanceled: actionMenuItem.state = "normal"
    }

    ////////////////////////////////////////////////////////////////////////////

    states: [
        State {
            name: "normal";
            PropertyChanges { target: actionMenuItem; color: Theme.colorBackground; }
        },
        State {
            name: "hovered";
            PropertyChanges { target: actionMenuItem; color: Theme.colorSeparator; }
        }
    ]

    ////////////////////////////////////////////////////////////////////////////
}
