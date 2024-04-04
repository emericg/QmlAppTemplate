import QtQuick
import QtQuick.Effects
import QtQuick.Layouts
import QtQuick.Controls

import ThemeEngine

Popup {
    id: popupDate

    x: singleColumn ? 0 : (appWindow.width / 2) - (width / 2)
    y: singleColumn ? (appWindow.height - height)
                    : ((appWindow.height / 2) - (height / 2))

    width: singleColumn ? appWindow.width : 720
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

    ////////////////////////////////////////////////////////////////////////////

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

        // visual hacks
        //dow.width = dow.width - 8
        grid.width = dow.width - 8

        printDate()

        popupDate.open()
    }

    function openDate_limits(datetime, min, max) {
        openDate(datetime)

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

    function resetDate() {
        grid.month = today.getMonth()
        grid.year = today.getFullYear()
        printDate()
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

        Rectangle {
            id: titleArea
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
                    id: bigDay
                    text: selectedDate.toLocaleString(locale, "dddd") // "Vendredi"
                    font.pixelSize: 24
                    font.capitalization: Font.Capitalize
                    color: "white"
                }
                Text {
                    id: bigDate
                    text: selectedDate.toLocaleString(locale, "dd MMMM yyyy") // "15 octobre 2020"
                    font.pixelSize: 20
                    color: "white"
                }
            }

            RoundButtonIcon { // reset
                anchors.right: parent.right
                anchors.rightMargin: 24
                anchors.verticalCenter: parent.verticalCenter
                source: "qrc:/assets/icons_material/duotone-restart_alt-24px.svg"
                iconColor: "white"
                backgroundColor: Qt.lighter(Theme.colorPrimary, 0.9)

                visible: !(grid.year === today.getFullYear() && grid.month === today.getMonth())

                onClicked: resetDate()
            }
        }

        ////////////////

        Column {
            anchors.left: parent.left
            anchors.right: parent.right

            spacing: Theme.componentMarginXL
            bottomPadding: Theme.componentMarginXL

            ////////

            Rectangle {
                height: 48
                anchors.left: parent.left
                anchors.right: parent.right
                color: "#66dddddd"

                RoundButtonIcon {
                    width: 48; height: 48;
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    source: "qrc:/assets/icons_material/baseline-chevron_left-24px.svg"

                    onClicked: {
                        if (grid.month > 0) {
                            grid.month--
                        } else {
                            grid.month = 11
                            grid.year--
                        }
                        printDate()
                    }
                }
                Text {
                    id: bigMonth
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    text: selectedDate.toLocaleString(locale, "MMMM") // "Octobre"
                    font.capitalization: Font.Capitalize
                    font.pixelSize: Theme.fontSizeContentBig
                    color: Theme.colorText
                }
                RoundButtonIcon {
                    anchors.right: parent.right
                    width: 48; height: 48;
                    anchors.verticalCenter: parent.verticalCenter
                    source: "qrc:/assets/icons_material/baseline-chevron_right-24px.svg"

                    onClicked: {
                        if (grid.month < 11) {
                            grid.month++
                        } else {
                            grid.month = 0
                            grid.year++
                        }
                        printDate()
                    }
                }
            }

            ////////

            DayOfWeekRow {
                id: dow
                anchors.left: parent.left
                anchors.leftMargin: 4
                anchors.right: parent.right
                anchors.rightMargin: 4

                Layout.fillWidth: true
                //locale: popupDate.locale

                delegate: Text {
                    text: model.shortName.substring(0, 1).toUpperCase()
                    color: Theme.colorText
                    font.bold: true
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }

            MonthGrid {
                id: grid
                anchors.left: parent.left
                anchors.leftMargin: 4
                anchors.right: parent.right
                anchors.rightMargin: 4

                Layout.fillWidth: true
                //locale: popupDate.locale

                delegate: Text {
                    width: (grid.width / 7)
                    height: width
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter

                    property bool isSelected: (model.day === selectedDate.getDate() &&
                                               model.month === selectedDate.getMonth() &&
                                               model.year === selectedDate.getFullYear())

                    property bool isToday: (model.day === popupDate.today.getDate() &&
                                            model.month === popupDate.today.getMonth() &&
                                            model.year === popupDate.today.getFullYear())

                    text: model.day
                    font: grid.font
                    //font.bold: model.today
                    color: isSelected ? "white" : Theme.colorSubText
                    opacity: (model.month === grid.month ? 1 : 0.2)

                    Rectangle {
                        z: -1
                        anchors.fill: parent
                        radius: width
                        color: isSelected ? Theme.colorSecondary : "transparent"
                        border.color: Theme.colorSecondary
                        border.width: isToday ? Theme.componentBorderWidth : 0
                    }
                }

                onClicked: (date) => {
                    if (date.getMonth() === grid.month) {
                        // validate date (min / max)
                        if (minDate && maxDate) {
                            const diffMinTime = (minDate - date)
                            const diffMinDays = -Math.ceil(diffMinTime / (1000 * 60 * 60 * 24) - 1)
                            //console.log(diffMinDays + " diffMinDays")
                            const diffMaxTime = (minDate - date);
                            const diffMaxDays = -Math.ceil(diffMaxTime / (1000 * 60 * 60 * 24) - 1)
                            //console.log(diffMaxDays + " diffMaxDays")

                            if (diffMinDays > -1 && diffMaxDays < 1) {
                                date.setHours(selectedDate.getHours(),
                                              selectedDate.getMinutes(),
                                              selectedDate.getSeconds())
                                selectedDate = date
                            }
                        } else {
                            const diffTime = (today - date)
                            const diffDays = -Math.ceil(diffTime / (1000 * 60 * 60 * 24) - 1)
                            //console.log(diffDays + " days")

                            // validate date (-21 / today)
                            if (diffDays > -21 && diffDays < 1) {
                                date.setHours(selectedDate.getHours(),
                                              selectedDate.getMinutes(),
                                              selectedDate.getSeconds())
                                selectedDate = date
                            }
                        }

                        printDate()
                    }
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
                    onClicked: popupDate.close()
                }

                ButtonFlat {
                    color: Theme.colorPrimary

                    text: qsTr("Select")
                    onClicked: {
                        updateDate(selectedDate)
                        popupDate.close()
                    }
                }
            }

            ////////
        }

        ////////////////
    }

    ////////////////////////////////////////////////////////////////////////////
}
