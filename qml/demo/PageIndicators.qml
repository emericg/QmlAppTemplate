import QtQuick
import QtQuick.Controls

import ComponentLibrary

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

        SliderThemed {
            id: mainValue
            anchors.left: parent.left
            anchors.leftMargin: Theme.componentMarginXL
            anchors.right: parent.right
            anchors.rightMargin: Theme.componentMarginXL

            from: 0
            to: 1
            value: 0.5
        }

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

                value: mainValue.value
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

                value: mainValue.value*100

                legend: ""
                prefix: ""
                suffix: " cm"
                colorForeground: Theme.colorBlue
            }

            DataBarSolid {
                anchors.left: parent.left
                anchors.right: parent.right

                value: mainValue.value*100

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

        Flow {
            anchors.left: parent.left
            anchors.leftMargin: Theme.componentMarginXL
            anchors.right: parent.right
            anchors.rightMargin: Theme.componentMarginXL
            spacing: Theme.componentMarginXL

            Row {
                spacing: Theme.componentMarginXL

                ProgressArc {
                    width: 128
                    value: mainValue.value
                }

                ProgressArc {
                    width: 128
                    value: mainValue.value
                    arcCap: Qt.RoundCap
                    arcColor: Theme.colorMaterialLime
                }
            }

            Row {
                spacing: Theme.componentMarginXL

                ProgressCircle {
                    width: 128
                    value: mainValue.value
                    arcColor: Theme.colorMaterialDeepOrange
                }

                ProgressCircle {
                    width: 128
                    value: mainValue.value
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

            Row {
                spacing: Theme.componentMargin

                ItemLicenseBadge {
                    width: 128
                    legend: "license"
                    text: "LGPL 3"
                    onClicked: Qt.openUrlExternally("https://www.gnu.org/licenses/lgpl-3.0.html")
                }

                CardTagClearIcon {
                    text: "license"
                }

                CardTagLabel {
                    text: "license"
                }
            }

            Row {
                spacing: Theme.componentMargin

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
                spacing: Theme.componentMargin

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

                TagClear {
                    text: "tag"
                    color: Theme.colorMaterialGreen
                }

                TagClear {
                    text: "tag"
                    color: Theme.colorMaterialBlue
                }

                TagClear {
                    text: "tag"
                    color: Theme.colorMaterialRed
                }

                TagClear {
                    text: "tag"
                    color: Theme.colorMaterialDeepPurple
                }

                TagClear {
                    text: "tag"
                    color: Theme.colorMaterialGrey
                }
            }

            Flow {
                anchors.left: parent.left
                anchors.right: parent.right
                spacing: Theme.componentMargin

                TagFlat {
                    text: "tag"
                    color: Theme.colorMaterialGreen
                }

                TagFlat {
                    text: "tag"
                    color: Theme.colorMaterialBlue
                }

                TagFlat {
                    text: "tag"
                    color: Theme.colorMaterialRed
                }

                TagFlat {
                    text: "tag"
                    color: Theme.colorMaterialDeepPurple
                }

                TagFlat {
                    text: "tag"
                    color: Theme.colorMaterialGrey
                }
            }

            Flow {
                anchors.left: parent.left
                anchors.right: parent.right
                spacing: Theme.componentMargin

                TagDesktop {
                    text: "tag"
                }

                TagDesktop {
                    text: "TAG"
                }

                TagDesktop {
                    text: "rgehetqthshrts"
                }

                TagDesktop {
                    width: 64
                    text: "rgehetqthshrts"
                }
            }
        }

        ////////////////////////////////////////////////////////////////////////
    }
}
