import QtQuick
import QtQuick.Layouts

import ThemeEngine

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
            screenPlayground.item.backAction()
    }

    ////////////////////////////////////////////////////////////////////////////

    active: false
    asynchronous: false

    sourceComponent: Item {
        anchors.fill: parent
        anchors.margins: 32

        //
    }

    ////////////////////////////////////////////////////////////////////////////
}
