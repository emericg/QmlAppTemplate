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
        anchors.leftMargin: 20
        anchors.right: parent.right
        anchors.rightMargin: 20

        topPadding: 16
        bottomPadding: 16
        spacing: 16

        SectionTitle { /////////////////////////////////////////////////////////
            anchors.leftMargin: singleColumn ? -parent.anchors.leftMargin : 12
            anchors.rightMargin: singleColumn ? -parent.anchors.leftMargin : 12

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

        SectionTitle { /////////////////////////////////////////////////////////
            anchors.leftMargin: singleColumn ? -parent.anchors.leftMargin : 12
            anchors.rightMargin: singleColumn ? -parent.anchors.leftMargin : 12

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

        SectionTitle { /////////////////////////////////////////////////////////
            anchors.leftMargin: singleColumn ? -parent.anchors.leftMargin : 12
            anchors.rightMargin: singleColumn ? -parent.anchors.leftMargin : 12

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
