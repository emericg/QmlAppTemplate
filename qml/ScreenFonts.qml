import QtQuick
import QtQuick.Controls

import ThemeEngine 1.0

Loader {
    id: screenFonts
    anchors.fill: parent

    function loadScreen() {
        // load screen
        screenFonts.active = true

        // change screen
        appContent.state = "FontList"
    }

    function backAction() {
        if (screenFonts.status === Loader.Ready)
            screenFonts.item.backAction()
    }

    ////////////////////////////////////////////////////////////////////////////

    active: false
    asynchronous: false

    // helper to list available fonts available on the host OS
    sourceComponent: ListView {
        anchors.fill: parent
        anchors.margins: 0

        topMargin: 16
        bottomMargin: 16

        ScrollBar.vertical: ScrollBar { }

        function backAction() {
            //
        }

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
