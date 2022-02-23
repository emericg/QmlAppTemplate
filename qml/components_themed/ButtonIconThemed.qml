import QtQuick 2.15
import QtQuick.Controls.impl 2.15
import QtQuick.Templates 2.15 as T

import ThemeEngine 1.0
import "qrc:/js/UtilsNumber.js" as UtilsNumber

T.Button {
    id: control
    implicitWidth: contentText.contentWidth * 1.5 + sourceSize
    implicitHeight: Theme.componentHeight

    font.pixelSize: Theme.fontSizeComponent

    focusPolicy: Qt.NoFocus

    property url source
    property int sourceSize: UtilsNumber.alignTo(height * 0.666, 2)

    ////////////////////////////////////////////////////////////////////////////

    background: Rectangle {
        anchors.fill: parent
        radius: Theme.componentRadius
        opacity: enabled ? 1 : 0.33
        color: control.down ? Theme.colorComponentDown : Theme.colorComponent
    }

    ////////////////////////////////////////////////////////////////////////////

    contentItem: Item {
        Row {
            id: contentRow
            height: parent.height
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 8

            IconSvg {
                id: contentImage
                width: control.sourceSize
                height: control.sourceSize
                anchors.verticalCenter: parent.verticalCenter

                opacity: enabled ? 1.0 : 0.33
                source: control.source
                color: Theme.colorComponentContent
            }

            Text {
                id: contentText
                anchors.verticalCenter: parent.verticalCenter

                text: control.text
                textFormat: Text.PlainText
                font: control.font
                opacity: enabled ? 1.0 : 0.33
                color: Theme.colorComponentContent
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }
        }
    }
}
