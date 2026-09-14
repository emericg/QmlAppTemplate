import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import ComponentLibrary

Loader {
    id: screenPlayground
    anchors.fill: parent

    function loadScreen() {
        // load screen
        screenPlayground.active = true

        // change screen
        appContent.state = "Playground"
    }

    function backAction() {
        if (screenPlayground.status === Loader.Ready)
            return screenPlayground.item.backAction()

        return false
    }

    ////////////////////////////////////////////////////////////////////////////

    active: false
    asynchronous: false

    sourceComponent: Item {
        anchors.fill: parent
        anchors.margins: 32

        ////////

        function backAction() {
            return false
        }

        ////////
    }

    ////////////////////////////////////////////////////////////////////////////
}
