import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import ThemeEngine

Item {
    id: screenPermissions
    anchors.fill: parent
    anchors.leftMargin: screenPaddingLeft
    anchors.rightMargin: screenPaddingRight

    property string entryPoint: "About"

    ////////////////////////////////////////////////////////////////////////////

    function loadScreen() {
        // Refresh permissions
        refreshPermissions()

        // Change screen
        appContent.state = "AboutPermissions"
    }

    function loadScreenFrom(screenname) {
        entryPoint = screenname
        loadScreen()
    }

    function refreshPermissions() {
        // Refresh permissions
    }

    Timer {
        id: retryPermissions
        interval: 1000
        repeat: false
        onTriggered: refreshPermissions()
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

            topPadding: Theme.componentMarginXL
            bottomPadding: Theme.componentMarginXL
            spacing: Theme.componentMarginXL

            ////////

            Column {
                id: element_location
                anchors.left: parent.left
                anchors.leftMargin: 16
                anchors.right: parent.right
                anchors.rightMargin: Theme.componentMargin
                spacing: 8

                Row {
                    height: 24
                    spacing: 16

                    RoundButtonFlat {
                        id: button_location_test
                        width: 32
                        height: 32
                        anchors.verticalCenter: parent.verticalCenter

                        property bool validperm: false

                        source: (validperm) ? "qrc:/assets/icons/material-symbols/check.svg" : "qrc:/assets/icons/material-symbols/close.svg"
                        color: (validperm) ? Theme.colorPrimary : Theme.colorSubText
                        colorIcon: (validperm) ? "white" : "white"

                        onClicked: {
                            utilsApp.vibrate(25)
                            //validperm = utilsApp.getMobileBleLocationPermission()
                            //retryPermissions.start()
                        }
                    }

                    Text {
                        id: text_location
                        anchors.verticalCenter: parent.verticalCenter

                        text: qsTr("Location")
                        textFormat: Text.PlainText
                        wrapMode: Text.WordWrap
                        font.pixelSize: Theme.fontSizeContentBig
                        color: Theme.colorText
                    }
                }

                Text {
                    id: legend_location
                    anchors.left: parent.left
                    anchors.leftMargin: 48
                    anchors.right: parent.right

                    textFormat: Text.StyledText
                    text: qsTr("The operating system requires applications to ask for device location permission in order to scan for nearby Bluetooth Low Energy sensors.") + "<br>" +
                          qsTr("This permission is only needed while scanning for new sensors.") + "<br>" +
                          qsTr("This application doesn't use, store nor communicate your location to anyone or anything.")

                    wrapMode: Text.WordWrap
                    color: Theme.colorSubText
                    font.pixelSize: Theme.fontSizeContentSmall
                }

                ButtonWireframe {
                    anchors.left: parent.left
                    anchors.leftMargin: 48
                    height: 38

                    colorBackground: Theme.colorForeground

                    text: qsTr("Official information")
                    source: "qrc:/assets/icons/material-icons/duotone/launch.svg"
                    sourceSize: 20

                    onClicked: Qt.openUrlExternally("https://developer.android.com/guide/topics/connectivity/bluetooth/permissions#declare-android11-or-lower")
                }
            }

            ////////

            ListSeparator { }

            ////////

            Column {
                id: element_gps
                anchors.left: parent.left
                anchors.leftMargin: 16
                anchors.right: parent.right
                anchors.rightMargin: Theme.componentMargin
                spacing: 8

                Row {
                    height: 24
                    spacing: 16

                    RoundButtonFlat {
                        id: button_gps_test
                        width: 32
                        height: 32
                        anchors.verticalCenter: parent.verticalCenter

                        property bool validperm: false

                        source: (validperm) ? "qrc:/assets/icons/material-symbols/check.svg" : "qrc:/assets/icons/material-symbols/close.svg"
                        color: (validperm) ? Theme.colorPrimary : Theme.colorSubText
                        colorIcon: (validperm) ? "white" : "white"

                        onClicked: {
                            utilsApp.vibrate(25)
                            //validperm = utilsApp.isMobileGpsEnabled()
                            //retryPermissions.start()
                        }
                    }

                    Text {
                        id: text_gps
                        anchors.verticalCenter: parent.verticalCenter

                        text: qsTr("GPS")
                        textFormat: Text.PlainText
                        wrapMode: Text.WordWrap
                        font.pixelSize: Theme.fontSizeContentBig
                        color: Theme.colorText
                    }
                }

                Text {
                    id: legend_gps
                    anchors.left: parent.left
                    anchors.leftMargin: 48
                    anchors.right: parent.right

                    textFormat: Text.StyledText
                    text: qsTr("Some Android devices also require the GPS to be turned on.") + "<br>" +
                          qsTr("This permission is only needed while scanning for new sensors.")

                    wrapMode: Text.WordWrap
                    color: Theme.colorSubText
                    font.pixelSize: Theme.fontSizeContentSmall
                }

                ButtonWireframe {
                    anchors.left: parent.left
                    anchors.leftMargin: 48
                    height: 38

                    colorBackground: Theme.colorForeground

                    text: qsTr("Location info")
                    source: "qrc:/assets/icons/material-icons/duotone/tune.svg"
                    sourceSize: 20

                    onClicked: utilsApp.openAndroidLocationSettings()
                }
            }

            ////////

            ListSeparator { }

            ////////

            Column {
                id: element_bluetooth
                anchors.left: parent.left
                anchors.leftMargin: 16
                anchors.right: parent.right
                anchors.rightMargin: Theme.componentMargin
                spacing: 8

                Row {
                    height: 24
                    spacing: 16

                    RoundButtonFlat {
                        id: button_bluetooth_test
                        width: 32
                        height: 32
                        anchors.verticalCenter: parent.verticalCenter

                        property bool validperm: true

                        source: (validperm) ? "qrc:/assets/icons/material-symbols/check.svg" : "qrc:/assets/icons/material-symbols/close.svg"
                        color: (validperm) ? Theme.colorPrimary : Theme.colorSubText
                        colorIcon: (validperm) ? "white" : "white"
                    }

                    Text {
                        id: text_bluetooth
                        anchors.verticalCenter: parent.verticalCenter

                        text: qsTr("Bluetooth control")
                        textFormat: Text.PlainText
                        wrapMode: Text.WordWrap
                        font.pixelSize: Theme.fontSizeContentBig
                        color: Theme.colorText
                    }
                }

                Text {
                    id: legend_bluetooth
                    anchors.left: parent.left
                    anchors.leftMargin: 48
                    anchors.right: parent.right

                    text: qsTr("This application can activate your device's Bluetooth in order to operate.")
                    textFormat: Text.PlainText
                    wrapMode: Text.WordWrap
                    color: Theme.colorSubText
                    font.pixelSize: Theme.fontSizeContentSmall
                }
            }

            ////////

            ListSeparator { }

            ////////

            Column {
                id: element_infos
                anchors.left: parent.left
                anchors.leftMargin: Theme.componentMargin
                anchors.right: parent.right
                anchors.rightMargin: Theme.componentMargin
                spacing: 8

                RowLayout {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    height: 36
                    spacing: Theme.componentMargin

                    IconSvg {
                        Layout.preferredWidth: 36
                        Layout.preferredHeight: 36
                        Layout.alignment: Qt.AlignVCenter

                        source: "qrc:/assets/icons/material-icons/duotone/info.svg"
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

                Text {
                    anchors.left: parent.left
                    anchors.leftMargin: 48
                    anchors.right: parent.right

                    text: qsTr("If it has no effect, you may have previously refused a permission and clicked on \"don't ask again\".") + "<br>" +
                          qsTr("You can go to the Android \"application info\" panel to change a permission manually.")
                    textFormat: Text.StyledText
                    wrapMode: Text.WordWrap
                    color: Theme.colorSubText
                    font.pixelSize: Theme.fontSizeContentSmall
                }

                ButtonWireframe {
                    anchors.left: parent.left
                    anchors.leftMargin: 48
                    height: 38

                    colorBackground: Theme.colorForeground

                    text: qsTr("Application info")
                    source: "qrc:/assets/icons/material-icons/duotone/tune.svg"
                    sourceSize: 20

                    onClicked: utilsApp.openAndroidAppInfo("io.emeric.qmlapptemplate")
                }
            }

            ////////
        }
    }
}
