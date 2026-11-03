import QtQuick

import ComponentLibrary
import AppUtils

Item {
    id: screenPermissions
    anchors.fill: parent

    property string entryPoint: "ScreenAbout"

    ////////////////////////////////////////////////////////////////////////////

    function loadScreen() {
        // Refresh permissions
        refreshPermissions()

        // Change screen
        appContent.state = "ScreenAboutPermissions"
    }

    function loadScreenFrom(screenname) {
        entryPoint = screenname
        loadScreen()
    }

    function backAction() {
        screenAbout.loadScreen()
    }

    function refreshPermissions() {
        // Refresh permissions
    }

    Timer {
        id: retryPermissions
        interval: 333
        repeat: false
        onTriggered: screenPermissions.refreshPermissions()
    }

    ////////////////////////////////////////////////////////////////////////////

    Flickable {
        anchors.fill: parent

        contentWidth: -1
        contentHeight: contentColumn.height

        Column {
            id: contentColumn

            anchors.left: parent.left
            anchors.right: parent.right

            topPadding: Theme.componentMarginXXL
            bottomPadding: Theme.componentMarginXXL
            spacing: Theme.componentMarginL

            ListSeparator { } //////////////////////////////////////////////////

            ListItemPermission { // element_network
                anchors.left: parent.left
                anchors.right: parent.right

                text: qsTr("Internet access")
                legend: qsTr("Internet access is used to send kitten pictures around the world map.")
                status: true

                onClicked: {
                    retryPermissions.start()
                }
            }

            ListSeparator { } //////////////////////////////////////////////////

            ListItemPermission { // element_camera
                id: button_camera_test
                anchors.left: parent.left
                anchors.right: parent.right

                text: qsTr("Camera")
                legend: qsTr("Camera is used to take kittens photos.")
                status: false

                onClicked: {
                    UtilsOS.hapticFeedback()
                    UtilsOS.getMobileCameraPermission()
                    retryPermissions.start()
                }
            }

            ListSeparator { } //////////////////////////////////////////////////

            ListItemPermission { // element_position
                id: button_location_test
                anchors.left: parent.left
                anchors.right: parent.right

                text: qsTr("Position (GPS)")
                legend: qsTr("You can save GPS position of all the kittens you saw.")
                status: true

                onClicked: {
                    UtilsOS.hapticFeedback()
                    UtilsOS.getMobileLocationPermission()
                    retryPermissions.start()
                }
            }

            ListSeparator { } //////////////////////////////////////////////////

            ListItemPermissionInfo { // element_infos
                anchors.left: parent.left
                anchors.right: parent.right

                applicationID: "io.emeric.qmlapptemplate"
            }

            ////////////////////////////////////////////////////////////////////
        }
    }

    ////////////////////////////////////////////////////////////////////////////
}
