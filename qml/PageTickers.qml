import QtQuick
import QtQuick.Controls

import ThemeEngine

Flickable {
    contentWidth: -1
    contentHeight: contentColumn.height

    boundsBehavior: isDesktop ? Flickable.OvershootBounds : Flickable.DragAndOvershootBounds
    ScrollBar.vertical: ScrollBar { visible: isDesktop; }

    Column {
        id: contentColumn

        anchors.left: parent.left
        anchors.right: parent.right

        topPadding: Theme.componentMarginXL
        bottomPadding: Theme.componentMarginXL
        spacing: Theme.componentMarginXL

        ListTitle { ////////////////////////////////////////////////////////////
            anchors.leftMargin: singleColumn ? 0 : Theme.componentMargin
            anchors.rightMargin: singleColumn ? 0 : Theme.componentMargin

            text: qsTr("Title")
            icon: ""
        }

        Row {
            anchors.horizontalCenter: parent.horizontalCenter

            CheckBoxThemed {
                text: "CheckBox"
            }
        }

        Row {
            anchors.horizontalCenter: parent.horizontalCenter

            RadioButtonThemed {
                text: "light"
                checked: true
            }
            RadioButtonThemed {
                text: "dark"
                checked: false
            }
        }

        ListTitle { ////////////////////////////////////////////////////////////
            anchors.leftMargin: singleColumn ? 0 : Theme.componentMargin
            anchors.rightMargin: singleColumn ? 0 : Theme.componentMargin

            text: qsTr("Switches")
            icon: ""
        }

        SwitchThemedDesktop {
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Switch desktop"
            checked: true
        }

        SwitchThemedMobile {
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Switch mobile"
            checked: true
        }

        ListTitle { ////////////////////////////////////////////////////////////
            anchors.leftMargin: singleColumn ? 0 : Theme.componentMargin
            anchors.rightMargin: singleColumn ? 0 : Theme.componentMargin

            text: qsTr("SpinBoxes")
            icon: ""
        }

        SpinBoxThemedDesktop {
            anchors.horizontalCenter: parent.horizontalCenter
            value: 50
        }

        SpinBoxThemedDesktop {
            anchors.horizontalCenter: parent.horizontalCenter
            value: 4
            legend: "h"
        }

        SpinBoxThemedMobile {
            anchors.horizontalCenter: parent.horizontalCenter
            value: 128
            legend: "Kio"
        }
    }
}
