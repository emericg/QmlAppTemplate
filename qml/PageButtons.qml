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
        anchors.leftMargin: 20
        anchors.right: parent.right
        anchors.rightMargin: 20

        topPadding: 16
        bottomPadding: 16
        spacing: 16

        SectionTitle { /////////////////////////////////////////////////////////
            anchors.leftMargin: singleColumn ? -parent.anchors.leftMargin : 12
            anchors.rightMargin: singleColumn ? -parent.anchors.leftMargin : 12

            text: qsTr("Buttons")
            source: ""
        }

        Flow {
            anchors.left: parent.left
            anchors.right: parent.right
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
            anchors.right: parent.right
            spacing: 24

            AndroidButton {
                text: "AndroidButton"
            }

            AndroidButtonIcon {
                text: "AndroidButtonIcon"
                source: "qrc:/assets/icons_material/baseline-accessibility-24px.svg"
            }
        }

        SectionTitle { /////////////////////////////////////////////////////////
            anchors.leftMargin: singleColumn ? -parent.anchors.leftMargin : 12
            anchors.rightMargin: singleColumn ? -parent.anchors.leftMargin : 12

            text: qsTr("Round buttons")
            source: ""
        }

        Row {
            height: 48
            spacing: 16

            RoundButtonText {
                width: 48
                height: 48
                text: "+"
                background: true
                highlightMode: "color"
            }
            RoundButtonText {
                width: 48
                height: 48
                text: "-"
                background: false
                highlightMode: "circle"
            }
            RoundButtonText {
                width: 48
                height: 48
                text: "a"
                highlightMode: "color"
                highlightColor: Theme.colorError
                border: true

                tooltipText: "this one has a tooltip!"
            }
        }

        Row {
            height: 48
            spacing: 16

            RoundButtonIcon {
                source: "qrc:/assets/icons_material/baseline-accessibility-24px.svg"
                highlightMode: "color"
            }
            RoundButtonIcon {
                source: "qrc:/assets/icons_material/baseline-accessibility-24px.svg"
                background: true
                highlightMode: "circle"
            }
            RoundButtonIcon {
                source: "qrc:/assets/icons_material/baseline-accessibility-24px.svg"
                highlightMode: "color"
                highlightColor: Theme.colorError

                tooltipText: "another tooltip!"
            }
        }

        Row {
            height: 48
            spacing: 16

            RoundButtonText {
                text: "+"
                background: true
                highlightMode: "color"
            }
            RoundButtonText {
                text: "-"
                background: false
                highlightMode: "circle"
            }
            RoundButtonText {
                text: "a"
                highlightMode: "color"
                highlightColor: Theme.colorError
                border: true

                tooltipText: "this one has a tooltip!"
            }
        }
    }
}
