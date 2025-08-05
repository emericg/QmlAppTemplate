import QtQuick
import QtQuick.Effects
import QtQuick.Layouts
import QtQuick.Controls

import ComponentLibrary

Popup {
    id: popupBirthDate

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

    property int validatorBeforeToday: -1
    property int validatorAfterToday: 0

    property int currentView: 0 // 0: days; 1: years

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

        tumblerYear.positionViewAtYear(date.getFullYear(), Tumbler.Center)
        tumblerMonth.positionViewAtIndex(date.getMonth(), Tumbler.Center)
        currentView = 0

        printDate()

        popupBirthDate.open()
    }

    function openDate_limits(newdatetime, min, max) {
        openDate(newdatetime)

        minDate = min
        maxDate = max
    }

    function printDate() {
        bigDay.text = selectedDate.toLocaleString(locale, "dddd")
        bigDate.text = selectedDate.toLocaleString(locale, "dd MMMM yyyy")

        //var thismonth = new Date(grid.year, grid.month)
        //yearmonthButton.text = thismonth.toLocaleString(locale, "MMMM")
        //if (thismonth.getFullYear() !== today.getFullYear())
        //    yearmonthButton.text += " " + thismonth.toLocaleString(locale, "yyyy")

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
                    text: popupBirthDate.selectedDate.toLocaleString(popupBirthDate.locale, "dddd") // "Vendredi"
                    font.pixelSize: 24
                    font.capitalization: Font.Capitalize
                    color: "white"
                }
                Text {
                    id: bigDate
                    text: popupBirthDate.selectedDate.toLocaleString(popupBirthDate.locale, "dd MMMM yyyy") // "15 octobre 2020"
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

                visible: !(grid.year === popupBirthDate.today.getFullYear() && grid.month === popupBirthDate.today.getMonth())
                source: "qrc:/IconLibrary/material-icons/duotone/restart_alt.svg"

                colorBackground: Theme.colorPrimary
                colorHighlight: Qt.lighter(Theme.colorPrimary, 0.95)
                colorIcon: "white"

                onClicked: popupBirthDate.resetView()
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

            Rectangle { // year/month selector
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
                        popupBirthDate.printDate()
                    }
                }

                Row { // day / yearmonth switch
                    anchors.centerIn: parent
                    spacing: Theme.componentMarginXL

                    ButtonSunken {
                        id: dayButton
                        anchors.verticalCenter: parent.verticalCenter

                        text: popupBirthDate.selectedDate.toLocaleString(popupBirthDate.locale, "dd")
                        font.capitalization: Font.Capitalize
                        font.pixelSize: Theme.fontSizeContentBig

                        colorBackground: (popupBirthDate.currentView === 0) ? Theme.colorBackground : Theme.colorComponentBackground
                        colorHighlight: Theme.colorBackground
                        colorBorder: (popupBirthDate.currentView === 0) ? Theme.colorComponentBorder : colorBackground

                        onClicked: popupBirthDate.currentView = 0
                    }
                    ButtonSunken {
                        id: yearmonthButton
                        anchors.verticalCenter: parent.verticalCenter

                        text: popupBirthDate.selectedDate.toLocaleString(popupBirthDate.locale, "MMMM yyyy")
                        font.capitalization: Font.Capitalize
                        font.pixelSize: Theme.fontSizeContentBig

                        colorBackground: (popupBirthDate.currentView === 1) ? Theme.colorBackground : Theme.colorComponentBackground
                        colorHighlight: Theme.colorBackground
                        colorBorder: (popupBirthDate.currentView === 1) ? Theme.colorComponentBorder : colorBackground

                        onClicked: popupBirthDate.currentView = 1
                    }
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
                        popupBirthDate.printDate()
                    }
                }
            }

            ////////////////

            Row { // year/month
                id: yearmonthSelector
                anchors.horizontalCenter: parent.horizontalCenter
                height: daysSelector.height

                topPadding: Theme.componentMarginXL*2
                bottomPadding: Theme.componentMarginXL*2
                spacing: Theme.componentMarginXL

                visible: (popupBirthDate.currentView === 1)

                TumblerThemed {
                    id: tumblerMonth
                    anchors.verticalCenter: parent.verticalCenter

                    width: 128
                    height: parent.height
                    font.pixelSize: Theme.fontSizeContentVeryBig
                    visibleItemCount: 9

                    //currentIndex: popupBirthDate.selectedDate.getMonth()
                    onCurrentIndexChanged: {
                        //console.log("tumbler month INDEX CHANGED " + currentIndex)
                        popupBirthDate.selectedDate.setMonth(currentIndex)
                        grid.month = currentIndex
                        popupBirthDate.printDate()
                    }

                    model: 12
                    delegate: Text {
                        required property var modelData
                        required property int index

                        text: locale.monthName(modelData)
                        textFormat: Text.PlainText
                        font: tumblerMonth.font
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter

                        color: (tumblerMonth.currentIndex === index) ? Theme.colorPrimary : Theme.colorText
                        Behavior on color { ColorAnimation { duration: 133 } }

                        opacity: 1.0 - Math.abs(Tumbler.displacement) / (tumblerMonth.visibleItemCount / 2)
                    }
                }

                TumblerThemed {
                    id: tumblerYear
                    anchors.verticalCenter: parent.verticalCenter

                    width: 128
                    height: parent.height
                    font.pixelSize: Theme.fontSizeContentVeryBig
                    visibleItemCount: 9
                    wrap: false

                    //currentIndex: popupBirthDate.selectedDate.getFullYear()
                    onCurrentIndexChanged: {
                        //console.log("tumbler year INDEX CHANGED " + currentIndex + " " + currentItem.text)
                        popupBirthDate.selectedDate.setYear(currentItem.text)
                        grid.year = currentItem.text
                        popupBirthDate.printDate()
                    }

                    function getYears(start, end) {
                        var y = []
                        while (end >= start) {
                            y.push(end--)
                        }
                        return y
                    }
                    function positionViewAtYear(year, mode) {
                        // 0 is this year
                        // targetyear is popupBirthDate.today.getFullYear() - year
                        var idx = popupBirthDate.today.getFullYear() - year
                        //console.log("year " + year + " sould be index " + idx)
                        positionViewAtIndex(idx, mode)
                    }

                    model: getYears(1924, popupBirthDate.today.getFullYear())
                }
            }

            ////////

            ColumnLayout { // days
                id: daysSelector
                anchors.left: parent.left
                anchors.leftMargin: 8
                anchors.right: parent.right
                anchors.rightMargin: 8

                visible: (popupBirthDate.currentView === 0)

                DayOfWeekRow {
                    id: dow

                    Layout.fillWidth: true
                    Layout.fillHeight: Theme.componentHeight
                    //locale: popupBirthDate.locale

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
                    //locale: popupBirthDate.locale

                    delegate: Text {
                        width: (grid.width / 7)
                        height: width
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter

                        property bool isSelected: (day === popupBirthDate.selectedDate.getDate() &&
                                                   month === popupBirthDate.selectedDate.getMonth() &&
                                                   year === popupBirthDate.selectedDate.getFullYear())

                        property bool isToday: (day === popupBirthDate.today.getDate() &&
                                                month === popupBirthDate.today.getMonth() &&
                                                year === popupBirthDate.today.getFullYear())

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
                            // validate date (min / max)
                            if (popupBirthDate.minDate && popupBirthDate.maxDate) {
                                const diffMinTime = (popupBirthDate.minDate - date)
                                const diffMinDays = -Math.ceil(diffMinTime / (1000 * 60 * 60 * 24) - 1)
                                //console.log(diffMinDays + " diffMinDays")
                                const diffMaxTime = (popupBirthDate.minDate - date);
                                const diffMaxDays = -Math.ceil(diffMaxTime / (1000 * 60 * 60 * 24) - 1)
                                //console.log(diffMaxDays + " diffMaxDays")

                                if (diffMinDays > -1 && diffMaxDays < 1) {
                                    date.setHours(popupBirthDate.selectedDate.getHours(),
                                                  popupBirthDate.selectedDate.getMinutes(),
                                                  popupBirthDate.selectedDate.getSeconds())
                                    popupBirthDate.selectedDate = date
                                }
                            } else {
                                const diffTime = (popupBirthDate.today - date)
                                const diffDays = -Math.ceil(diffTime / (1000 * 60 * 60 * 24) - 1)
                                //console.log(diffDays + " days")

                                // validate date (-21 / popupBirthDate.today)
                                if (/*diffDays > -21 &&*/ diffDays < 1) {
                                    date.setHours(popupBirthDate.selectedDate.getHours(),
                                                  popupBirthDate.selectedDate.getMinutes(),
                                                  popupBirthDate.selectedDate.getSeconds())
                                    popupBirthDate.selectedDate = date
                                }
                            }
                            popupBirthDate.printDate()
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
                onClicked: popupBirthDate.close()
            }

            ButtonFlat {
                width: parent.btnSize

                text: qsTr("Select")
                onClicked: {
                    popupBirthDate.updateDate(popupBirthDate.selectedDate)
                    popupBirthDate.close()
                }
            }
        }

        ////////////////
    }

    ////////////////////////////////////////////////////////////////////////////
}
