import QtQuick
import QtQuick.Layouts

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

            Column { // element_network
                anchors.left: parent.left
                anchors.right: parent.right

                Row {
                    anchors.left: parent.left
                    anchors.leftMargin: Theme.componentMarginL
                    anchors.right: parent.right
                    anchors.rightMargin: Theme.componentMarginL
                    spacing: Theme.componentMarginL

                    RoundButtonFlat {
                        anchors.verticalCenter: parent.verticalCenter
                        width: 32
                        height: 32

                        property bool validperm: true

                        source: (validperm) ? "qrc:/IconLibrary/material-symbols/check.svg" : "qrc:/IconLibrary/material-symbols/close.svg"
                        color: (validperm) ? Theme.colorPrimary : Theme.colorSubText
                        colorIcon: (validperm) ? "white" : "white"
                    }

                    Text {
                        anchors.verticalCenter: parent.verticalCenter

                        text: qsTr("Internet access")
                        textFormat: Text.PlainText
                        wrapMode: Text.WordWrap
                        font.pixelSize: Theme.fontSizeContentBig
                        color: Theme.colorText
                        verticalAlignment: Text.AlignVCenter
                    }
                }

                Text { // legend_network
                    anchors.left: parent.left
                    anchors.leftMargin: 32 + Theme.componentMarginL*2
                    anchors.right: parent.right
                    anchors.rightMargin: Theme.componentMarginL

                    text: qsTr("Internet access is used to send kitten pictures around the world map.")
                    textFormat: Text.PlainText
                    wrapMode: Text.WordWrap
                    color: Theme.colorSubText
                    font.pixelSize: Theme.fontSizeContentSmall
                }
            }

            ListSeparator { } //////////////////////////////////////////////////

            Column { // element_camera
                anchors.left: parent.left
                anchors.right: parent.right

                Row {
                    anchors.left: parent.left
                    anchors.leftMargin: Theme.componentMarginL
                    anchors.right: parent.right
                    anchors.rightMargin: Theme.componentMarginL
                    spacing: Theme.componentMarginL

                    RoundButtonFlat {
                        id: button_camera_test
                        anchors.verticalCenter: parent.verticalCenter
                        width: 32
                        height: 32

                        property bool validperm: false

                        source: (validperm) ? "qrc:/IconLibrary/material-symbols/check.svg" : "qrc:/IconLibrary/material-symbols/close.svg"
                        color: (validperm) ? Theme.colorPrimary : Theme.colorSubText
                        colorIcon: (validperm) ? "white" : "white"

                        onClicked: {
                            UtilsOS.hapticFeedback()
                            UtilsOS.getMobileCameraPermission()
                            retryPermissions.start()
                        }
                    }

                    Text {
                        anchors.verticalCenter: parent.verticalCenter

                        text: qsTr("Camera")
                        textFormat: Text.PlainText
                        wrapMode: Text.WordWrap
                        font.pixelSize: Theme.fontSizeContentBig
                        color: Theme.colorText
                        verticalAlignment: Text.AlignVCenter
                    }
                }

                Text { // legend_camera
                    anchors.left: parent.left
                    anchors.leftMargin: 32 + Theme.componentMarginL*2
                    anchors.right: parent.right
                    anchors.rightMargin: Theme.componentMarginL

                    text: qsTr("Camera is used to take kittens photos.")
                    textFormat: Text.PlainText
                    wrapMode: Text.WordWrap
                    color: Theme.colorSubText
                    font.pixelSize: Theme.fontSizeContentSmall
                }
            }

            ListSeparator { } //////////////////////////////////////////////////

            Column { // element_position
                anchors.left: parent.left
                anchors.right: parent.right

                Row {
                    anchors.left: parent.left
                    anchors.leftMargin: Theme.componentMarginL
                    anchors.right: parent.right
                    anchors.rightMargin: Theme.componentMarginL
                    spacing: Theme.componentMarginL

                    RoundButtonFlat {
                        id: button_location_test
                        anchors.verticalCenter: parent.verticalCenter
                        width: 32
                        height: 32

                        property bool validperm: true

                        source: (validperm) ? "qrc:/IconLibrary/material-symbols/check.svg" : "qrc:/IconLibrary/material-symbols/close.svg"
                        color: (validperm) ? Theme.colorPrimary : Theme.colorSubText
                        colorIcon: (validperm) ? "white" : "white"

                        onClicked: {
                            UtilsOS.hapticFeedback()
                            UtilsOS.getMobileLocationPermission()
                            retryPermissions.start()
                        }
                    }

                    Text {
                        anchors.verticalCenter: parent.verticalCenter

                        text: qsTr("Position (GPS)")
                        textFormat: Text.PlainText
                        wrapMode: Text.WordWrap
                        font.pixelSize: Theme.fontSizeContentBig
                        color: Theme.colorText
                        verticalAlignment: Text.AlignVCenter
                    }
                }

                Text { // legend_position
                    anchors.left: parent.left
                    anchors.leftMargin: 32 + Theme.componentMarginL*2
                    anchors.right: parent.right
                    anchors.rightMargin: Theme.componentMarginL

                    text: qsTr("You can save GPS position of all the kittens you saw.")
                    textFormat: Text.PlainText
                    wrapMode: Text.WordWrap
                    color: Theme.colorSubText
                    font.pixelSize: Theme.fontSizeContentSmall
                }
            }

            ListSeparator { } //////////////////////////////////////////////////

            Column { // element_infos
                anchors.left: parent.left
                anchors.right: parent.right
                spacing: Theme.componentMargin

                RowLayout {
                    anchors.left: parent.left
                    anchors.leftMargin: Theme.componentMarginL
                    anchors.right: parent.right
                    anchors.rightMargin: Theme.componentMarginL
                    spacing: Theme.componentMarginL

                    IconSvg {
                        Layout.preferredWidth: 32
                        Layout.preferredHeight: 32
                        Layout.alignment: Qt.AlignVCenter

                        source: "qrc:/IconLibrary/material-icons/duotone/info.svg"
                        color: Theme.colorSubText
                    }

                    Text {
                        Layout.fillWidth: true
                        Layout.alignment: Qt.AlignVCenter

                        text: qsTr("Click on the checkmarks to request missing permissions.")
                        textFormat: Text.StyledText
                        wrapMode: Text.WordWrap
                        color: Theme.colorText
                        font.pixelSize: Theme.fontSizeContentSmall
                    }
                }

                Text { // legend
                    anchors.left: parent.left
                    anchors.leftMargin: 32 + Theme.componentMarginL*2
                    anchors.right: parent.right
                    anchors.rightMargin: Theme.componentMarginL

                    text: qsTr("If it has no effect, you may have previously refused a permission and clicked on \"don't ask again\".") + "<br>" +
                          qsTr("You can go to the Android \"application info\" panel to change a permission manually.")
                    textFormat: Text.StyledText
                    wrapMode: Text.WordWrap
                    color: Theme.colorSubText
                    font.pixelSize: Theme.fontSizeContentSmall
                }

                ButtonWireframe { // button
                    anchors.left: parent.left
                    anchors.leftMargin: 32 + Theme.componentMarginL*2
                    anchors.right: parent.right
                    anchors.rightMargin: Theme.componentMarginL

                    layoutAlignment: Qt.AlignLeft
                    colorBackground: Theme.colorForeground

                    text: qsTr("Application info")
                    source: "qrc:/IconLibrary/material-icons/duotone/tune.svg"
                    onClicked: UtilsApp.openAndroidAppInfo("io.emeric.learnylearn")
                }
            }

            ////////////////////////////////////////////////////////////////////
        }
    }

    ////////////////////////////////////////////////////////////////////////////
}
