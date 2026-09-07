import QtQuick

Item {
    id: hazardBand

    implicitHeight: 40

    clip: true

    property color colorBackground: "#1a1a1a"
    property color colorStripe: "#f2c21a"

    property real stripeWidth: 40
    property real stripeSpacing: 40

    property real stripeAngle: 45

    property bool animated: false
    property int animationDuration: 2000

    ////////

    readonly property real pitch: hazardBand.stripeWidth + hazardBand.stripeSpacing

    readonly property real stripeThickness: Math.max(1, hazardBand.stripeWidth * Math.cos(Math.min(Math.abs(hazardBand.stripeAngle), 80) * Math.PI / 180))

    readonly property real overhang: hazardBand.height * 2

    readonly property int stripeCount: Math.ceil((hazardBand.width + 2 * hazardBand.overhang) / hazardBand.pitch) + 1

    property real stripeOffset: 0

    NumberAnimation on stripeOffset {
        running: hazardBand.animated && hazardBand.visible
        loops: Animation.Infinite

        from: 0
        to: hazardBand.pitch
        duration: hazardBand.animationDuration
    }

    ////////

    Rectangle {
        anchors.fill: parent
        color: hazardBand.colorBackground
    }

    Repeater {
        model: hazardBand.stripeCount

        Rectangle {
            x: index * hazardBand.pitch - hazardBand.overhang + hazardBand.stripeOffset
            y: (hazardBand.height - height) / 2

            width: hazardBand.stripeThickness
            height: hazardBand.height * 3

            color: hazardBand.colorStripe
            rotation: hazardBand.stripeAngle
            antialiasing: true
        }
    }

    ////////
}
