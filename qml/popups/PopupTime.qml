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

    // 12h (with AM/PM) or 24h clock toggle
    property bool is24Hour: false

    property date initialTime
    property date selectedTime

    signal updateTime(var newtime)

    ////////

    function openTime(time) {
        //console.log("openTime(" + time + ")")

        initialTime = time
        selectedTime = time

        resetView()
        printTime()

        popupTime.open()
    }

    function printTime() {
        bigTime.text = selectedTime.toLocaleString(locale, "hh:mm:ss")
        bigDate.text = selectedTime.toLocaleString(locale, "dd MMMM yyyy")
    }

    function resetView() {
        var h = selectedTime.getHours()
        if (popupTime.is24Hour) {
            tumblerHours.positionViewAtIndex(h, Tumbler.Center)
        } else {
            tumblerHours.positionViewAtIndex(h % 12, Tumbler.Center)
            tumblerAmPm.positionViewAtIndex(h < 12 ? 0 : 1, Tumbler.Center)
        }
        tumblerMinutes.positionViewAtIndex(selectedTime.getMinutes(), Tumbler.Center)
    }
    function resetTime() {
        selectedTime = initialTime

        resetView()
        printTime()
    }

    ////////////////////////////////////////////////////////////////////////////

    enter: Transition { NumberAnimation { property: "opacity"; from: 0.333; to: 1.0; duration: Theme.animationFastSpeed; } }
    //exit: Transition { NumberAnimation { property: "opacity"; from: 1.0; to: 0.0; duration: Theme.animationMediumSpeed; } }

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

        Rectangle { // top separator
            anchors.left: parent.left
            anchors.right: parent.right
            height: Theme.componentBorderWidth
            visible: singleColumn
            color: Qt.darker(Theme.colorPrimary, 1.02)
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
        bottomPadding: Math.max(Theme.screenPaddingNavbar, Theme.screenPaddingBottom)

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
                    text: popupTime.selectedTime.toLocaleString(locale, "hh:mm:ss")
                    font.pixelSize: 24
                    font.capitalization: Font.Capitalize
                    color: "white"
                }
                Text {
                    id: bigDate
                    text: popupTime.selectedTime.toLocaleString(locale, "dd MMMM yyyy") // "15 octobre 2020"
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
                source: "qrc:/IconLibrary/material-icons/duotone/restart_alt.svg"

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

                    model: popupTime.is24Hour ? 24 : [12, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]
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

                Item { width: 8; height: 8; visible: !popupTime.is24Hour } // spacer

                TumblerThemed {
                    id: tumblerAmPm
                    anchors.verticalCenter: parent.verticalCenter

                    visible: !popupTime.is24Hour
                    width: 64
                    height: 128
                    font.pixelSize: Theme.fontSizeContentVeryBig
                    visibleItemCount: 2

                    model: ["AM", "PM"]
                    wrap: false
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
                    // 24h: index is the hour
                    // 12h: index 0..11 maps to 12,1..11 and PM adds 12 (12 AM = 0h, 12 PM = 12h)
                    var h = popupTime.is24Hour ? tumblerHours.currentIndex
                                               : tumblerHours.currentIndex + (tumblerAmPm.currentIndex === 1 ? 12 : 0)

                    popupTime.selectedTime.setHours(h)
                    popupTime.selectedTime.setMinutes(tumblerMinutes.currentIndex)

                    updateTime(popupTime.selectedTime)
                    popupTime.close()
                }
            }
        }

        ////////////////
    }

    ////////////////////////////////////////////////////////////////////////////
}
