import QtQuick
import QtQuick.Controls

import ComponentLibrary
import AppUtils

Flickable {
    contentWidth: -1
    contentHeight: contentColumn.height

    boundsBehavior: Theme.isDesktop ? Flickable.OvershootBounds : Flickable.DragAndOvershootBounds
    ScrollBar.vertical: ScrollBar { visible: false }

    Column {
        id: contentColumn

        anchors.left: parent.left
        anchors.right: parent.right

        topPadding: Theme.componentMarginXL
        bottomPadding: Theme.componentMarginXL
        spacing: Theme.componentMarginXL

        ////////////////

        ListTitle {
            anchors.leftMargin: singleColumn ? 0 : Theme.componentMargin
            anchors.rightMargin: singleColumn ? 0 : Theme.componentMargin

            text: qsTr("Frames")
            source: ""
        }

        Flow {
            anchors.left: parent.left
            anchors.leftMargin: Theme.componentMarginXL
            anchors.right: parent.right
            anchors.rightMargin: Theme.componentMarginXL
            spacing: Theme.componentMarginXL

            FrameThemed {
                width: 400

                Column {
                    width: parent.width
                    spacing: Theme.componentMarginXS

                    Text {
                        text: "FrameThemed"
                        color: Theme.colorText
                        font.pixelSize: Theme.fontSizeContentBig
                        font.bold: true
                    }
                    Text {
                        width: parent.width
                        text: LoremIpsum.paragraph
                        color: Theme.colorSubText
                        font.pixelSize: Theme.fontSizeContentSmall
                        wrapMode: Text.WordWrap
                    }
                }
            }

            FrameHazard {
                width: 400

                Column {
                    width: parent.width
                    spacing: Theme.componentMarginXS

                    Text {
                        text: "FrameHazard"
                        color: Theme.colorText
                        font.pixelSize: Theme.fontSizeContentBig
                        font.bold: true
                    }
                    Text {
                        width: parent.width
                        text: LoremIpsum.paragraph
                        color: Theme.colorSubText
                        font.pixelSize: Theme.fontSizeContentSmall
                        wrapMode: Text.WordWrap
                    }
                }
            }
        }

        ////////////////

        ListTitle {
            anchors.leftMargin: singleColumn ? 0 : Theme.componentMargin
            anchors.rightMargin: singleColumn ? 0 : Theme.componentMargin

            text: qsTr("Boxes")
            source: ""
        }

        FrameBox {
            anchors.left: parent.left
            anchors.leftMargin: Theme.componentMarginXL
            anchors.right: parent.right
            anchors.rightMargin: Theme.componentMarginXL

            Text {
                text: "FrameBox"
                color: Theme.colorText
                font.pixelSize: Theme.fontSizeContent
                verticalAlignment: Text.AlignVCenter
            }
        }

        FrameBox {
            anchors.left: parent.left
            anchors.leftMargin: Theme.componentMarginXL
            anchors.right: parent.right
            anchors.rightMargin: Theme.componentMarginXL

            highlighted: true

            Text {
                text: qsTr("FrameBox (highlighted)")
                color: Theme.colorText
                font.pixelSize: Theme.fontSizeContent
                verticalAlignment: Text.AlignVCenter
            }
        }

        ////////////////

        ListTitle {
            anchors.leftMargin: singleColumn ? 0 : Theme.componentMargin
            anchors.rightMargin: singleColumn ? 0 : Theme.componentMargin

            text: qsTr("Group box & pane")
            source: ""
        }

        GroupBoxThemed {
            anchors.left: parent.left
            anchors.leftMargin: Theme.componentMarginXL
            anchors.right: parent.right
            anchors.rightMargin: Theme.componentMarginXL

            title: qsTr("GroupBoxThemed")

            Column {
                width: parent.width
                spacing: Theme.componentMarginS

                CheckBoxThemed {
                    text: qsTr("First option")
                    checked: true
                }
                CheckBoxThemed {
                    text: qsTr("Second option")
                }
                SwitchThemed {
                    text: qsTr("A switch")
                    checked: true
                }
            }
        }

        PaneThemed {
            anchors.left: parent.left
            anchors.leftMargin: Theme.componentMarginXL
            anchors.right: parent.right
            anchors.rightMargin: Theme.componentMarginXL

            Row {
                spacing: Theme.componentMargin

                ButtonWireframe {
                    text: "PaneThemed"
                    //color: Theme.colorMaterialIndigo
                }
                ButtonWireframe {
                    text: qsTr("Action")
                    source: "qrc:/IconLibrary/material-symbols/accessibility.svg"
                    //color: Theme.colorMaterialBlue
                }
            }
        }

        ////////////////
    }
}
