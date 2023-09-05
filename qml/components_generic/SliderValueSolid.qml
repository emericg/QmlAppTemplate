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

    snapMode: T.RangeSlider.SnapAlways

    ////////////////

    // settings
    property int hhh: 18
    property string unit
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
        opacity: 1
        color: control.colorBg

        Rectangle {
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
        opacity: control.pressed ? 1 : 1

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
            fontSizeMode: Text.Fit
            font.pixelSize: isDesktop ? 12 : 13
            minimumPixelSize: 10
            color: control.colorTxt
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }

    ////////////////
}
