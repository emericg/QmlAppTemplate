import QtQuick
import QtQuick.Effects
import QtQuick.Layouts
import QtQuick.Controls

import ComponentLibrary

Popup {
    id: popupTime

    x: singleColumn ? 0 : (appWindow.width / 2) - (width / 2)
    y: singleColumn ? (appWindow.height - height)
                    : ((appWindow.height / 2) - (height / 2))

    width: singleColumn ? appWindow.width : 640
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

    signal updateTime(var newtime)

    ////////

    function openTime(time) {
        //console.log("openTime(" + time + ")")

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

    enter: Transition { NumberAnimation { property: "opacity"; from: 0.333; to: 1.0; duration: 133; } }
    //exit: Transition { NumberAnimation { property: "opacity"; from: 1.0; to: 0.0; duration: 200; } }

    Overlay.modal: Rectangle {
        color: "#000"
        opacity: Theme.isLight ? 0.24 : 0.48
    }

    background: Rectangle {
        radius: singleColumn ? 0 : Theme.componentRadius
        color: Theme.colorBackground

        Item {
            anchors.fill: parent

            Rectangle { // title area
                anchors.left: parent.left
                anchors.right: parent.right
                height: 80
                color: Theme.colorPrimary
            }

            Rectangle { // border
                anchors.fill: parent
                radius: Theme.componentRadius
                color: "transparent"
                border.color: Theme.colorSeparator
                border.width: singleColumn ? 0 : Theme.componentBorderWidth
                opacity: 0.4
            }

            layer.enabled: !singleColumn
            layer.effect: MultiEffect { // clip
                maskEnabled: true
                maskInverted: false
                maskThresholdMin: 0.5
                maskSpreadAtMin: 1.0
                maskSpreadAtMax: 0.0
                maskSource: ShaderEffectSource {
                    sourceItem: Rectangle {
                        x: background.x
                        y: background.y
                        width: background.width
                        height: background.height
                        radius: background.radius
                    }
                }
            }
        }

        layer.enabled: !singleColumn
        layer.effect: MultiEffect { // shadow
            autoPaddingEnabled: true
            blurMax: 64
            shadowEnabled: true
            shadowColor: Theme.isLight ? "#aa000000" : "#cc000000"
        }
    }

    ////////////////////////////////////////////////////////////////////////////

    contentItem: Column {
        bottomPadding: screenPaddingNavbar + screenPaddingBottom

        Item { // titleArea
            anchors.left: parent.left
            anchors.right: parent.right

            clip: true
            height: 80

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
                    height: singleColumn ? 256: 320
                    font.pixelSize: Theme.fontSizeContentVeryVeryBig
                    visibleItemCount: 7

                    model: 24
                }

                Text {
                    anchors.verticalCenter: parent.verticalCenter

                    text: " : "
                    textFormat: Text.PlainText
                    font.pixelSize: Theme.fontSizeContentVeryVeryBig
                    color: Theme.colorText
                }

                TumblerThemed {
                    id: tumblerMinutes
                    anchors.verticalCenter: parent.verticalCenter

                    width: 48
                    height: singleColumn ? 256: 320
                    font.pixelSize: Theme.fontSizeContentVeryVeryBig
                    visibleItemCount: 7

                    model: 60
                }

                Item { width: 8; height: 8; } // spacer

                TumblerThemed {
                    id: tumblerAmPm
                    anchors.verticalCenter: parent.verticalCenter

                    height: 64
                    font.pixelSize: Theme.fontSizeContentVeryVeryBig
                    visibleItemCount: 2

                    model: ["AM", "PM"]
                    wrap: true
                }
            }

            ////////
        }

        ////////////////

        Flow {
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: Theme.componentMarginXL
            bottomPadding: Theme.componentMarginXL
            spacing: Theme.componentMargin

            property int btnCount: 2
            property int btnSize: singleColumn ? width : ((width-(spacing*(btnCount-1))) / btnCount)

            ButtonClear {
                width: parent.btnSize
                color: Theme.colorGrey

                text: qsTr("Cancel")
                onClicked: popupTime.close()
            }

            ButtonFlat {
                width: parent.btnSize

                text: qsTr("Select")
                onClicked: {
                    selectedTime.setHours(tumblerHours.currentIndex)
                    selectedTime.setMinutes(tumblerMinutes.currentIndex)

                    updateTime(selectedTime)
                    popupTime.close()
                }
            }
        }

        ////////////////
    }

    ////////////////////////////////////////////////////////////////////////////
}
