import QtQuick 2.15

//import QtGraphicalEffects 1.15 // Qt5
import Qt5Compat.GraphicalEffects // Qt6

import ThemeEngine 1.0

Rectangle {
    id: control
    implicitWidth: 256
    implicitHeight: 32

    radius: Theme.componentRadius
    color: Theme.colorComponentBackground

    border.width: 1
    border.color: Theme.colorComponentBorder

    layer.enabled: true
    layer.effect: OpacityMask {
        maskSource: Rectangle {
            x: control.x
            y: control.y
            width: control.width
            height: control.height
            radius: control.radius
        }
    }
}
