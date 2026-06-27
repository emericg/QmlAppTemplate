import QtQuick
import QtQuick.Effects
import QtQuick.Layouts
import QtQuick.Controls

import ComponentLibrary

Popup {
    id: popupDate

    x: singleColumn ? 0 : (appWindow.width / 2) - (width / 2)
    y: singleColumn ? (appWindow.height - height)
                    : ((appWindow.height / 2) - (height / 2))

    width: {
        if (singleColumn) return appWindow.width
        if (isTablet && screenOrientation === Qt.LandscapeOrientation) return 480
        return 640
    }
    padding: 0
    margins: 0

    dim: true
    modal: true
    focus: true
    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
    parent: Overlay.overlay

    ////////////////////////////////////////////////////////////////////////////

    //property var locale: Qt.locale()

    property date today: new Date()
    property date initialDate
    property date selectedDate

    property bool isSelectedDateToday: false

    property var minDate: null
    property var maxDate: null

    ////////

    signal updateDate(var newdate)

    function openDate(date) {
        //console.log("openDate(" + date + ")")

        today = new Date()
        minDate = null
        maxDate = null

        initialDate = date
        selectedDate = date

        grid.year = date.getFullYear()
        grid.month = date.getMonth()

        printDate()

        popupDate.open()
    }

    function openDate_limits(newdatetime, min, max) {
        openDate(newdatetime)

        minDate = min
        maxDate = max
    }

    function printDate() {
        bigDay.text = selectedDate.toLocaleString(locale, "dddd")
        bigDate.text = selectedDate.toLocaleString(locale, "dd MMMM yyyy")

        var thismonth = new Date(grid.year, grid.month)
        bigMonth.text = thismonth.toLocaleString(locale, "MMMM")

        if (thismonth.getFullYear() !== today.getFullYear())
            bigMonth.text += " " + thismonth.toLocaleString(locale, "yyyy")

        isSelectedDateToday = (today.toLocaleString(locale, "dd MMMM yyyy") === selectedDate.toLocaleString(locale, "dd MMMM yyyy"))
    }

    function resetView() {
        grid.month = today.getMonth()
        grid.year = today.getFullYear()
        printDate()
    }
    function resetDate() {
        selectedDate = initialDate
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

        Item { // headerArea
            anchors.left: parent.left
            anchors.right: parent.right

            clip: true
            height: 80

            Column { // title
                anchors.left: parent.left
                anchors.leftMargin: 24
                anchors.verticalCenter: parent.verticalCenter
                spacing: 4

                Text {
                    id: bigDay
                    text: popupDate.selectedDate.toLocaleString(popupDate.locale, "dddd") // "Vendredi"
                    font.pixelSize: 24
                    font.capitalization: Font.Capitalize
                    color: "white"
                }
                Text {
                    id: bigDate
                    text: popupDate.selectedDate.toLocaleString(popupDate.locale, "dd MMMM yyyy") // "15 octobre 2020"
                    font.pixelSize: 20
                    color: "white"
                }
            }

            RoundButtonSunken { // reset view
                anchors.top: parent.top
                anchors.topMargin: 12
                anchors.right: parent.right
                anchors.rightMargin: 12
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 12
                width: height

                visible: !(grid.year === popupDate.today.getFullYear() && grid.month === popupDate.today.getMonth())
                source: "qrc:/IconLibrary/material-icons/duotone/restart_alt.svg"

                colorBackground: Theme.colorPrimary
                colorHighlight: Qt.lighter(Theme.colorPrimary, 0.95)
                colorIcon: "white"

                onClicked: popupDate.resetView()
            }
        }

        ////////////////

        Column {
            id: columnContent
            anchors.left: parent.left
            anchors.right: parent.right

            spacing: Theme.componentMarginXL
            bottomPadding: Theme.componentMarginXL

            ////////

            Rectangle { // month selector
                anchors.left: parent.left
                anchors.leftMargin: Theme.componentBorderWidth
                anchors.right: parent.right
                anchors.rightMargin: Theme.componentBorderWidth

                height: Theme.componentHeightXL
                color: Theme.colorComponentBackground

                SquareButtonSunken { // previous month
                    anchors.left: parent.left
                    anchors.leftMargin: 2
                    anchors.verticalCenter: parent.verticalCenter
                    width: Theme.componentHeightL
                    height: Theme.componentHeightL

                    colorBackground: parent.color
                    colorHighlight: Theme.colorBackground
                    source: "qrc:/IconLibrary/material-symbols/chevron_left.svg"

                    onClicked: {
                        if (grid.month > 0) {
                            grid.month--
                        } else {
                            grid.month = 11
                            grid.year--
                        }
                        popupDate.printDate()
                    }
                }

                Text {
                    id: bigMonth
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    text: popupDate.selectedDate.toLocaleString(popupDate.locale, "MMMM") // "Octobre"
                    font.capitalization: Font.Capitalize
                    font.pixelSize: Theme.fontSizeContentBig
                    color: Theme.colorText
                }

                SquareButtonSunken { // next month
                    anchors.right: parent.right
                    anchors.rightMargin: 2
                    anchors.verticalCenter: parent.verticalCenter
                    width: Theme.componentHeightL
                    height: Theme.componentHeightL

                    colorBackground: parent.color
                    colorHighlight: Theme.colorBackground
                    source: "qrc:/IconLibrary/material-symbols/chevron_right.svg"

                    onClicked: {
                        if (grid.month < 11) {
                            grid.month++
                        } else {
                            grid.month = 0
                            grid.year++
                        }
                        popupDate.printDate()
                    }
                }
            }

            ////////

            ColumnLayout { // days
                id: daysSelector
                anchors.left: parent.left
                anchors.leftMargin: 8
                anchors.right: parent.right
                anchors.rightMargin: 8

                DayOfWeekRow {
                    id: dow

                    Layout.fillWidth: true
                    Layout.fillHeight: Theme.componentHeight
                    //locale: popupDate.locale

                    delegate: Text {
                        text: shortName.substring(0, 1).toUpperCase()
                        color: Theme.colorText
                        font.bold: true
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }

                MonthGrid {
                    id: grid

                    Layout.fillWidth: true
                    //locale: popupDate.locale

                    delegate: Text {
                        width: (grid.width / 7)
                        height: width
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter

                        property bool isSelected: (day === popupDate.selectedDate.getDate() &&
                                                   month === popupDate.selectedDate.getMonth() &&
                                                   year === popupDate.selectedDate.getFullYear())

                        property bool isToday: (day === popupDate.today.getDate() &&
                                                month === popupDate.today.getMonth() &&
                                                year === popupDate.today.getFullYear())

                        text: day
                        font: grid.font
                        //font.bold: isToday
                        color: isSelected ? "white" : Theme.colorSubText
                        opacity: (month === grid.month ? 1 : 0.2)

                        Rectangle {
                            z: -1
                            anchors.fill: parent
                            anchors.margins: 4
                            radius: 8
                            color: isSelected ? Theme.colorSecondary : "transparent"
                            opacity: (isSelected || isToday) ? 1 : 0.66
                            border.color: Theme.colorSecondary
                            border.width: {
                                if (isToday) return Theme.componentBorderWidth
                                if (mouse.hovered && month === grid.month) return Theme.componentBorderWidth
                                return 0
                            }
                        }

                        HoverHandler {
                            id: mouse
                            acceptedDevices: PointerDevice.Mouse
                        }
                    }

                    onClicked: (date) => {
                        if (date.getMonth() === grid.month) {
                            if (popupDate.minDate && popupDate.maxDate) {
                                // validate date (min / max)
                                const diffMinTime = (popupDate.minDate - date)
                                const diffMinDays = -Math.ceil(diffMinTime / (1000 * 60 * 60 * 24) - 1)
                                //console.log(diffMinDays + " diffMinDays")
                                const diffMaxTime = (popupDate.maxDate - date);
                                const diffMaxDays = -Math.ceil(diffMaxTime / (1000 * 60 * 60 * 24) - 1)
                                //console.log(diffMaxDays + " diffMaxDays")

                                if (diffMinDays > -1 && diffMaxDays < 1) {
                                    date.setHours(popupDate.selectedDate.getHours(),
                                                  popupDate.selectedDate.getMinutes(),
                                                  popupDate.selectedDate.getSeconds())
                                    popupDate.selectedDate = date
                                }
                            } else {
                                date.setHours(popupDate.selectedDate.getHours(),
                                              popupDate.selectedDate.getMinutes(),
                                              popupDate.selectedDate.getSeconds())
                                popupDate.selectedDate = date
                            }
                            popupDate.printDate()
                        }
                    }
                }
            }

            ////////
        }

        ////////////////

        Flow {
            anchors.left: parent.left
            anchors.leftMargin: Theme.componentMarginXL
            anchors.right: parent.right
            anchors.rightMargin: Theme.componentMarginXL

            topPadding: 0
            bottomPadding: Theme.componentMarginXL
            spacing: Theme.componentMargin

            property int btnCount: 2
            property int btnSize: singleColumn ? width : ((width-(spacing*(btnCount-1))) / btnCount)

            ButtonClear {
                width: parent.btnSize
                color: Theme.colorGrey

                text: qsTr("Cancel")
                onClicked: popupDate.close()
            }

            ButtonFlat {
                width: parent.btnSize

                text: qsTr("Select")
                onClicked: {
                    popupDate.updateDate(popupDate.selectedDate)
                    popupDate.close()
                }
            }
        }

        ////////////////
    }

    ////////////////////////////////////////////////////////////////////////////
}
