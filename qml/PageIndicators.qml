import QtQuick
import QtQuick.Controls

import ThemeEngine

Flickable {
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

            text: qsTr("Progress bars")
            source: ""
        }

        Column {
            anchors.left: parent.left
            anchors.leftMargin: Theme.componentMarginXL
            anchors.right: parent.right
            anchors.rightMargin: Theme.componentMarginXL
            spacing: Theme.componentMarginXL

            ProgressBarThemed {
                anchors.left: parent.left
                anchors.right: parent.right

                value: 0.5
            }
        }

        ListTitle { ////////////////////////////////////////////////////////////
            anchors.leftMargin: singleColumn ? 0 : Theme.componentMargin
            anchors.rightMargin: singleColumn ? 0 : Theme.componentMargin

            text: qsTr("Data bars")
            source: ""
        }

        Column {
            anchors.left: parent.left
            anchors.leftMargin: Theme.componentMarginXL
            anchors.right: parent.right
            anchors.rightMargin: Theme.componentMarginXL
            spacing: Theme.componentMarginXL

            DataBarCompact {
                anchors.left: parent.left
                anchors.right: parent.right

                value: 33

                legend: ""
                prefix: ""
                suffix: " cm"
                colorForeground: Theme.colorBlue
            }

            DataBarSolid {
                anchors.left: parent.left
                anchors.right: parent.right

                value: 66

                legend: ""
                prefix: ""
                suffix: "°"
                colorForeground: Theme.colorRed
            }
        }

        ListTitle { ////////////////////////////////////////////////////////////
            anchors.leftMargin: singleColumn ? 0 : Theme.componentMargin
            anchors.rightMargin: singleColumn ? 0 : Theme.componentMargin

            text: qsTr("Other indicators")
            source: ""
        }

        Column {
            anchors.left: parent.left
            anchors.leftMargin: Theme.componentMarginXL
            anchors.right: parent.right
            anchors.rightMargin: Theme.componentMarginXL
            spacing: Theme.componentMarginXL

            Row {
                spacing: Theme.componentMarginXL

                ProgressArc {
                    width: 128
                    value: 0.33
                }

                ProgressArc {
                    width: 128
                    value: 0.66
                    arcCap: "round"
                    arcColor: Theme.colorMaterialLime
                }
            }

            Row {
                spacing: Theme.componentMarginXL

                ProgressCircle {
                    width: 128
                    value: 0.33
                    arcColor: Theme.colorMaterialDeepOrange
                }

                ProgressCircle {
                    width: 128
                    value: 0.66
                    isPie: true
                }
            }
        }

        ListTitle { ////////////////////////////////////////////////////////////
            anchors.leftMargin: singleColumn ? 0 : Theme.componentMargin
            anchors.rightMargin: singleColumn ? 0 : Theme.componentMargin

            text: qsTr("Other stuff")
            source: ""
        }

        Column {
            anchors.left: parent.left
            anchors.leftMargin: Theme.componentMarginXL
            anchors.right: parent.right
            anchors.rightMargin: Theme.componentMarginXL
            spacing: Theme.componentMarginXL

            ItemLicenseBadge {
                width: 128
                legend: "license"
                text: "LGPL 3"
                onClicked: Qt.openUrlExternally("https://www.gnu.org/licenses/lgpl-3.0.html")
            }

            Row {
                spacing: 8

                TagButtonClear {
                    text: "TAG"
                    //color: Theme.colorForeground
                }

                TagButtonFlat {
                    text: "TAG"
                    //color: Theme.colorForeground
                }
            }

            Row {
                spacing: 8

                ItemBadge {
                    text: "4"
                    color: Theme.colorMaterialDeepOrange
                }
                Text {
                    text: "Notifications badge"
                    color: Theme.colorText
                    font.pixelSize: Theme.componentFontSize
                }
            }

            Flow {
                anchors.left: parent.left
                anchors.right: parent.right
                spacing: Theme.componentMargin

                ItemTagClear {
                    text: "tag"
                    color: Theme.colorMaterialGreen
                }

                ItemTagClear {
                    text: "tag"
                    color: Theme.colorMaterialBlue
                }

                ItemTagClear {
                    text: "tag"
                    color: Theme.colorMaterialRed
                }

                ItemTagClear {
                    text: "tag"
                    color: Theme.colorMaterialDeepPurple
                }

                ItemTagClear {
                    text: "tag"
                    color: Theme.colorMaterialGrey
                }
            }

            Flow {
                anchors.left: parent.left
                anchors.right: parent.right
                spacing: Theme.componentMargin

                ItemTagFlat {
                    text: "tag"
                    color: Theme.colorMaterialGreen
                }

                ItemTagFlat {
                    text: "tag"
                    color: Theme.colorMaterialBlue
                }

                ItemTagFlat {
                    text: "tag"
                    color: Theme.colorMaterialRed
                }

                ItemTagFlat {
                    text: "tag"
                    color: Theme.colorMaterialDeepPurple
                }

                ItemTagFlat {
                    text: "tag"
                    color: Theme.colorMaterialGrey
                }
            }

            Flow {
                anchors.left: parent.left
                anchors.right: parent.right
                spacing: Theme.componentMargin

                ItemTagDesktop {
                    text: "tag"
                }

                ItemTagDesktop {
                    text: "TAG"
                }

                ItemTagDesktop {
                    text: "rgehetqthshrts"
                }

                ItemTagDesktop {
                    width: 64
                    text: "rgehetqthshrts"
                }
            }
        }
    }
}
