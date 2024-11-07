import QtQuick
import QtQuick.Controls

import ComponentLibrary
import QmlAppTemplate

Flickable {
    contentWidth: -1
    contentHeight: contentColumn.height

    boundsBehavior: isDesktop ? Flickable.OvershootBounds : Flickable.DragAndOvershootBounds
    ScrollBar.vertical: ScrollBar { visible: false }

    Column {
        id: contentColumn

        anchors.left: parent.left
        anchors.leftMargin: Theme.componentMarginXL
        anchors.right: parent.right
        anchors.rightMargin: Theme.componentMarginXL

        topPadding: Theme.componentMargin
        bottomPadding: Theme.componentMargin
        spacing: Theme.componentMarginXL

        ListTitle { ////////////////////////////////////////////////////////////
            anchors.leftMargin: singleColumn ? 0 : Theme.componentMargin
            anchors.rightMargin: singleColumn ? 0 : Theme.componentMargin

            text: qsTr("Title")
            source: ""
        }
    }
}
