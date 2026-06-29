import QtQuick
import QtQuick.Effects

import ComponentLibrary

Rectangle {
    id: control

    // Standard anchors:
    //anchors.left: parent.left
    //anchors.leftMargin: Theme.componentMarginXL
    //anchors.right: parent.right
    //anchors.rightMargin: Theme.componentMarginXL
    //anchors.bottom: parent.bottom
    //anchors.bottomMargin: Theme.componentMarginXL

    height: 44
    radius: 8

    color: Theme.colorMaterialBlue
    //opacity: enabled ? 1 : 0.66

    layer.enabled: true
    layer.effect: MultiEffect {
        autoPaddingEnabled: true
        shadowEnabled: true
        shadowColor: "#30000000"
    }

    ////////////////

    // colors
    property color colorContent: "white"

    // icon
    property url source: "qrc:/IconLibrary/material-symbols/autorenew.svg"
    property int sourceSize: UtilsNumber.alignTo(height * 0.5, 2)
    property int sourceRotation: 0

    // text
    property string text: "Banner button..."
    property string textButton: qsTr("Cancel")

    // animation
    property string animation // available: rotate, fade, both
    property bool animationRunning: false

    // signal
    signal clicked()

    ////////////////

    Row {
        anchors.left: parent.left
        anchors.leftMargin: Theme.componentMargin
        anchors.verticalCenter: parent.verticalCenter
        spacing: Theme.componentMargin / 2

        IconSvg {
            id: workingIndicator
            anchors.verticalCenter: parent.verticalCenter

            width: 24
            height: 24
            color: control.colorContent
            source: control.source
            opacity: 1
            Behavior on opacity { OpacityAnimator { duration: Theme.animationMediumSpeed } }

            NumberAnimation on rotation { // refreshAnimation (rotate)
                from: 0
                to: 360
                duration: 2000
                loops: Animation.Infinite
                easing.type: Easing.Linear
                running: control.animationRunning
                alwaysRunToEnd: true
                onStarted: workingIndicator.opacity = 1
                onStopped: workingIndicator.opacity = 0
            }
            SequentialAnimation on opacity { // scanAnimation (fade)
                loops: Animation.Infinite
                running: control.animationRunning
                onStopped: workingIndicator.opacity = 0
                PropertyAnimation { to: 1; duration: 750; }
                PropertyAnimation { to: 0.33; duration: 750; }
            }
        }

        Text {
            anchors.verticalCenter: parent.verticalCenter

            text: control.text
            font.pixelSize: Theme.componentFontSize
            color: control.colorContent
        }
    }

    ////////////////

    ButtonSunken {
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        colorBackground: Theme.colorMaterialBlue
        colorText: control.colorContent
        text: control.textButton

        onClicked: control.clicked()
    }

    ////////////////
}
