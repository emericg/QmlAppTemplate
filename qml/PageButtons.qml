import QtQuick
import QtQuick.Controls

import ThemeEngine

Item {

    ButtonFab {
        source: "qrc:/assets/icons_material/baseline-add-24px.svg"
    }

    Flickable {
        anchors.fill: parent

        contentWidth: -1
        contentHeight: contentColumn.height

        boundsBehavior: isDesktop ? Flickable.OvershootBounds : Flickable.DragAndOvershootBounds
        ScrollBar.vertical: ScrollBar { visible: false }

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
                source: ""
            }

            Flow {
                anchors.left: parent.left
                anchors.leftMargin: Theme.componentMarginXL
                anchors.right: parent.right
                anchors.rightMargin: Theme.componentMarginXL
                spacing: 24

                ButtonFlat {
                    text: "ButtonFlat"
                    colorBackground: Theme.colorMaterialPurple
                }

                ButtonFlat {
                    text: "ButtonFlat"
                    source: "qrc:/assets/icons_material/baseline-accessibility-24px.svg"
                    colorBackground: Theme.colorMaterialBlue
                }
            }

            Flow {
                anchors.left: parent.left
                anchors.leftMargin: Theme.componentMarginXL
                anchors.right: parent.right
                anchors.rightMargin: Theme.componentMarginXL
                spacing: 24

                ButtonSolid {
                    text: "ButtonSolid"
                }

                ButtonSolid {
                    text: "ButtonSolid"
                    source: "qrc:/assets/icons_material/baseline-accessibility-24px.svg"
                }
            }

            Flow {
                anchors.left: parent.left
                anchors.leftMargin: Theme.componentMarginXL
                anchors.right: parent.right
                anchors.rightMargin: Theme.componentMarginXL
                spacing: 24

                ButtonWireframe {
                    text: "ButtonWireframe"
                }

                ButtonWireframe {
                    //width: 128
                    text: "ButtonWireframe"
                    source: "qrc:/assets/icons_material/baseline-accessibility-24px.svg"
                }
            }

            Flow {
                anchors.left: parent.left
                anchors.leftMargin: Theme.componentMarginXL
                anchors.right: parent.right
                anchors.rightMargin: Theme.componentMarginXL
                spacing: 24

                ButtonChip {
                    text: "ButtonChip"
                }

                ButtonChip {
                    text: "ButtonChip"
                    leftIcon: "qrc:/assets/icons_material/baseline-supervised_user_circle-24px.svg"
                    rightIcon: "qrc:/assets/icons_material/baseline-close-24px.svg"
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

            Flow {
                anchors.left: parent.left
                anchors.leftMargin: Theme.componentMarginXL
                anchors.right: parent.right
                anchors.rightMargin: Theme.componentMarginXL
                spacing: 24

                ButtonText {
                    text: "ButtonText"
                }
            }

            ListTitle { ////////////////////////////////////////////////////////////
                anchors.leftMargin: singleColumn ? 0 : Theme.componentMargin
                anchors.rightMargin: singleColumn ? 0 : Theme.componentMargin

                text: qsTr("Round buttons")
                source: ""
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
}
