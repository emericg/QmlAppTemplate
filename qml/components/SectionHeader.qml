import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import QtQuick.Templates as T
import QtQuick.Controls.impl

import ComponentLibrary

Item {
    id: control

    anchors.left: parent.left
    anchors.leftMargin: Theme.singleColumn ? 0 : Theme.componentMargin
    anchors.right: parent.right
    anchors.rightMargin: Theme.singleColumn ? 0 : Theme.componentMargin

    height: heightHeader

    property int heightHeader: 64
    property int headerPosition: 64

    // settings
    property color backgroundColor: Theme.colorBackground
    property color borderColor: Theme.colorComponentBorder
    property color shadowColor: "#11000000"
    property bool shadow: !Theme.singleColumn

    // icon
    property url source
    property int sourceSize: 36
    property int sourceRotation: 0
    property color sourceColor: Theme.colorIcon

    // text
    property string text: "title"
    property color textColor: Theme.colorText
    property int textSize: source.length ? Theme.fontSizeContentBig : Theme.fontSizeContentVeryBig
    property bool textBold: false

    ////////////////

    Rectangle { // background
        anchors.fill: parent

        radius: 8
        color: control.backgroundColor
        border.width: Theme.singleColumn ? 0 : Theme.componentBorderWidth
        border.color: control.borderColor

        ////////

        RowLayout { // right row
            anchors.right: parent.right
            anchors.rightMargin: 0
            spacing: Theme.componentMarginL
            height: control.heightHeader
/*
            ButtonSimple {
                Layout.maximumWidth: 256
                Layout.preferredHeight: control.heightHeader

                visible: isDesktop

                colorBackground: Theme.colorSubText

                source: "qrc:/IconLibrary/material-symbols/hardware/cable.svg"
                text: qsTr("USB scanning...")
            }

            Rectangle {
                width: Math.max(272, rowBLE.width + Theme.componentMargin*2)
                height: parent.height

                color: mouseareaBLE.containsPress ?
                           Qt.darker(Theme.isLight ? "#f6f6f6" : "#3a3a3a", 1.05) :
                           Theme.isLight ? "#f6f6f6" : "#3a3a3a"

                ////

                MouseArea {
                    id: mouseareaBLE
                    anchors.fill: parent
                    onClicked: control.contentShown = !control.contentShown
                }

                ////

                Row {
                    id: rowBLE
                    anchors.centerIn: parent
                    spacing: Theme.componentMargin

                    IconSvg {
                        anchors.verticalCenter: parent.verticalCenter
                        width: 32
                        height: 32

                        fillMode: Image.PreserveAspectFit
                        color: Theme.colorSubText
                        source: "qrc:/assets/gfx/icons-lucide/bluetooth.svg"
                    }

                    Text {
                        anchors.verticalCenter: parent.verticalCenter
                        text: qsTr("Bluetooth scanning...")
                        textFormat: Text.PlainText
                        font.pixelSize: Theme.fontSizeContentBig
                        color: Theme.colorText
                    }
                }

                ////
            }
*/
        }

        ////////
/*
        layer.enabled: false
        layer.effect: MultiEffect { // mask
            maskEnabled: true
            maskInverted: false
            maskThresholdMin: 0.5
            maskSpreadAtMin: 1.0
            maskSpreadAtMax: 0.0
            maskSource: ShaderEffectSource {
                sourceItem: Rectangle {
                    x: 2
                    y: 2
                    width: control.width
                    height: control.height
                    radius: 8
                }
            }
        }
*/
        layer.enabled: control.shadow
        layer.effect: MultiEffect { // shadow
            autoPaddingEnabled: true
            shadowEnabled: true
            shadowColor: control.shadowColor
        }


        ////////
    }

    ////////////////

    Item { // content
        RowLayout { // left row
            anchors.left: parent.left
            anchors.leftMargin: Theme.componentMarginXL
            spacing: Theme.componentMarginL
            height: control.heightHeader

            IconSvg {
                Layout.preferredWidth: control.sourceSize
                Layout.preferredHeight: control.sourceSize
                Layout.alignment: Qt.AlignVCenter

                fillMode: Image.PreserveAspectFit
                color: Theme.colorIcon
                source: control.source
            }

            Text {
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignVCenter

                text: control.text
                color: Theme.colorText
                font.pixelSize: Theme.fontSizeContentVeryBig
                wrapMode: Text.Wrap
            }
        }
    }

    ////////////////
}
