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

        ListTitle { ////////////////////////////////////////////////////////////
            anchors.leftMargin: singleColumn ? 0 : Theme.componentMargin
            anchors.rightMargin: singleColumn ? 0 : Theme.componentMargin

            text: qsTr("GradientPresets")
            source: ""
        }

        Flow {
            anchors.left: parent.left
            anchors.leftMargin: Theme.componentMarginXL
            anchors.right: parent.right
            anchors.rightMargin: Theme.componentMarginXL
            spacing: Theme.componentMarginXL

            Repeater {
                model: GradientPresets.names

                delegate: GradientRectangle {
                    width: 240
                    height: 160
                    radius: Theme.componentRadius

                    required property string modelData
                    stops: GradientPresets.preset(modelData)
                    angle: 135

                    Text {
                        anchors.left: parent.left
                        anchors.bottom: parent.bottom
                        anchors.margins: Theme.componentMargin

                        text: parent.modelData
                        font.pixelSize: Theme.fontSizeContentSmall
                        font.bold: true
                        color: "white"
                    }
                }
            }
        }

        ListTitle { ////////////////////////////////////////////////////////////
            anchors.leftMargin: singleColumn ? 0 : Theme.componentMargin
            anchors.rightMargin: singleColumn ? 0 : Theme.componentMargin

            text: qsTr("GradientRectangle")
            source: ""
        }

        Flow {
            anchors.left: parent.left
            anchors.leftMargin: Theme.componentMarginXL
            anchors.right: parent.right
            anchors.rightMargin: Theme.componentMarginXL
            spacing: Theme.componentMarginXL

            Repeater {
                model: [
                    { label: "Linear 0°",   type: GradientPresets.Linear,  angle: 0 },
                    { label: "Linear 45°",  type: GradientPresets.Linear,  angle: 45 },
                    { label: "Linear 90°",  type: GradientPresets.Linear,  angle: 90 },
                    { label: "Linear 135°", type: GradientPresets.Linear,  angle: 135 },
                    { label: "Radial",      type: GradientPresets.Radial,  angle: 0 }
                ]

                delegate: GradientRectangle {
                    width: 240
                    height: 160
                    radius: Theme.componentRadius

                    required property var modelData
                    type: modelData.type
                    angle: modelData.angle
                    stops: GradientPresets.grape

                    Text {
                        anchors.left: parent.left
                        anchors.bottom: parent.bottom
                        anchors.margins: Theme.componentMargin

                        text: parent.modelData.label
                        font.pixelSize: Theme.fontSizeContentSmall
                        font.bold: true
                        color: "white"
                    }
                }
            }
        }

        ListTitle { ////////////////////////////////////////////////////////////
            anchors.leftMargin: singleColumn ? 0 : Theme.componentMargin
            anchors.rightMargin: singleColumn ? 0 : Theme.componentMargin

            text: qsTr("GradientComponent")
            source: ""
        }

        Flow {
            anchors.left: parent.left
            anchors.leftMargin: Theme.componentMarginXL
            anchors.right: parent.right
            anchors.rightMargin: Theme.componentMarginXL
            spacing: Theme.componentMarginXL

            GradientComponent {
                width: 400
                height: 320
                radius: Theme.componentRadius

                type: GradientPresets.Linear
                stops: GradientPresets.sunset
                angle: 135

                texture: "qrc:/ComponentLibraryAssets/patterns/dots.svg"
                textureTileSize: 32
                textureOpacity: 0.32
                textureColor: "white"

                Text {
                    anchors.centerIn: parent
                    text: qsTr("dots")
                    font.pixelSize: Theme.fontSizeContentBig
                    font.bold: true
                    color: "white"
                }
            }

            GradientComponent {
                width: 400
                height: 320
                radius: Theme.componentRadius

                type: GradientPresets.Linear
                stops: GradientPresets.cosmic

                texture: "qrc:/ComponentLibraryAssets/patterns/truchet-contours.svg"
                textureTileSize: 256
                textureOpacity: 0.20
                textureColor: "white"

                Text {
                    anchors.centerIn: parent

                    text: qsTr("truchet")
                    font.pixelSize: Theme.fontSizeContentBig
                    font.bold: true
                    color: "white"
                }
            }

            GradientComponent {
                width: 400
                height: 320
                radius: Theme.componentRadius

                type: GradientPresets.Linear
                stops: GradientPresets.forest
                angle: 135

                texture: "qrc:/ComponentLibraryAssets/patterns/topography.svg"
                textureTileSize: 256
                textureOpacity: 0.16

                Text {
                    anchors.centerIn: parent
                    text: qsTr("topo")
                    color: "white"
                    font.pixelSize: Theme.fontSizeContentBig
                    font.bold: true
                }
            }

            GradientComponent {
                width: 400
                height: 320
                radius: Theme.componentRadius

                type: GradientPresets.Linear
                stops: GradientPresets.lagoon

                texture: "qrc:/ComponentLibraryAssets/patterns/cubes-lines.svg"
                textureTileSize: 96
                textureOpacity: 0.12
                textureColor: "white"

                Text {
                    anchors.centerIn: parent

                    text: qsTr("cubes-lines")
                    font.pixelSize: Theme.fontSizeContentBig
                    font.bold: true
                    color: "white"
                }
            }

            GradientComponent {
                width: 400
                height: 320
                radius: Theme.componentRadius

                type: GradientPresets.Linear
                stops: GradientPresets.slate

                texture: "qrc:/ComponentLibraryAssets/patterns/maze.svg"
                textureTileSize: 96
                textureOpacity: 0.12
                textureColor: "grey"

                Text {
                    anchors.centerIn: parent

                    text: qsTr("maze")
                    font.pixelSize: Theme.fontSizeContentBig
                    font.bold: true
                    color: "white"
                }
            }

            GradientComponent {
                width: 400
                height: 320
                radius: Theme.componentRadius

                type: GradientPresets.Linear
                stops: GradientPresets.lavender

                texture: "qrc:/ComponentLibraryAssets/patterns/basketweave.svg"
                textureTileSize: 96
                textureOpacity: 0.12
                textureColor: "grey"

                Text {
                    anchors.centerIn: parent

                    text: qsTr("basketweave")
                    font.pixelSize: Theme.fontSizeContentBig
                    font.bold: true
                    color: "white"
                }
            }
        }

        ////////////////////////////////////////////////////////////////////////
    }
}
