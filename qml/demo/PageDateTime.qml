import QtQuick
import QtQuick.Controls

import ComponentLibrary

Flickable {
    contentWidth: -1
    contentHeight: contentColumn.height

    boundsBehavior: Theme.isDesktop ? Flickable.OvershootBounds : Flickable.DragAndOvershootBounds
    ScrollBar.vertical: ScrollBarThemed { visible: Theme.isDesktop }

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
            anchors.leftMargin: Theme.singleColumn ? 0 : Theme.componentMargin
            anchors.rightMargin: Theme.singleColumn ? 0 : Theme.componentMargin

            text: qsTr("Title")
            source: ""
        }
    }
}
