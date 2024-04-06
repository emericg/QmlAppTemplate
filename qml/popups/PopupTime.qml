import QtQuick
import QtQuick.Effects
import QtQuick.Layouts
import QtQuick.Controls

import ThemeEngine

Popup {
    id: popupTime

    x: singleColumn ? 0 : (appWindow.width / 2) - (width / 2)
    y: singleColumn ? (appWindow.height - height)
                    : ((appWindow.height / 2) - (height / 2))

    width: singleColumn ? appWindow.width : 560
    padding: 0
    margins: 0

    dim: true
    modal: true
    focus: true
    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
    parent: Overlay.overlay

    ////////////////////////////////////////////////////////////////////////////

    //property var locale: Qt.locale()

    property date initialTime
    property date selectedTime

    ////////////////////////////////////////////////////////////////////////////

    signal updateTime(var newtime)

    function openTime(time) {
        console.log("openTime(" + time + ")")

        initialTime = time
        selectedTime = time
        tumblerHours.positionViewAtIndex(time.getHours(), Tumbler.Center)
        tumblerMinutes.positionViewAtIndex(time.getMinutes(), Tumbler.Center)

        printTime()

        popupTime.open()
    }

    function printTime() {
        bigTime.text = selectedTime.toLocaleString(locale, "hh:mm:ss")
        bigDate.text = selectedTime.toLocaleString(locale, "dd MMMM yyyy")
    }

    function resetView() {
        // TODO
    }
    function resetTime() {
        selectedTime = initialTime
        tumblerHours.positionViewAtIndex(initialTime.getHours(), Tumbler.Center)
        tumblerMinutes.positionViewAtIndex(initialTime.getMinutes(), Tumbler.Center)

        printTime()
    }

    ////////////////////////////////////////////////////////////////////////////

    enter: Transition { NumberAnimation { property: "opacity"; from: 0.5; to: 1.0; duration: 133; } }
    //exit: Transition { NumberAnimation { property: "opacity"; from: 1.0; to: 0.0; duration: 200; } }

    Overlay.modal: Rectangle {
        color: "#000"
        opacity: ThemeEngine.isLight ? 0.24 : 0.666
    }

    background: Rectangle {
        color: Theme.colorBackground
        border.color: Theme.colorSeparator
        border.width: singleColumn ? 0 : Theme.componentBorderWidth
        radius: singleColumn ? 0 : Theme.componentRadius

        Rectangle {
            width: parent.width
            height: Theme.componentBorderWidth
            visible: singleColumn
            color: Theme.colorSeparator
        }

        layer.enabled: !singleColumn
        layer.effect: MultiEffect {
            autoPaddingEnabled: true
            shadowEnabled: true
            shadowColor: ThemeEngine.isLight ? "#aa000000" : "#aaffffff"
        }
    }

    ////////////////////////////////////////////////////////////////////////////

    contentItem: Column {
        bottomPadding: screenPaddingNavbar + screenPaddingBottom

        Rectangle { // titleArea
            anchors.left: parent.left
            anchors.right: parent.right

            clip: true
            height: 80
            radius: singleColumn ? 0 : Theme.componentRadius
            color: Theme.colorPrimary

            Rectangle {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                height: parent.radius
                color: parent.color
            }

            Column {
                anchors.left: parent.left
                anchors.leftMargin: 24
                anchors.verticalCenter: parent.verticalCenter
                spacing: 4

                Text {
                    id: bigTime
                    text: selectedTime.toLocaleString(locale, "hh:mm:ss")
                    font.pixelSize: 24
                    font.capitalization: Font.Capitalize
                    color: "white"
                }
                Text {
                    id: bigDate
                    text: selectedTime.toLocaleString(locale, "dd MMMM yyyy") // "15 octobre 2020"
                    font.pixelSize: 20
                    color: "white"
                }
            }

            RoundButtonSunken { // reset time
                anchors.top: parent.top
                anchors.topMargin: 12
                anchors.right: parent.right
                anchors.rightMargin: 12
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 12
                width: height

                visible: true
                source: "qrc:/assets/icons/material-icons/duotone/restart_alt.svg"

                colorBackground: Theme.colorPrimary
                colorHighlight: Qt.lighter(Theme.colorPrimary, 0.95)
                colorIcon: "white"

                onClicked: resetTime()
            }
        }

        ////////////////

        Column {
            anchors.left: parent.left
            anchors.right: parent.right

            topPadding: Theme.componentMarginXL
            bottomPadding: Theme.componentMarginXL
            spacing: Theme.componentMarginXL

            ////////

            Row {
                anchors.horizontalCenter: parent.horizontalCenter

                TumblerThemed {
                    id: tumblerHours
                    anchors.verticalCenter: parent.verticalCenter
                    width: 48
                    height: 160

                    font.pixelSize: Theme.fontSizeContentVeryBig

                    model: 24
                }

                Text {
                    anchors.verticalCenter: parent.verticalCenter

                    text: " : "
                    textFormat: Text.PlainText
                    font.pixelSize: Theme.fontSizeContentVeryBig
                }

                TumblerThemed {
                    id: tumblerMinutes
                    anchors.verticalCenter: parent.verticalCenter
                    width: 48
                    height: 160

                    font.pixelSize: Theme.fontSizeContentVeryBig

                    model: 60
                }

                TumblerThemed {
                    id: tumblerAmPm
                    anchors.verticalCenter: parent.verticalCenter

                    model: ["AM", "PM"]
                }
            }

            ////////

            Row {
                anchors.right: parent.right
                anchors.rightMargin: Theme.componentMarginXL
                spacing: Theme.componentMargin

                ButtonClear {
                    color: Theme.colorGrey

                    text: qsTr("Cancel")
                    onClicked: popupTime.close()
                }

                ButtonFlat {
                    color: Theme.colorPrimary

                    text: qsTr("Select")
                    onClicked: {
                        selectedTime.setHours(tumblerHours.currentIndex)
                        selectedTime.setMinutes(tumblerMinutes.currentIndex)

                        updateTime(selectedTime)
                        popupTime.close()
                    }
                }
            }

            ////////
        }

        ////////////////
    }

    ////////////////////////////////////////////////////////////////////////////
}
