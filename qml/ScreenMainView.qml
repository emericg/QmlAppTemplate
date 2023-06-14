import QtQuick
import QtQuick.Controls

import ThemeEngine 1.0

Item {
    id: screenMainView
    anchors.fill: parent

    function loadScreen() {
        // change screen
        appContent.state = "MainView"
    }

    function backAction() {
        //
    }
}
