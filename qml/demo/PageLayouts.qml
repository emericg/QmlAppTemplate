import QtQuick
import QtQuick.Controls

import ComponentLibrary
import AppUtils

Flickable {
    contentWidth: -1
    contentHeight: contentColumn.height

    boundsBehavior: Theme.isDesktop ? Flickable.OvershootBounds : Flickable.DragAndOvershootBounds
    ScrollBar.vertical: ScrollBarThemed { visible: Theme.isDesktop }

    Column {
        id: contentColumn

        anchors.left: parent.left
        anchors.leftMargin: Theme.singleColumn ? 0 : parent.width*0.125
        anchors.right: parent.right
        anchors.rightMargin: Theme.singleColumn ? 0 : parent.width*0.125

        topPadding: Theme.componentMarginXL
        bottomPadding: Theme.componentMarginXL
        spacing: Theme.componentMarginXL

        ListTitle { ////////////////////////////////////////////////////////////
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

        ListTitle { ////////////////////////////////////////////////////////////
            anchors.leftMargin: singleColumn ? 0 : Theme.componentMargin
            anchors.rightMargin: singleColumn ? 0 : Theme.componentMargin

            text: qsTr("FrameSolid")
            source: ""
        }

        Flow {
            anchors.left: parent.left
            anchors.leftMargin: Theme.componentMarginXL
            anchors.right: parent.right
            anchors.rightMargin: Theme.componentMarginXL
            spacing: Theme.componentMarginXL

            FrameSolid {
                width: Math.min(480, contentColumn.width - Theme.componentMarginXL * 2)

                title: qsTr("Gestures")
                source: "qrc:/IconLibrary/material-icons/duotone/touch_app.svg"

                Column {
                    width: parent.width

                    Repeater {
                        model: ListModel {
                            ListElement {
                                gesture: "HOLD + MOVE LEFT"
                                action: "Snap left"
                                icon: "qrc:/IconLibrary/material-symbols/arrow_circle_left.svg"
                            }
                            ListElement {
                                gesture: "HOLD + MOVE RIGHT"
                                action: "Snap right"
                                icon: "qrc:/IconLibrary/material-symbols/arrow_circle_right.svg"
                            }
                            ListElement {
                                gesture: "HOLD + MOVE UP"
                                action: "Maximize window"
                                icon: "qrc:/IconLibrary/material-symbols/arrow_circle_up.svg"
                            }
                            ListElement {
                                gesture: "HOLD + MOVE DOWN"
                                action: "Show/hide desktop"
                                icon: "qrc:/IconLibrary/material-symbols/arrow_circle_down.svg"
                            }
                            ListElement {
                                gesture: "CLICK"
                                action: "Switch application"
                                icon: "qrc:/IconLibrary/material-symbols/circle.svg"
                            }
                        }

                        delegate: Item {
                            id: gestureRow

                            required property int index
                            required property string gesture
                            required property string action
                            required property string icon

                            width: parent.width
                            height: 56

                            IconSvg {
                                anchors.left: parent.left
                                anchors.leftMargin: 4
                                anchors.verticalCenter: parent.verticalCenter
                                width: 20
                                height: 20

                                source: gestureRow.icon
                                color: Theme.colorIcon
                            }

                            Column {
                                anchors.left: parent.left
                                anchors.leftMargin: 40
                                anchors.right: parent.right
                                anchors.verticalCenter: parent.verticalCenter

                                Text {
                                    text: gestureRow.gesture
                                    textFormat: Text.PlainText
                                    color: Theme.colorSubText
                                    font.pixelSize: Theme.fontSizeContentVerySmall
                                }
                                Text {
                                    text: gestureRow.action
                                    textFormat: Text.PlainText
                                    color: Theme.colorText
                                    font.pixelSize: Theme.fontSizeContent
                                    font.weight: Font.DemiBold
                                }
                            }

                            Rectangle { // separator
                                anchors.left: parent.left
                                anchors.right: parent.right
                                anchors.bottom: parent.bottom
                                height: 1
                                visible: (gestureRow.index < 4)
                                color: Theme.colorSeparator
                            }
                        }
                    }
                }
            }

            FrameSolid {
                width: Math.min(480, contentColumn.width - Theme.componentMarginXL * 2)

                title: qsTr("No icon, custom colors")
                colorHeader: Theme.colorSecondary
                colorBackground: Theme.colorBackground

                Text {
                    width: parent.width
                    text: LoremIpsum.paragraph
                    textFormat: Text.PlainText
                    color: Theme.colorText
                    font.pixelSize: Theme.fontSizeContent
                    wrapMode: Text.WordWrap
                }
            }
        }

        ListTitle { ////////////////////////////////////////////////////////////
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

        ListTitle { ////////////////////////////////////////////////////////////
            anchors.leftMargin: singleColumn ? 0 : Theme.componentMargin
            anchors.rightMargin: singleColumn ? 0 : Theme.componentMargin

            text: qsTr("FrameStack")
            source: ""
        }

        Flow {
            anchors.left: parent.left
            anchors.leftMargin: Theme.componentMarginXL
            anchors.right: parent.right
            anchors.rightMargin: Theme.componentMarginXL
            spacing: Theme.componentMarginXL

            Repeater {
                model: [ false, true ]

                delegate: FrameStackColumn {
                    required property bool modelData

                    width: Math.min(440, contentColumn.width - Theme.componentMarginXL * 2)
                    joined: modelData

                    FrameStackItem {
                        title: qsTr("Account Snapshot")
                        text: qsTr("Active seats, usage limits, and billing status are ready for review.")
                    }
                    FrameStackItem {
                        title: qsTr("Team Activity")
                        text: qsTr("24 members signed in this week with no unresolved security alerts.")
                    }
                }
            }
        }

        Flow {
            anchors.left: parent.left
            anchors.leftMargin: Theme.componentMarginXL
            anchors.right: parent.right
            anchors.rightMargin: Theme.componentMarginXL
            spacing: Theme.componentMarginXL

            Repeater {
                model: [ false, true ]

                delegate: FrameStackRow {
                    required property bool modelData

                    width: Math.min(720, contentColumn.width - Theme.componentMarginXL * 2)
                    joined: modelData

                    FrameStackItem {
                        title: qsTr("Seats")
                        text: qsTr("42 of 50 in use.")
                    }
                    FrameStackItem {
                        title: qsTr("Storage")
                        text: qsTr("68% of the quota used, with room to grow until next quarter.")
                    }
                    FrameStackItem {
                        title: qsTr("Billing")
                        text: qsTr("Next invoice on the 1st.")
                    }
                }
            }
        }

        ListTitle { ////////////////////////////////////////////////////////////
            anchors.leftMargin: singleColumn ? 0 : Theme.componentMargin
            anchors.rightMargin: singleColumn ? 0 : Theme.componentMargin

            text: qsTr("List elements")
            source: ""
        }

        Column {
            anchors.left: parent.left
            anchors.leftMargin: singleColumn ? 0 : Theme.componentMarginXL
            anchors.right: parent.right
            anchors.rightMargin: singleColumn ? 0 : Theme.componentMarginXL

            Repeater {
                model: ListModel {
                    ListElement {
                        title: "Wireless"
                        subtitle: "Connected"
                        icon: "qrc:/IconLibrary/material-symbols/link.svg"
                    }
                    ListElement {
                        title: "Storage"
                        subtitle: "128 GB available"
                        icon: "qrc:/IconLibrary/material-icons/duotone/speed.svg"
                    }
                    ListElement {
                        title: "Appearance"
                        subtitle: "Theme and colors"
                        icon: "qrc:/IconLibrary/material-icons/duotone/style.svg"
                    }
                }

                delegate: ListElementThemed {
                    width: parent.width

                    text: model.title
                    subtitle: model.subtitle
                    source: model.icon
                }
            }
        }

        ListTitle { ////////////////////////////////////////////////////////////
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

        ////////////////////////////////////////////////////////////////////////
    }
}
