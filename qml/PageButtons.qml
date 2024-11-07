import QtQuick
import QtQuick.Controls

import ComponentLibrary
import QmlAppTemplate

Item {

    Column {
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: Theme.componentMarginXL
        spacing: Theme.componentMarginXL
        z: 10

        ButtonFab {
            anchors.right: parent.right
            source: "qrc:/assets/icons/material-symbols/add.svg"
        }

        ButtonFabExtended {
            anchors.right: parent.right
            text: "Extended FAB"
            source: "qrc:/assets/icons/material-symbols/add.svg"
        }
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

                ButtonClear {
                    text: "ButtonClear"
                    color: Theme.colorMaterialPurple
                }

                ButtonClear {
                    text: "ButtonClear"
                    source: "qrc:/assets/icons/material-symbols/accessibility.svg"
                    color: Theme.colorMaterialBlue
                }
            }

            Flow {
                anchors.left: parent.left
                anchors.leftMargin: Theme.componentMarginXL
                anchors.right: parent.right
                anchors.rightMargin: Theme.componentMarginXL
                spacing: 24

                ButtonOutline {
                    text: "ButtonOutline"
                    color: Theme.colorMaterialIndigo
                }

                ButtonOutline {
                    text: "ButtonOutline"
                    source: "qrc:/assets/icons/material-symbols/accessibility.svg"
                    color: Theme.colorMaterialLightBlue
                }
            }

            Flow {
                anchors.left: parent.left
                anchors.leftMargin: Theme.componentMarginXL
                anchors.right: parent.right
                anchors.rightMargin: Theme.componentMarginXL
                spacing: 24

                ButtonFlat {
                    text: "ButtonFlat"
                    color: Theme.colorMaterialPurple
                }

                ButtonFlat {
                    text: "ButtonFlat"
                    source: "qrc:/assets/icons/material-symbols/accessibility.svg"
                    color: Theme.colorMaterialBlue
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
                    source: "qrc:/assets/icons/material-symbols/accessibility.svg"
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
                    source: "qrc:/assets/icons/material-symbols/accessibility.svg"
                }
            }

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

                ButtonChip {
                    text: "ButtonChip"
                }

                ButtonChip {
                    text: "ButtonChip"
                    leftIcon: "qrc:/assets/icons/material-symbols/supervised_user_circle.svg"
                    rightIcon: "qrc:/assets/icons/material-symbols/close.svg"
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
                    source: "qrc:/assets/icons/material-symbols/accessibility.svg"
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

                text: qsTr("Square buttons")
                source: ""
            }

            Row {
                anchors.horizontalCenter: parent.horizontalCenter
                height: 48
                spacing: 16

                SquareButtonSunken {
                    width: 48
                    height: 48

                    source: "qrc:/assets/icons/material-symbols/accessibility.svg"
                }
                SquareButtonClear {
                    width: 48
                    height: 48

                    source: "qrc:/assets/icons/material-symbols/accessibility.svg"
                }
                SquareButtonFlat {
                    width: 48
                    height: 48

                    source: "qrc:/assets/icons/material-symbols/accessibility.svg"
                }
                SquareButtonDesktop {
                    width: 48
                    height: 48

                    colorIconHighlight: "red"
                    source: "qrc:/assets/icons/material-symbols/accessibility.svg"
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

                RoundButtonSunken {
                    width: 48
                    height: 48

                    source: "qrc:/assets/icons/material-symbols/accessibility.svg"
                }
                RoundButtonClear {
                    width: 48
                    height: 48

                    source: "qrc:/assets/icons/material-symbols/accessibility.svg"
                }
                RoundButtonFlat {
                    width: 48
                    height: 48

                    colorIconHighlight: "red"
                    source: "qrc:/assets/icons/material-symbols/accessibility.svg"
                }
                RoundButtonDesktop {
                    width: 48
                    height: 48

                    source: "qrc:/assets/icons/material-symbols/accessibility.svg"
                }
            }

            ListTitle { ////////////////////////////////////////////////////////////
                anchors.leftMargin: singleColumn ? 0 : Theme.componentMargin
                anchors.rightMargin: singleColumn ? 0 : Theme.componentMargin

                text: qsTr("Round buttons (legacy)")
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
                    source: "qrc:/assets/icons/material-symbols/accessibility.svg"
                    highlightMode: "color"
                }
                RoundButtonIcon {
                    source: "qrc:/assets/icons/material-symbols/accessibility.svg"
                    highlightMode: "circle"
                    backgroundVisible: true
                }
                RoundButtonIcon {
                    source: "qrc:/assets/icons/material-symbols/accessibility.svg"
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
