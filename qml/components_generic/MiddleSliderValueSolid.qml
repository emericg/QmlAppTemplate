import QtQuick 2.15
import QtQuick.Controls.impl 2.15
import QtQuick.Templates 2.15 as T

import ThemeEngine 1.0
import "qrc:/js/UtilsNumber.js" as UtilsNumber

T.Slider {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitHandleWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitHandleHeight + topPadding + bottomPadding)

    padding: 4

    // settings
    property int hhh: 18
    property string unit
    property int tofixed: 0
    property bool kshort: false

    // colors
    property string colorBg: Theme.colorForeground
    property string colorFg: Theme.colorPrimary
    property string colorTxt: "white"

    ////////////////

    background: Rectangle {
        x: control.leftPadding + (control.horizontal ? 0 : (control.availableWidth - width) / 2)
        y: control.topPadding + (control.horizontal ? (control.availableHeight - height) / 2 : 0)
        implicitWidth: control.horizontal ? 200 : hhh
        implicitHeight: control.horizontal ? hhh : 200
        width: control.horizontal ? control.availableWidth : implicitWidth
        height: control.horizontal ? implicitHeight : control.availableHeight

        radius: hhh
        color: control.colorBg
        scale: control.horizontal && control.mirrored ? -1 : 1

        Rectangle {
            //visible: control.horizontal ? (handle.x > 4) : (handle.y > 4)
            //y: control.horizontal ? 0 : control.visualPosition * parent.height
            //width: control.horizontal ? control.position * parent.width : hhh
            //height: control.horizontal ? hhh : control.position * parent.height
            visible: (handle.x > 4)
            width: (handle.x + (handle.width / 2))
            height: parent.height

            radius: hhh
            color: control.colorFg
        }
    }

    ////////////////

    handle: Rectangle {
        x: control.leftPadding + (control.horizontal ? control.visualPosition * (control.availableWidth - width) : (control.availableWidth - width) / 2)
        y: control.topPadding + (control.horizontal ? (control.availableHeight - height) / 2 : control.visualPosition * (control.availableHeight - height))
        implicitWidth: hhh
        implicitHeight: hhh

        width: control.horizontal ? t1.contentWidth + 16 : hhh
        height: hhh
        radius: hhh
        color: control.colorFg
        border.color: control.colorFg

        Text {
            id: t1
            width: hhh
            height: hhh
            anchors.centerIn: parent

            text: {
                var vvalue = control.value
                if (control.unit === "°" && settingsManager.tempUnit === "F") vvalue = UtilsNumber.tempCelsiusToFahrenheit(vvalue)
                vvalue = vvalue.toFixed(0)
                return ((control.kshort && control.value > 999) ? (vvalue / 1000) : vvalue) + control.unit
            }
            textFormat: Text.PlainText
            font.bold: true
            font.pixelSize: isDesktop ? 12 : 13
            fontSizeMode: Text.Fit
            minimumPixelSize: 10
            color: control.colorTxt
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }

    ////////////////
}
