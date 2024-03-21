import QtQuick
import QtQuick.Controls

import ThemeEngine

Flickable {
    contentWidth: -1
    contentHeight: contentColumn.height

    boundsBehavior: isDesktop ? Flickable.OvershootBounds : Flickable.DragAndOvershootBounds
    ScrollBar.vertical: ScrollBar { visible: false }

    property var savethedate: new Date()

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

        ButtonWireframeIcon {
            anchors.left: parent.left
            anchors.leftMargin: Theme.componentMarginXL
            anchors.right: parent.right
            anchors.rightMargin: Theme.componentMarginXL

            text: "Message"
            fullColor: true
            source: "qrc:/assets/icons_material/baseline-delete-24px.svg"

            PopupMessage {
                id: popupMessage
            }

            onClicked: popupMessage.open()
        }

        ButtonWireframeIcon {
            anchors.left: parent.left
            anchors.leftMargin: Theme.componentMarginXL
            anchors.right: parent.right
            anchors.rightMargin: Theme.componentMarginXL

            text: "Choice"
            fullColor: true
            source: "qrc:/assets/icons_material/baseline-delete-24px.svg"

            PopupChoice {
                id: popupChoice
            }

            onClicked: popupChoice.open()
        }

        ListTitle { ////////////////////////////////////////////////////////////
            anchors.leftMargin: singleColumn ? 0 : Theme.componentMargin
            anchors.rightMargin: singleColumn ? 0 : Theme.componentMargin

            text: qsTr("Date & time pickers")
            source: ""
        }

        ButtonWireframeIcon {
            anchors.left: parent.left
            anchors.leftMargin: Theme.componentMarginXL
            anchors.right: parent.right
            anchors.rightMargin: Theme.componentMarginXL

            text: "Date"
            fullColor: true
            source: "qrc:/assets/icons_material/duotone-date_range-24px.svg"

            PopupDate {
                id: popupDate
                onUpdateDate: (newdate) => { savethedate = newdate }
            }

            onClicked: popupDate.openDate(savethedate)
        }

        ButtonWireframeIcon {
            anchors.left: parent.left
            anchors.leftMargin: Theme.componentMarginXL
            anchors.right: parent.right
            anchors.rightMargin: Theme.componentMarginXL

            text: "Time"
            fullColor: true
            source: "qrc:/assets/icons_material/duotone-schedule-24px.svg"

            PopupTime {
                id: popupTime
                //onUpdateTime: (newtime) => { savethedate = newtime }
            }

            onClicked: popupTime.openTime(savethedate)
        }
    }
}
