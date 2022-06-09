import QtQuick 2.15
import QtQuick.Controls 2.15

import ThemeEngine 1.0

Item {
    id: screenFontList
    width: 1280
    height: 720

    ////////////////////////////////////////////////////////////////////////////

    // helper to list available fonts available on the host OS
    ListView {
        anchors.fill: parent
        anchors.margins: 0
        ScrollBar.vertical: ScrollBar { }

        topMargin: 16
        bottomMargin: 16

        header: Rectangle {
            height: 40
            width: parent.width

            color: Theme.colorForeground

            Text {
                anchors.left: parent.left
                anchors.leftMargin: 16
                anchors.verticalCenter: parent.verticalCenter

                text: "Available fonts:"
                font.pixelSize: Theme.fontSizeContentBig
                font.bold: true
                color: Theme.colorText
            }
        }

        model: Qt.fontFamilies()
        delegate: Rectangle {
            height: 32
            width: ListView.view.width

            color: (index % 2) ? Theme.colorForeground :Theme.colorBackground

            Text {
                anchors.left: parent.left
                anchors.leftMargin: 16
                anchors.verticalCenter: parent.verticalCenter

                text: modelData
                font.pixelSize: Theme.fontSizeComponent
                color: Theme.colorText
            }
        }
    }

    ////////////////////////////////////////////////////////////////////////////
}
