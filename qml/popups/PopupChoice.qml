import QtQuick
import QtQuick.Controls.impl
import QtQuick.Templates as T

import ThemeEngine

T.Popup {
    id: popupChoice
    x: singleColumn ? 0 : (appWindow.width / 2) - (width / 2)
    y: singleColumn ? (appWindow.height - height) : ((appWindow.height / 2) - (height / 2))

    width: singleColumn ? parent.width : 640
    height: columnContent.height + padding*2
    padding: Theme.componentMarginXL

    parent: appWindow.contentItem
    modal: true
    focus: true
    closePolicy: T.Popup.CloseOnEscape | T.Popup.CloseOnPressOutside

    signal confirmed()

    ////////////////////////////////////////////////////////////////////////////

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
    }

    ////////////////////////////////////////////////////////////////////////////

    contentItem: Item {
        Column {
            id: columnContent
            width: parent.width
            spacing: Theme.componentMarginXL

            Text {
                width: parent.width

                text: qsTr("Are you sure you want to delete data for this sensor?")
                textFormat: Text.PlainText
                font.pixelSize: Theme.fontSizeContentVeryBig
                color: Theme.colorText
                wrapMode: Text.WordWrap
            }

            Text {
                width: parent.width

                text: qsTr("You can either delete data from the application, or from both the sensor and application.")
                textFormat: Text.PlainText
                font.pixelSize: Theme.fontSizeContent
                color: Theme.colorSubText
                wrapMode: Text.WordWrap
            }

            Flow {
                id: flowContent
                width: parent.width
                height: singleColumn ? 40*3 + 2*spacing : 40

                property var btnSize: singleColumn ? width : ((width-spacing*2) / 3)
                spacing: Theme.componentMargin

                ButtonWireframe {
                    width: parent.btnSize

                    text: qsTr("Cancel")
                    primaryColor: Theme.colorSubText
                    secondaryColor: Theme.colorForeground

                    onClicked: popupChoice.close()
                }
                ButtonWireframe {
                    width: parent.btnSize

                    text: qsTr("Delete local data")
                    primaryColor: Theme.colorWarning
                    fullColor: true

                    onClicked: {
                        if (selectedDevice) {
                            selectedDevice.actionClearData()
                        }
                        popupChoice.confirmed()
                        popupChoice.close()
                    }
                }
                ButtonWireframe {
                    width: parent.btnSize

                    text: qsTr("Delete sensor data")
                    primaryColor: Theme.colorError
                    fullColor: true

                    onClicked: {
                        if (selectedDevice) {
                             selectedDevice.actionClearDeviceData()
                        }
                        popupChoice.confirmed()
                        popupChoice.close()
                    }
                }
            }
        }
    }

    ////////////////////////////////////////////////////////////////////////////
}
