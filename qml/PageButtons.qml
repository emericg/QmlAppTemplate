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

            text: qsTr("Buttons")
            icon: ""
        }

        Flow {
            anchors.left: parent.left
            anchors.leftMargin: Theme.componentMarginXL
            anchors.right: parent.right
            anchors.rightMargin: Theme.componentMarginXL
            spacing: 24

            ButtonWireframe {
                fullColor: true
                text: "ButtonWireframe"
            }

            ButtonWireframeIcon {
                fullColor: true
                text: "ButtonWireframeIcon"
                source: "qrc:/assets/icons_material/baseline-accessibility-24px.svg"
            }

            ButtonWireframe {
                text: "ButtonWireframe"
            }

            ButtonWireframeIcon {
                //width: 128
                text: "ButtonWireframeIcon"
                source: "qrc:/assets/icons_material/baseline-accessibility-24px.svg"
            }

            ButtonText {
                text: "ButtonText"
            }
        }

        Flow {
            anchors.left: parent.left
            anchors.leftMargin: Theme.componentMarginXL
            anchors.right: parent.right
            anchors.rightMargin: Theme.componentMarginXL
            spacing: 24

            AndroidButton {
                text: "AndroidButton"
            }

            AndroidButtonIcon {
                text: "AndroidButtonIcon"
                source: "qrc:/assets/icons_material/baseline-accessibility-24px.svg"
            }
        }

        ListTitle { ////////////////////////////////////////////////////////////
            anchors.leftMargin: singleColumn ? 0 : Theme.componentMargin
            anchors.rightMargin: singleColumn ? 0 : Theme.componentMargin

            text: qsTr("Round buttons")
            icon: ""
        }

        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            height: 48
            spacing: 16

            RoundButtonText {
                width: 48
                height: 48
                text: "+"
                highlightMode: "color"
                backgroundVisible: true
            }
            RoundButtonText {
                width: 48
                height: 48
                text: "-"
                highlightMode: "circle"
                backgroundVisible: false
            }
            RoundButtonText {
                width: 48
                height: 48
                text: "a"
                highlightMode: "color"
                highlightColor: Theme.colorError
                borderVisible: true

                tooltipText: "this one has a tooltip!"
            }
        }

        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            height: 48
            spacing: 16

            RoundButtonIcon {
                source: "qrc:/assets/icons_material/baseline-accessibility-24px.svg"
                highlightMode: "color"
            }
            RoundButtonIcon {
                source: "qrc:/assets/icons_material/baseline-accessibility-24px.svg"
                highlightMode: "circle"
                backgroundVisible: true
            }
            RoundButtonIcon {
                source: "qrc:/assets/icons_material/baseline-accessibility-24px.svg"
                highlightMode: "color"
                highlightColor: Theme.colorError

                tooltipText: "another tooltip!"
            }
        }

        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            height: 48
            spacing: 16

            RoundButtonText {
                text: "+"
                backgroundVisible: true
                highlightMode: "color"
            }
            RoundButtonText {
                text: "-"
                backgroundVisible: false
                highlightMode: "circle"
            }
            RoundButtonText {
                text: "a"
                highlightMode: "color"
                highlightColor: Theme.colorError
                borderVisible: true

                tooltipText: "this one has a tooltip!"
            }
        }
    }
}
