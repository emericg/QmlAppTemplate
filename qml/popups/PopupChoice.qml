import QtQuick
import QtQuick.Effects
import QtQuick.Controls

import ThemeEngine

Popup {
    id: popupChoice

    x: singleColumn ? 0 : (appWindow.width / 2) - (width / 2)
    y: singleColumn ? (appWindow.height - height)
                    : ((appWindow.height / 2) - (height / 2))

    width: singleColumn ? appWindow.width : 720
    height: columnContent.height + padding*2 + screenPaddingNavbar + screenPaddingBottom
    padding: Theme.componentMarginXL
    margins: 0

    dim: true
    modal: true
    focus: true
    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
    parent: Overlay.overlay

    signal confirmed()

    ////////////////////////////////////////////////////////////////////////////

    enter: Transition { NumberAnimation { property: "opacity"; from: 0.5; to: 1.0; duration: 133; } }
    //exit: Transition { NumberAnimation { property: "opacity"; from: 1.0; to: 0.0; duration: 200; } }

    Overlay.modal: Rectangle {
        color: "#000"
        opacity: ThemeEngine.isLight ? 0.24 : 0.666
    }

    background: Rectangle {
        color: Theme.colorBackground
        border.color: Theme.colorSeparator
        border.width: singleColumn ? 0 : Theme.componentBorderWidth
        radius: singleColumn ? 0 : Theme.componentRadius

        Rectangle {
            width: parent.width
            height: Theme.componentBorderWidth
            visible: singleColumn
            color: Theme.colorSeparator
        }

        layer.enabled: !singleColumn
        layer.effect: MultiEffect {
            autoPaddingEnabled: true
            shadowEnabled: true
            shadowColor: ThemeEngine.isLight ? "#aa000000" : "#aaffffff"
        }
    }

    ////////////////////////////////////////////////////////////////////////////

    contentItem: Item {
        Column {
            id: columnContent
            width: parent.width
            spacing: Theme.componentMarginXL

            ////////

            Text {
                width: parent.width

                text: qsTr("Are you sure you want to delete data for this sensor?")
                textFormat: Text.PlainText
                font.pixelSize: Theme.fontSizeContentVeryBig
                color: Theme.colorText
                wrapMode: Text.WordWrap
            }

            ////////

            Text {
                width: parent.width

                text: qsTr("You can either delete data from the application, or from both the sensor and application.")
                textFormat: Text.PlainText
                font.pixelSize: Theme.fontSizeContent
                color: Theme.colorSubText
                wrapMode: Text.WordWrap
            }

            ////////

            Flow {
                width: parent.width
                spacing: Theme.componentMargin

                property int btnSize: singleColumn ? width : ((width-spacing*2) / 3)

                ButtonClear {
                    width: parent.btnSize
                    color: Theme.colorGrey

                    text: qsTr("Cancel")
                    onClicked: popupChoice.close()
                }

                ButtonFlat {
                    width: parent.btnSize
                    color: Theme.colorWarning

                    text: qsTr("Delete local data")
                    onClicked: {
                        if (selectedDevice) {
                            selectedDevice.actionClearData()
                        }
                        popupChoice.confirmed()
                        popupChoice.close()
                    }
                }

                ButtonFlat {
                    width: parent.btnSize
                    color: Theme.colorError

                    text: qsTr("Delete sensor data")
                    onClicked: {
                        if (selectedDevice) {
                             selectedDevice.actionClearDeviceData()
                        }
                        popupChoice.confirmed()
                        popupChoice.close()
                    }
                }
            }

            ////////
        }
    }

    ////////////////////////////////////////////////////////////////////////////
}
