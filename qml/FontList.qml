import QtQuick 2.15
import QtQuick.Controls 2.15

import ThemeEngine 1.0

Item {
    id: screenFontList
    width: 1280
    height: 720

    // helper to list available fonts
    ListView {
        anchors.fill: parent
        anchors.margins: 0
        ScrollBar.vertical: ScrollBar { }

        topMargin: 16
        bottomMargin: 16

        model: Qt.fontFamilies()

        delegate: Item {
            height: 24
            width: ListView.view.width

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
}
