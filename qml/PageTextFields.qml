import QtQuick
import QtQuick.Controls

import ThemeEngine 1.0

Flickable {
    contentWidth: -1
    contentHeight: contentColumn.height

    boundsBehavior: isDesktop ? Flickable.OvershootBounds : Flickable.DragAndOvershootBounds
    ScrollBar.vertical: ScrollBar { visible: isDesktop; }

    Column {
        id: contentColumn

        anchors.left: parent.left
        anchors.leftMargin: Theme.componentMargin
        anchors.right: parent.right
        anchors.rightMargin: Theme.componentMargin

        topPadding: Theme.componentMargin
        bottomPadding: Theme.componentMargin
        spacing: Theme.componentMarginXL

        ListTitle { ////////////////////////////////////////////////////////////
            anchors.leftMargin: singleColumn ? -parent.anchors.leftMargin : 0
            anchors.rightMargin: singleColumn ? -parent.anchors.leftMargin : 0

            text: qsTr("TextFields")
            source: ""
        }

        TextFieldThemed {
            anchors.left: parent.left
            anchors.right: parent.right

            placeholderText: "placeholder text"
        }

        AndroidTextField {
            anchors.left: parent.left
            anchors.right: parent.right

            title: "AndroidTextField"
            text: "some text"
            placeholderText: "placeholder text"
        }

        ListTitle { ////////////////////////////////////////////////////////////
            anchors.leftMargin: singleColumn ? -parent.anchors.leftMargin : 0
            anchors.rightMargin: singleColumn ? -parent.anchors.leftMargin : 0

            text: qsTr("TextAreas")
            source: ""
        }

        TextAreaThemed {
            anchors.left: parent.left
            anchors.right: parent.right

            placeholderText: "placeholder text"
        }

        ListTitle { ////////////////////////////////////////////////////////////
            anchors.leftMargin: singleColumn ? -parent.anchors.leftMargin : 0
            anchors.rightMargin: singleColumn ? -parent.anchors.leftMargin : 0

            text: qsTr("Qt default")
            source: ""
        }

        TextField {
            anchors.left: parent.left
            anchors.right: parent.right

            width: 256
            text: "Text Field"
        }
    }
}
