import QtCore
import QtQuick
import QtQuick.Dialogs

import ComponentLibrary

Rectangle {
    id: control

    implicitWidth: 480
    implicitHeight: preview.y + preview.height + bottomColumn.height

    radius: 2
    color: Theme.colorBackground
    border.width: 2
    border.color: control.highlighted ? Theme.colorPrimary : Theme.colorComponentBorder

    ////////////////////////////////////////////////////////////////////////////

    property string title: ""
    property string description: ""

    property url sourceUrl: ""
    readonly property bool sourceFilled: (sourceUrl.length > 0)

    property bool highlighted: false

    ////////////////////////////////////////////////////////////////////////////

    Rectangle {
        id: preview

        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: 2

        height: Math.min(width, previewImage.height)
        color: control.sourceFilled ? "white" : "transparent"

        ////////

        Image {
            id: previewImage

            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right

            height: {
                const natural = control.sourceSize
                if (natural.width <= 0 || natural.height <= 0) return width
                return Math.min(width, Math.round(width * natural.height / natural.width))
            }

            visible: control.sourceFilled
            source: control.shownUrl
            sourceSize: Qt.size(width, height)
            fillMode: Image.PreserveAspectFit

            cache: false
            mipmap: true
            asynchronous: true
        }

        ////////

        Column { // noContentIndicator
            anchors.centerIn: parent
            width: parent.width - 24

            visible: !control.sourceFilled
            spacing: 8

            IconSvg {
                anchors.horizontalCenter: parent.horizontalCenter
                width: 40
                height: 40

                source: "qrc:/IconLibrary/material-symbols/media/image.svg"
                color: Theme.colorSubText
                opacity: 0.5
            }

            Text {
                width: parent.width

                text: qsTr("Drop an image here")
                textFormat: Text.PlainText
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: Theme.fontSizeContent
                color: Theme.colorSubText
                opacity: 0.8
            }
        }

        ////////

        MouseArea {
            anchors.fill: parent

            hoverEnabled: isDesktop
            cursorShape: Qt.PointingHandCursor

            onClicked: sourceFileDialog.open()
        }

        ////////

        Rectangle { // bottom separator
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.bottom
            height: 2

            color: (control.highlighted) ? Theme.colorPrimary : Theme.colorComponentBorder
        }
    }

    ////////////////////////////////////////////////////////////////////////////

    Column { // legend
        id: bottomColumn

        anchors.top: preview.bottom
        anchors.left: parent.left
        anchors.right: parent.right

        spacing: 8
        bottomPadding: 8

        ////////

        Rectangle { // title banner
            anchors.left: parent.left
            anchors.right: parent.right
            height: Math.max(Theme.componentHeightXL, titleText.height + 8)

            color: Theme.colorComponentBorder

            Text {
                id: titleText
                anchors.left: parent.left
                anchors.leftMargin: Theme.componentMargin
                anchors.right: optionalText.left
                anchors.rightMargin: Theme.componentMarginXS
                anchors.verticalCenter: parent.verticalCenter

                text: control.title
                textFormat: Text.PlainText
                elide: Text.ElideRight
                font.pixelSize: Theme.fontSizeContentBig
                font.bold: true
                color: Theme.colorText
            }

            Text {
                id: optionalText
                anchors.right: parent.right
                anchors.rightMargin: 16
                anchors.verticalCenter: titleText.verticalCenter

                visible: !control.required
                text: qsTr("[optional]")
                textFormat: Text.PlainText
                font.pixelSize: Theme.fontSizeContentSmall
                color: Theme.colorSubText
                opacity: 0.8
            }
        }

        ////////

        Text { // resource description
            anchors.left: parent.left
            anchors.leftMargin: 16
            anchors.right: parent.right
            anchors.rightMargin: 16

            text: control.description
            textFormat: Text.PlainText
            wrapMode: Text.WordWrap
            font.pixelSize: Theme.fontSizeContent
            color: Theme.colorSubText
        }

        ////////

        Repeater { // source checks: what is wrong with what fills this source
            model: control.checks

            delegate: Rectangle {
                id: statusBadge

                anchors.left: parent.left
                anchors.leftMargin: 16
                anchors.right: parent.right
                anchors.rightMargin: 16

                height: Math.max(Theme.componentHeight, statusText.height + 16)

                required property var modelData

                readonly property color statusColor: statusBadge.modelData.error ? Theme.colorError
                                                                                 : Theme.colorWarning

                radius: Theme.componentRadius
                color: Qt.rgba(statusColor.r, statusColor.g, statusColor.b, 0.15)

                IconSvg {
                    id: statusIcon
                    anchors.left: parent.left
                    anchors.leftMargin: 12
                    anchors.verticalCenter: parent.verticalCenter

                    width: 22
                    height: 22

                    source: statusBadge.modelData.error ? "qrc:/IconLibrary/material-symbols/dangerous-fill.svg"
                                                        : "qrc:/IconLibrary/material-symbols/warning-fill.svg"
                    color: statusBadge.statusColor
                }

                Text {
                    id: statusText
                    anchors.left: statusIcon.right
                    anchors.leftMargin: 12
                    anchors.right: parent.right
                    anchors.rightMargin: 12
                    anchors.verticalCenter: parent.verticalCenter

                    text: statusBadge.modelData.text
                    textFormat: Text.PlainText
                    wrapMode: Text.WordWrap
                    font.pixelSize: Theme.fontSizeContentSmall
                    font.bold: true
                    color: statusBadge.statusColor
                }
            }
        }

        ////////

        Row { // legendButtons
            anchors.right: parent.right
            anchors.rightMargin: 8

            spacing: 8

            ButtonClear {
                height: Theme.componentHeightS

                visible: (control.sourceFilled && !control.required)

                text: qsTr("Clear")
                source: "qrc:/IconLibrary/material-symbols/delete.svg"
                color: Theme.colorSubText

                onClicked: control.cleared()
            }
        }

        ////////
    }

    ////////////////////////////////////////////////////////////////////////////
}
