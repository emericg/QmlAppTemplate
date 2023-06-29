import QtQuick
import QtQuick.Controls.impl
import QtQuick.Templates as T

import ThemeEngine

T.Popup {
    id: popupMessage
    x: singleColumn ? 0 : (appWindow.width / 2) - (width / 2)
    y: singleColumn ? (appWindow.height - height)
                    : ((appWindow.height / 2) - (height / 2))

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

                text: qsTr("Message popup title")
                textFormat: Text.PlainText
                font.pixelSize: Theme.fontSizeContentVeryBig
                color: Theme.colorText
                wrapMode: Text.WordWrap
            }

            Text {
                width: parent.width

                text: qsTr("Message popup text. This is a message, empty of any kind of meaning.")
                textFormat: Text.PlainText
                font.pixelSize: Theme.fontSizeContent
                color: Theme.colorSubText
                wrapMode: Text.WordWrap
            }

            ButtonWireframe {
                anchors.right: parent.right
                width: singleColumn ? parent.width : (parent.width / 2)

                text: qsTr("OK")
                primaryColor: Theme.colorSubText
                secondaryColor: Theme.colorForeground

                onClicked: popupMessage.close()
            }
        }
    }

    ////////////////////////////////////////////////////////////////////////////
}
