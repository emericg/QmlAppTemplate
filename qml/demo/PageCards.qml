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

            text: qsTr("Cards")
            source: ""
        }

        Flow {
            anchors.left: parent.left
            anchors.leftMargin: Theme.componentMarginXL
            anchors.right: parent.right
            anchors.rightMargin: Theme.componentMarginXL
            spacing: Theme.componentMarginXL

            Repeater {
                model: ListModel {
                    ListElement {
                        title: "Colors"
                        subtitle: "Predefined colors and palettes."
                        accent: "#9C27B0" // colorMaterialPurple
                        icon: "qrc:/IconLibrary/material-icons/duotone/style.svg"
                    }
                    ListElement {
                        title: "Buttons"
                        subtitle: "So many buttons to press."
                        accent: "#2196F3" // colorMaterialBlue
                        icon: "qrc:/IconLibrary/material-icons/duotone/touch_app.svg"
                    }
                    ListElement {
                        title: "Sliders"
                        subtitle: "Drag, slide and range."
                        accent: "#009688" // colorMaterialTeal
                        icon: "qrc:/IconLibrary/material-symbols/sort.svg"
                    }
                }

                delegate: CardBox {
                    width: 240

                    colorForeground: model.accent
                    sourceIcon: model.icon

                    Column {
                        width: parent.width
                        spacing: Theme.componentMarginS

                        Text {
                            width: parent.width
                            text: model.title
                            color: Theme.colorText
                            font.pixelSize: Theme.fontSizeContentBig
                            font.bold: true
                            elide: Text.ElideRight
                        }
                        Text {
                            width: parent.width
                            text: model.subtitle
                            color: Theme.colorSubText
                            font.pixelSize: Theme.fontSizeContentSmall
                            wrapMode: Text.WordWrap
                        }
                        ButtonWireframe {
                            text: qsTr("Open")
                            colorText: model.accent
                            colorBorder: model.accent
                        }
                    }
                }
            }
        }

        ////////////////

        ListTitle {
            anchors.leftMargin: singleColumn ? 0 : Theme.componentMargin
            anchors.rightMargin: singleColumn ? 0 : Theme.componentMargin

            text: qsTr("List elements")
            source: ""
        }

        FrameThemed {
            anchors.left: parent.left
            anchors.leftMargin: Theme.componentMarginXL
            anchors.right: parent.right
            anchors.rightMargin: Theme.componentMarginXL

            padding: 0

            Column {
                width: parent.width

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
        }

        ////////////////
    }
}
