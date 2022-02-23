import QtQuick 2.15
import QtQuick.Layouts 1.15

import ThemeEngine 1.0

Item {
    id: control
    implicitWidth: 80
    implicitHeight: 64

    width: parent.width
    height: Math.max(implicitHeight, content.height + 24)

    // actions
    signal clicked()
    signal pressAndHold()

    // states
    property bool hovered: false
    property bool selected: false

    // settings
    property url source
    property int sourceSize: 64
    property string text
    property string highlightMode: "background" // available: background, indicator, content

    // colors
    property string colorContent: Theme.colorSidebarContent
    property string colorHighlight: Theme.colorSidebarHighlight

    ////////////////////////////////////////////////////////////////////////////

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true

        onClicked: control.clicked()
        onPressAndHold: control.pressAndHold()

        onEntered: control.hovered = true
        onExited: control.hovered = false
        onCanceled: control.hovered = false
    }

    ////////////////////////////////////////////////////////////////////////////

    Rectangle {
        id: bgRect
        anchors.fill: parent

        visible: (control.selected && (control.highlightMode === "background" || control.highlightMode === "indicator"))
        color: control.colorHighlight
    }
    Rectangle {
        id: bgFocus
        anchors.fill: parent

        visible: (control.highlightMode === "background" || control.highlightMode === "indicator")
        color: control.colorHighlight
        opacity: control.hovered ? 0.5 : 0
        Behavior on opacity { OpacityAnimator { duration: 333 } }
    }
    Rectangle {
        id: bgIndicator
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.bottom: parent.bottom

        width: 6
        visible: (control.selected && control.highlightMode === "indicator")
        color: Theme.colorPrimary
    }

    ////////////////////////////////////////////////////////////////////////////

    ColumnLayout {
        id: content
        anchors.centerIn: parent
        spacing: 8

        IconSvg {
            id: contentImage
            width: control.sourceSize
            height: control.sourceSize

            Layout.maximumWidth: control.sourceSize
            Layout.maximumHeight: control.sourceSize

            visible: source.toString().length

            source: control.source
            color: (!control.selected && control.highlightMode === "content") ? control.colorHighlight : control.colorContent
            opacity: control.enabled ? 1.0 : 0.33
        }

        Text {
            id: contentText
            height: parent.height

            visible: text

            text: control.text
            textFormat: Text.PlainText
            color: (!control.selected && control.highlightMode === "content") ? control.colorHighlight : control.colorContent
            font.pixelSize: Theme.fontSizeComponent
            font.bold: true
            verticalAlignment: Text.AlignVCenter
        }
    }
}
