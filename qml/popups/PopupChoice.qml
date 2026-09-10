import QtQuick
import QtQuick.Effects
import QtQuick.Controls

import ComponentLibrary

Popup {
    id: popupChoice

    x: Theme.singleColumn ? 0 : (Theme.appWidth / 2) - (width / 2)
    y: Theme.singleColumn ? (Theme.appHeight - height)
                    : ((Theme.appHeight / 2) - (height / 2))

    width: Theme.singleColumn ? Theme.appWidth : 720
    height: columnContent.height + padding*2 + Math.max(Theme.screenPaddingNavbar, Theme.screenPaddingBottom)
    padding: Theme.componentMarginXL
    margins: 0

    dim: true
    modal: true
    focus: true
    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
    parent: Overlay.overlay

    property string title: "Popup Title"
    property string text: "This is a generic message, empty of any kind of meaning."

    property string buttonClose: qsTr("Cancel")
    property string buttonSecondary
    property string buttonPrimary: qsTr("Confirm")

    signal confirmed()
    signal confirmedPrimary()
    signal confirmedSecondary()

    ////////////////////////////////////////////////////////////////////////////

    enter: Transition { NumberAnimation { property: "opacity"; from: 0.5; to: 1.0; duration: Theme.animationFastSpeed; } }
    //exit: Transition { NumberAnimation { property: "opacity"; from: 1.0; to: 0.0; duration: Theme.animationMediumSpeed; } }

    Overlay.modal: Item {
        Rectangle {
            anchors.fill: parent
            anchors.margins: Theme.windowBorders
            radius: Theme.windowCornersRadius
            color: "#000000"
            opacity: Theme.isLight ? 0.24 : 0.48
        }
    }

    ////////////////////////////////////////////////////////////////////////////

    background: Rectangle {
        color: Theme.colorBackground
        border.color: Theme.colorSeparator
        border.width: Theme.singleColumn ? 0 : Theme.componentBorderWidth
        radius: Theme.singleColumn ? 0 : Theme.componentRadius

        Rectangle {
            anchors.left: parent.left
            anchors.right: parent.right
            height: Theme.componentBorderWidth
            visible: Theme.singleColumn
            color: Theme.colorSeparator
        }

        layer.enabled: !Theme.singleColumn
        layer.effect: MultiEffect { // shadow
            autoPaddingEnabled: true
            blurMax: 64
            shadowEnabled: true
            shadowColor: Theme.isLight ? "#aa000000" : "#cc000000"
        }
    }

    ////////////////////////////////////////////////////////////////////////////

    contentItem: Item {
        Column {
            id: columnContent
            anchors.left: parent.left
            anchors.right: parent.right
            spacing: Theme.componentMarginXL

            ////////

            Text {
                anchors.left: parent.left
                anchors.right: parent.right

                text: popupChoice.title
                font.pixelSize: Theme.fontSizeContentVeryBig
                color: Theme.colorText
                wrapMode: Text.WordWrap
            }

            ////////

            Text {
                anchors.left: parent.left
                anchors.right: parent.right

                text: popupChoice.text
                font.pixelSize: Theme.fontSizeContent
                color: Theme.colorSubText
                wrapMode: Text.WordWrap
            }

            ////////

            Flow {
                anchors.left: parent.left
                anchors.right: parent.right
                spacing: Theme.componentMargin

                property int btnCount: popupChoice.buttonSecondary ? 3 : 2
                property int btnSize: Theme.singleColumn ? width : ((width-(spacing*(btnCount-1))) / btnCount)

                ButtonClear {
                    width: parent.btnSize
                    color: Theme.colorGrey

                    text: popupChoice.buttonClose
                    onClicked: popupChoice.close()
                }

                ButtonFlat {
                    width: parent.btnSize
                    color: Theme.colorWarning

                    visible: popupChoice.buttonSecondary
                    text: popupChoice.buttonSecondary
                    onClicked: {
                        popupChoice.confirmedSecondary()
                        popupChoice.close()
                    }
                }

                ButtonFlat {
                    width: parent.btnSize
                    color: Theme.colorError

                    text: popupChoice.buttonPrimary
                    onClicked: {
                        popupChoice.confirmedPrimary()
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
