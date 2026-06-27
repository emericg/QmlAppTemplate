import QtQuick
import QtQuick.Dialogs
import QtQuick.Controls

import ComponentLibrary
import QmlAppTemplate

Flickable {
    contentWidth: -1
    contentHeight: contentColumn.height

    boundsBehavior: isDesktop ? Flickable.OvershootBounds : Flickable.DragAndOvershootBounds
    ScrollBar.vertical: ScrollBar { visible: false }

    property var savethedate: new Date()
    property var savethetime: new Date()

    Column {
        id: contentColumn

        anchors.left: parent.left
        anchors.right: parent.right

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

            text: "Message"
            source: "qrc:/IconLibrary/material-icons/duotone/format_size.svg"

            PopupMessage {
                id: popupMessage
            }

            onClicked: popupMessage.open()
        }

        ButtonSolid {
            anchors.left: parent.left
            anchors.leftMargin: Theme.componentMarginXL
            anchors.right: parent.right
            anchors.rightMargin: Theme.componentMarginXL

            text: "Choice"
            source: "qrc:/IconLibrary/material-icons/duotone/touch_app.svg"

            PopupChoice {
                id: popupChoice
            }

            onClicked: popupChoice.open()
        }

        ButtonSolid {
            anchors.left: parent.left
            anchors.leftMargin: Theme.componentMarginXL
            anchors.right: parent.right
            anchors.rightMargin: Theme.componentMarginXL

            text: "Choice (3 ways)"
            source: "qrc:/IconLibrary/material-icons/duotone/touch_app.svg"

            PopupChoice {
                id: popupManyChoice
                title: qsTr("Are you sure you want to delete data for this sensor?")
                text: qsTr("You can either delete data from the application, or from both the sensor and application.")
                buttonClose: qsTr("Cancel")
                buttonSecondary: qsTr("Delete local data")
                buttonPrimary: qsTr("Delete sensor data")
            }

            onClicked: popupManyChoice.open()
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

            text: "BirthDate"
            source: "qrc:/IconLibrary/material-icons/duotone/date_range.svg"

            PopupBirthDate {
                id: popupBirthDate
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
    }
}
