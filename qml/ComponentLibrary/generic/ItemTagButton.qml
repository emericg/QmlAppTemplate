import QtQuick
import QtQuick.Effects

import ThemeEngine

Rectangle {
    id: control

    implicitWidth: 80
    implicitHeight: 28

    width: contentRow.width
    radius: Theme.componentRadius
    color: backgroundColor

    property string text: "TAG"
    property color textColor: "white"
    property int textSize: Theme.componentFontSize

    property url source: "qrc:/assets/icons_material/baseline-add-24px.svg"
    property color sourceColor: "white"
    property int sourceSize: 20

    property color backgroundColor: Theme.colorPrimary

    signal clicked()

    ////////////////

    Row {
        id: contentRow
        anchors.centerIn: parent
        height: control.height

        Item {
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            width: 10
        }

        Text {
            anchors.top: parent.top
            anchors.bottom: parent.bottom

            text: control.text
            textFormat: Text.PlainText
            color: control.textColor
            elide: Text.ElideMiddle
            font.capitalization: Font.AllUppercase
            font.pixelSize: Theme.componentFontSize
            font.bold: true
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }

        Item {
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            width: 12

            Rectangle {
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                anchors.rightMargin: 0
                width: 2
                color: control.textColor
                opacity: 0.5
            }
        }

        Rectangle {
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            width: 40

            color: {
                if (mousearea.containsPress) return Qt.darker(control.color, 1.06)
                if (mousearea.containsMouse) return Qt.darker(control.color, 1.03)
                return control.color
            }

            IconSvg {
                anchors.centerIn: parent
                source: control.source
                width: control.sourceSize
                color: control.sourceColor
            }

            MouseArea {
                id: mousearea
                anchors.fill: parent
                hoverEnabled: true
                onClicked: control.clicked()
            }
        }
    }

    ////////////////

    layer.enabled: true
    layer.effect: MultiEffect {
        maskEnabled: true
        maskInverted: false
        maskThresholdMin: 0.5
        maskSpreadAtMin: 1.0
        maskSpreadAtMax: 0.0
        maskSource: ShaderEffectSource {
            sourceItem: Rectangle {
                x: control.x
                y: control.y
                width: control.width
                height: control.height
                radius: control.radius
            }
        }
    }

    ////////////////
}
