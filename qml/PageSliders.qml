import QtQuick
import QtQuick.Controls

import ThemeEngine 1.0

Flickable {
    contentWidth: -1
    contentHeight: contentColumn.height

    boundsBehavior: isDesktop ? Flickable.OvershootBounds : Flickable.DragAndOvershootBounds
    ScrollBar.vertical: ScrollBar { visible: isDesktop; }

    Column {
        id: contentColumn

        anchors.left: parent.left
        anchors.leftMargin: Theme.componentMargin
        anchors.right: parent.right
        anchors.rightMargin: Theme.componentMargin

        topPadding: Theme.componentMargin
        bottomPadding: Theme.componentMargin
        spacing: Theme.componentMarginXL


        ListTitle { ////////////////////////////////////////////////////////////
            anchors.leftMargin: singleColumn ? -parent.anchors.leftMargin : 0
            anchors.rightMargin: singleColumn ? -parent.anchors.leftMargin : 0

            text: qsTr("Conventional sliders")
            source: ""
        }

        SliderThemed {
            anchors.left: parent.left
            anchors.right: parent.right

            value: 0.5
        }

        MiddleSliderThemed {
            anchors.left: parent.left
            anchors.right: parent.right
            value: 0.5
        }

        RangeSliderThemed {
            anchors.left: parent.left
            anchors.right: parent.right

            second.value: 0.75
            first.value: 0.25
        }

        ListTitle { ////////////////////////////////////////////////////////////
            anchors.leftMargin: singleColumn ? -parent.anchors.leftMargin : 0
            anchors.rightMargin: singleColumn ? -parent.anchors.leftMargin : 0

            text: qsTr("Arrow sliders")
            source: ""
        }

        SliderArrow {
            anchors.left: parent.left
            anchors.right: parent.right

            value: 0.7
            stepSize: 0.1
        }

        MiddleSliderArrow {
            anchors.left: parent.left
            anchors.right: parent.right

            value: 0.5
            stepSize: 0.1
        }

        RangeSliderArrow {
            anchors.left: parent.left
            anchors.right: parent.right

            first.value: 0.3
            second.value: 0.7
            stepSize: 0.1
        }

        ListTitle { ////////////////////////////////////////////////////////////
            anchors.leftMargin: singleColumn ? -parent.anchors.leftMargin : 0
            anchors.rightMargin: singleColumn ? -parent.anchors.leftMargin : 0

            text: qsTr("Solid sliders")
            source: ""
        }

        SliderValueSolid {
            anchors.left: parent.left
            anchors.right: parent.right

            value: 0.6
            stepSize: 0.1
        }

        RangeSliderValueSolid {
            anchors.left: parent.left
            anchors.right: parent.right
            second.value: 0.8
            first.value: 0.2
            stepSize: 0.1
        }
    }
}
