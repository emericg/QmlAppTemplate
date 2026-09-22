import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import QtQuick.Controls.impl
import QtQuick.Templates as T

import ComponentLibrary

T.Button {
    id: control

    anchors.left: parent.left
    anchors.right: parent.right
    height: Theme.componentHeightXL*2

    leftPadding: 0
    rightPadding: 0
    spacing: 12

    font.pixelSize: Theme.fontSizeContentBig
    font.bold: true

    // settings
    flat: true
    checkable: false
    hoverEnabled: isDesktop
    focusPolicy: Qt.NoFocus

    // colors
    property color color: checked ? Theme.colorPrimary : Theme.colorSidebarContent
    property color colorBackground: Qt.rgba(color.r, color.g, color.b, checked ? 0.2 : 1)
    property color colorHighlight: checked ? Theme.colorPrimary : Theme.colorSidebarHighlight
    property color colorRipple: Qt.rgba(colorHighlight.r, colorHighlight.g, colorHighlight.b, 0.16)
    property color colorBorder: colorBackground
    property color colorText: checked ? Theme.colorPrimary : Theme.colorSubText

    property color colorBarBackground: checked ?
                        Qt.rgba(Theme.colorPrimary.r, Theme.colorPrimary.g, Theme.colorPrimary.b, 0.33) :
                        Qt.rgba(Theme.colorSidebarHighlight.r, Theme.colorSidebarHighlight.g, Theme.colorSidebarHighlight.b, 0.33)

    property color colorButtonPrimary: checked ?
                        Qt.rgba(Theme.colorPrimary.r, Theme.colorPrimary.g, Theme.colorPrimary.b, 0.66) :
                        Qt.rgba(Theme.colorSidebarHighlight.r, Theme.colorSidebarHighlight.g, Theme.colorSidebarHighlight.b, 0.5)

    property color colorButtonBlue: checked ?
                        Qt.rgba(Theme.colorBlue.r, Theme.colorBlue.g, Theme.colorBlue.b, 0.77) :
                        Qt.rgba(Theme.colorSidebarHighlight.r, Theme.colorSidebarHighlight.g, Theme.colorSidebarHighlight.b, 0.5)

    property color colorButtonOrange: checked ?
                        Qt.rgba(Theme.colorOrange.r, Theme.colorOrange.g, Theme.colorOrange.b, 0.66) :
                        Qt.rgba(Theme.colorSidebarHighlight.r, Theme.colorSidebarHighlight.g, Theme.colorSidebarHighlight.b, 0.5)

    ////////////////////////////////////////////////////////////////////////////

    background: Item {
        implicitWidth: 128
        implicitHeight: Theme.componentHeightXL

        Rectangle { // background
            anchors.fill: parent
            color: control.colorBackground
        }

        RippleThemed {
            anchors.fill: parent
            anchor: control

            pressed: control.pressed
            active: control.enabled && (control.down || control.hovered || control.visualFocus)
            color: control.colorRipple

            layer.enabled: false
            layer.effect: MultiEffect {
                maskEnabled: true
                maskInverted: false
                maskThresholdMin: 0.5
                maskSpreadAtMin: 1.0
                maskSpreadAtMax: 0.0
                maskSource: ShaderEffectSource {
                    sourceItem: Rectangle {
                        x: background.x
                        y: background.y
                        width: background.width
                        height: background.height
                        radius: Theme.componentRadius
                    }
                }
            }
        }

        Rectangle { // button bar background
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom:parent.bottom
            height: Theme.componentHeight
            color: control.colorBarBackground
        }
    }

    ////////////////

    contentItem: Item {
        RowLayout {
            id: rowrowrow

            anchors.top: parent.top
            anchors.topMargin: 10
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.right: parent.right
            anchors.rightMargin: 10

            height: Theme.componentHeight
            spacing: control.spacing

            SquareButtonClear {
                Layout.preferredWidth: Theme.componentHeight
                Layout.preferredHeight: Theme.componentHeight
                Layout.alignment: Qt.AlignVCenter

                color: {
                    if (!sidebarSubMenu.checked) {
                        if (Theme.isLight) return "#999"
                        if (Theme.isDark) return Theme.colorGrey
                    }
                    return Theme.colorPrimary
                }

                source: {
                    //if (!sidebarDevice) return ""
                    //if (sidebarDevice.connected) return "qrc:/assets/gfx/icons-lucide/bluetooth-connected.svg"
                    //if (sidebarDevice.available) return "qrc:/assets/gfx/icons-lucide/bluetooth-searching.svg"
                    //if (!sidebarDevice.deviceAddress) return "qrc:/IconLibrary/material-symbols/hardware/cable.svg"

                    return "qrc:/IconLibrary/material-symbols/hardware/cable.svg"
                }
            }

            Text {
                Layout.alignment: Qt.AlignVCenter
                Layout.fillWidth: true

                color: control.colorText
                opacity: control.enabled ? 1 : 0.66

                visible: control.text
                text: control.text
                textFormat: Text.PlainText

                font: control.font
                elide: Text.ElideMiddle
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
            }
        }
    }

    ////////////////////////////////////////////////////////////////////////////

    RowLayout {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        spacing: 2
        visible: screenDevice.deviceInteractive
        enabled: control.checked && sidebarDevice

        ButtonSimple {
            height: 32
            text: qsTr("Sync")
            source: "qrc:/IconLibrary/material-symbols/swap_horiz.svg"
            sourceSize: 16
            sourceRotation: -45
            colorBackground: control.colorButtonPrimary

            visible: false // screenDevice.isConfiguratorSupported
            enabled: screenDevice.deviceConnected && sidebarDevice.configSyncNeeded
            onClicked: screenDevice.openConfigSyncPopup()
        }
        //Rectangle { width: 2; height: parent.height; } // separator

        ButtonSimple {
            height: 32
            text: qsTr("Save")
            source: "qrc:/IconLibrary/material-symbols/save.svg"
            sourceSize: 16
            colorBackground: control.colorButtonPrimary

            visible: screenDevice.isConfiguratorSupported
            enabled: screenDevice.deviceConnected && sidebarDevice.configSaveNeeded
            onClicked: screenDevice.openConfigSavePopup()
        }
        //Rectangle { width: 2; height: parent.height; } // separator

        ButtonSimple {
            height: 32
            text: qsTr("Cancel")
            source: "qrc:/IconLibrary/material-symbols/rotate_left.svg"
            sourceSize: 16
            sourceRotation: -45
            colorBackground: control.colorButtonPrimary

            visible: screenDevice.isConfiguratorSupported
            enabled: screenDevice.deviceConnected && sidebarDevice.configSaveNeeded
            onClicked: screenDevice.openConfigReloadPopup()
        }
        //Rectangle { width: 2; height: parent.height; } // separator

        ButtonSimple {
            height: 32
            text: qsTr("Update")
            source: "qrc:/IconLibrary/material-symbols/new_releases.svg"
            sourceSize: 16
            colorBackground: control.colorButtonOrange

            visible: screenDevice.isFirmwareUpdateSupported && !sidebarDevice.firmwareUpToDate
            enabled: screenDevice.deviceConnected
            onClicked: screenDevice.setFirmware()
        }
        //Rectangle { width: 2; height: parent.height; } // separator

        ButtonSimple {
            height: 32
            text: qsTr("Pair")
            source: "qrc:/assets/gfx/icons-lucide/bluetooth-searching.svg"
            sourceSize: 16
            colorBackground: control.colorButtonBlue

            visible: deviceManager.hasDevicesNearby && sidebarDevice && sidebarDevice.hasBLE && !screenDevice.devicePaired_BLE
            enabled: deviceManager.bluetooth
            onClicked: screenMainView.openBluetoothPopup()
        }
        //Rectangle { width: 2; height: parent.height; } // separator

        ButtonSimple { // clickable filler
            height: 32
            Layout.fillWidth: true
            text: ""
            source: ""
            colorBackground: "transparent"
        }
        //Rectangle { // filler
        //    height: 32
        //    Layout.fillWidth: true
        //    color: control.colorButtonPrimary
        //}
    }

    layer.enabled: true
    layer.effect: MultiEffect {
        maskEnabled: true
        maskInverted: false
        maskThresholdMin: 0.5
        maskSpreadAtMin: 1.0
        maskSpreadAtMax: 0.0
        maskSource: ShaderEffectSource {
            sourceItem: Rectangle {
                x: background.x
                y: background.y
                width: background.width
                height: background.height
                radius: Theme.componentRadius
            }
        }
    }

    ////////////////////////////////////////////////////////////////////////////
}
