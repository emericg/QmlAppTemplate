import QtQuick
import QtQuick.Dialogs
import QtQuick.Layouts
import QtQuick.Controls

import ComponentLibrary

Flickable {
    contentWidth: -1
    contentHeight: contentColumn.height

    boundsBehavior: Theme.isDesktop ? Flickable.OvershootBounds : Flickable.DragAndOvershootBounds
    ScrollBar.vertical: ScrollBarThemed { visible: Theme.isDesktop }

    property var savethedate: new Date()
    property var savethetime: new Date()

    Column {
        id: contentColumn

        anchors.left: parent.left
        anchors.leftMargin: Theme.singleColumn ? 0 : parent.width*0.125
        anchors.right: parent.right
        anchors.rightMargin: Theme.singleColumn ? 0 : parent.width*0.125

        topPadding: Theme.componentMarginXL
        bottomPadding: Theme.componentMarginXL
        spacing: Theme.componentMarginXL

        ListTitle { ////////////////////////////////////////////////////////////
            anchors.leftMargin: singleColumn ? 0 : Theme.componentMargin
            anchors.rightMargin: singleColumn ? 0 : Theme.componentMargin

            text: qsTr("Dialogs")
            source: ""
        }

        ButtonSolid {
            anchors.left: parent.left
            anchors.leftMargin: Theme.componentMarginXL
            anchors.right: parent.right
            anchors.rightMargin: Theme.componentMarginXL

            text: "Dialog Themed"
            source: "qrc:/IconLibrary/material-icons/duotone/touch_app.svg"

            DialogThemed {
                id: dialogThemed

                title: qsTr("Are you sure you want to delete data for this sensor?")
                text: qsTr("You can either delete data from the application, or from both the sensor and application.")
                standardButtons: Dialog.Discard | Dialog.Save | Dialog.Cancel
            }

            onClicked: dialogThemed.open()
        }

        RowLayout {
            anchors.left: parent.left
            anchors.leftMargin: Theme.componentMarginXL
            anchors.right: parent.right
            anchors.rightMargin: Theme.componentMarginXL
            spacing: Theme.componentMargin

            ButtonSolid {
                Layout.preferredWidth: 1
                Layout.fillWidth: true

                text: "Message"
                source: "qrc:/IconLibrary/material-icons/duotone/format_size.svg"

                PopupMessage {
                    id: popupMessage

                    title: qsTr("Message Popup")
                    text: qsTr("This is a generic message, empty of any kind of meaning.")
                }

                onClicked: popupMessage.open()
            }

            ButtonSolid {
                Layout.preferredWidth: 1
                Layout.fillWidth: true

                text: "Message (solid)"
                source: "qrc:/IconLibrary/material-icons/duotone/format_size.svg"

                PopupMessage {
                    id: popupMessageSolid
                    headerArea.solid: true

                    title: qsTr("Message Popup")
                    text: qsTr("This is a generic message, empty of any kind of meaning.")
                }

                onClicked: popupMessageSolid.open()
            }

            ButtonSolid {
                Layout.preferredWidth: 1
                Layout.fillWidth: true

                text: "Message (solid w banner)"
                source: "qrc:/IconLibrary/material-icons/duotone/format_size.svg"

                PopupMessage {
                    id: popupMessageBanner
                    headerArea.solid: true

                    title: qsTr("Message Popup")
                    bannerText: qsTr("An optional subtext banner")
                    text: qsTr("This is a generic message, empty of any kind of meaning.")
                }

                onClicked: popupMessageBanner.open()
            }
        }

        RowLayout {
            anchors.left: parent.left
            anchors.leftMargin: Theme.componentMarginXL
            anchors.right: parent.right
            anchors.rightMargin: Theme.componentMarginXL
            spacing: Theme.componentMargin

            ButtonSolid {
                Layout.preferredWidth: 1
                Layout.fillWidth: true

                text: "Choice"
                source: "qrc:/IconLibrary/material-icons/duotone/touch_app.svg"

                PopupChoice {
                    id: popupChoice

                    title: qsTr("Are you sure you want to delete data for this sensor?")
                    text: qsTr("You can either delete data from the application, or from both the sensor and application.")
                    buttonClose: qsTr("Cancel")
                    buttonSecondary: ""
                    buttonPrimary: qsTr("Delete")
                }

                onClicked: popupChoice.open()
            }

            ButtonSolid {
                Layout.preferredWidth: 1
                Layout.fillWidth: true

                text: "Choice (solid)"
                source: "qrc:/IconLibrary/material-icons/duotone/touch_app.svg"

                PopupChoice {
                    id: popupChoiceSolid
                    headerArea.solid: true
                    footerArea.solid: true

                    title: qsTr("Are you sure you want to delete data for this sensor?")
                    text: qsTr("You can either delete data from the application, or from both the sensor and application.")
                    buttonClose: qsTr("Cancel")
                    buttonSecondary: ""
                    buttonPrimary: qsTr("Delete")
                }

                onClicked: popupChoiceSolid.open()
            }

            ButtonSolid {
                Layout.preferredWidth: 1
                Layout.fillWidth: true

                text: "Choice (3 ways)"
                source: "qrc:/IconLibrary/material-icons/duotone/touch_app.svg"

                PopupChoice {
                    id: popupManyChoice
                    headerArea.solid: true
                    footerArea.solid: true

                    title: qsTr("Are you sure you want to delete data for this sensor?")
                    bannerText: qsTr("An optional subtext banner")
                    text: qsTr("You can either delete data from the application, or from both the sensor and application.")
                    buttonClose: qsTr("Cancel")
                    buttonSecondary: qsTr("Delete local data")
                    buttonPrimary: qsTr("Delete sensor data")
                }

                onClicked: popupManyChoice.open()
            }
        }

        ListTitle { ////////////////////////////////////////////////////////////
            anchors.leftMargin: singleColumn ? 0 : Theme.componentMargin
            anchors.rightMargin: singleColumn ? 0 : Theme.componentMargin

            text: qsTr("Color pickers")
            source: ""
        }

        ButtonSolid {
            anchors.left: parent.left
            anchors.leftMargin: Theme.componentMarginXL
            anchors.right: parent.right
            anchors.rightMargin: Theme.componentMarginXL

            text: "Colors"
            source: "qrc:/IconLibrary/material-icons/duotone/style.svg"

            PopupColors {
                id: popupColors
                onUpdateColor: (newColor) => { }
            }

            onClicked: popupColors.openColor(Theme.colorPrimary)
        }

        ButtonSolid {
            anchors.left: parent.left
            anchors.leftMargin: Theme.componentMarginXL
            anchors.right: parent.right
            anchors.rightMargin: Theme.componentMarginXL

            text: "Qt colors"
            source: "qrc:/IconLibrary/material-icons/duotone/style.svg"

            ColorDialog {
                id: dialogColors

                // selectedColor
                // onAccepted
            }

            onClicked: dialogColors.open()
        }

        ListTitle { ////////////////////////////////////////////////////////////
            anchors.leftMargin: singleColumn ? 0 : Theme.componentMargin
            anchors.rightMargin: singleColumn ? 0 : Theme.componentMargin

            text: qsTr("Date & time pickers")
            source: ""
        }

        ButtonSolid {
            anchors.left: parent.left
            anchors.leftMargin: Theme.componentMarginXL
            anchors.right: parent.right
            anchors.rightMargin: Theme.componentMarginXL

            text: "Date"
            source: "qrc:/IconLibrary/material-icons/duotone/date_range.svg"

            PopupDate {
                id: popupDate
                onUpdateDate: (newdate) => { savethedate = newdate }
            }

            onClicked: popupDate.openDate(savethedate)
        }

        ButtonSolid {
            anchors.left: parent.left
            anchors.leftMargin: Theme.componentMarginXL
            anchors.right: parent.right
            anchors.rightMargin: Theme.componentMarginXL

            text: "Birthdate"
            source: "qrc:/IconLibrary/material-icons/duotone/date_range.svg"

            PopupDate {
                id: popupBirthDate
                mode: DatePicker.Birthdate
                onUpdateDate: (newdate) => { savethedate = newdate }
            }

            onClicked: popupBirthDate.openDate(savethedate)
        }

        ButtonSolid {
            anchors.left: parent.left
            anchors.leftMargin: Theme.componentMarginXL
            anchors.right: parent.right
            anchors.rightMargin: Theme.componentMarginXL

            text: "Time"
            source: "qrc:/IconLibrary/material-icons/duotone/schedule.svg"

            PopupTime {
                id: popupTime
                onUpdateTime: (newtime) => { savethetime = newtime }
            }

            onClicked: popupTime.openTime(savethetime)
        }

        ButtonSolid {
            anchors.left: parent.left
            anchors.leftMargin: Theme.componentMarginXL
            anchors.right: parent.right
            anchors.rightMargin: Theme.componentMarginXL

            text: "Date & time"
            source: "qrc:/IconLibrary/material-icons/duotone/date_range.svg"

            PopupDateTime {
                id: popupDateTime
                onUpdateDateTime: (newdatetime) => { savethedate = newdatetime; savethetime = newdatetime }
            }

            onClicked: popupDateTime.openDateTime(savethedate)
        }

        ListTitle { ////////////////////////////////////////////////////////////
            anchors.leftMargin: singleColumn ? 0 : Theme.componentMargin
            anchors.rightMargin: singleColumn ? 0 : Theme.componentMargin

            text: qsTr("Inline pickers")
            source: ""
        }

        Flow { // the same pickers the popups are built on, without a popup
            anchors.left: parent.left
            anchors.leftMargin: Theme.componentMarginXL
            anchors.right: parent.right
            anchors.rightMargin: Theme.componentMarginXL
            spacing: Theme.componentMarginXL

            property int itemWidth: Theme.singleColumn ? width : Math.min(400, (width - spacing) / 2)

            DatePicker {
                width: parent.itemWidth
                Component.onCompleted: loadDate(savethedate)
                onSelectedDateChanged: savethedate = selectedDate
            }

            DatePicker {
                width: parent.itemWidth
                mode: DatePicker.Birthdate
                Component.onCompleted: loadDate(new Date(1990, 4, 12))
            }

            TimePicker {
                width: parent.itemWidth
                is24Hour: true
                Component.onCompleted: loadTime(savethetime)
                onSelectedTimeChanged: savethetime = selectedTime
            }

            ColorPicker {
                width: parent.itemWidth
                Component.onCompleted: loadColor(Theme.colorPrimary)
            }
        }

        ////////////////////////////////////////////////////////////////////////
    }
}
