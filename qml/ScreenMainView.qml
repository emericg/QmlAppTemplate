import QtQuick
import QtQuick.Controls

import ThemeEngine 1.0

Item {
    id: screenMainView
    anchors.fill: parent

    function loadScreen() {
        if (isDesktop) screenDesktopComponents.loadScreen()
        else if (isMobile) screenMobileComponents.loadScreen()
        else appContent.state = "MainView"
    }

    function backAction() {
        //
    }
}
