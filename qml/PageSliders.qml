import QtQuick
import QtQuick.Controls

import ThemeEngine

Flickable {
    contentWidth: -1
    contentHeight: contentColumn.height

    boundsBehavior: isDesktop ? Flickable.OvershootBounds : Flickable.DragAndOvershootBounds
    ScrollBar.vertical: ScrollBar { visible: isDesktop; }

    Column {
        id: contentColumn

        anchors.left: parent.left
        anchors.right: parent.right

        topPadding: Theme.componentMarginXL
        bottomPadding: Theme.componentMarginXL
        spacing: Theme.componentMarginXL

        ListTitle { ////////////////////////////////////////////////////////////
            anchors.leftMargin: singleColumn ? 0 : Theme.componentMargin
            anchors.rightMargin: singleColumn ? 0 : Theme.componentMargin

            text: qsTr("Conventional sliders")
            source: ""
        }

        Column {
            anchors.left: parent.left
            anchors.leftMargin: Theme.componentMarginXL
            anchors.right: parent.right
            anchors.rightMargin: Theme.componentMarginXL
            spacing: Theme.componentMarginXL

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
        }

        Row {
            anchors.left: parent.left
            anchors.leftMargin: Theme.componentMarginXL
            anchors.right: parent.right
            anchors.rightMargin: Theme.componentMarginXL
            spacing: Theme.componentMarginXL

            SliderThemed {
                orientation: Qt.Vertical
                value: 0.5
            }

            MiddleSliderThemed {
                orientation: Qt.Vertical
                value: 0.5
            }

            RangeSliderThemed {
                orientation: Qt.Vertical
                second.value: 0.75
                first.value: 0.25
            }
        }

        ListTitle { ////////////////////////////////////////////////////////////
            anchors.leftMargin: singleColumn ? 0 : Theme.componentMargin
            anchors.rightMargin: singleColumn ? 0 : Theme.componentMargin

            text: qsTr("Arrow sliders")
            source: ""
        }

        Column {
            anchors.left: parent.left
            anchors.leftMargin: Theme.componentMarginXL
            anchors.right: parent.right
            anchors.rightMargin: Theme.componentMarginXL
            spacing: Theme.componentMarginXL

            SliderArrow {
                anchors.left: parent.left
                anchors.right: parent.right

                value: 0.66
                stepSize: 0.1
            }

            MiddleSliderArrow {
                anchors.left: parent.left
                anchors.right: parent.right

                from: -1
                to: 1
                value: 0
                stepSize: 0.1
            }

            RangeSliderArrow {
                anchors.left: parent.left
                anchors.right: parent.right

                first.value: 0.3
                second.value: 0.7
                stepSize: 0.1
            }
        }

        Row {
            anchors.left: parent.left
            anchors.leftMargin: Theme.componentMarginXL
            anchors.right: parent.right
            anchors.rightMargin: Theme.componentMarginXL
            spacing: Theme.componentMarginXL

            SliderArrow {
                orientation: Qt.Vertical

                value: 0.66
                stepSize: 0.1
            }

            MiddleSliderArrow {
                orientation: Qt.Vertical

                from: -1
                to: 1
                value: 0
                stepSize: 0.1
            }

            RangeSliderArrow {
                orientation: Qt.Vertical

                first.value: 0.3
                second.value: 0.7
                stepSize: 0.1
            }
        }

        ListTitle { ////////////////////////////////////////////////////////////
            anchors.leftMargin: singleColumn ? 0 : Theme.componentMargin
            anchors.rightMargin: singleColumn ? 0 : Theme.componentMargin

            text: qsTr("Solid sliders")
            source: ""
        }

        Column {
            anchors.left: parent.left
            anchors.leftMargin: Theme.componentMarginXL
            anchors.right: parent.right
            anchors.rightMargin: Theme.componentMarginXL
            spacing: Theme.componentMarginXL

            SliderValueSolid {
                anchors.left: parent.left
                anchors.right: parent.right

                value: 0.6
                stepSize: 0.1
            }

            MiddleSliderValueSolid {
                anchors.left: parent.left
                anchors.right: parent.right

                from: -1
                to: 1
                value: 0
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

        Row {
            anchors.left: parent.left
            anchors.leftMargin: Theme.componentMarginXL
            anchors.right: parent.right
            anchors.rightMargin: Theme.componentMarginXL
            spacing: Theme.componentMarginXL

            SliderValueSolid {
                orientation: Qt.Vertical

                value: 0.66
                stepSize: 0.1
            }

            MiddleSliderValueSolid {
                orientation: Qt.Vertical

                from: -1
                to: 1
                value: 0
                stepSize: 0.1
            }

            RangeSliderValueSolid {
                orientation: Qt.Vertical

                second.value: 0.8
                first.value: 0.2
                stepSize: 0.1
            }
        }

        ListTitle { ////////////////////////////////////////////////////////////
            anchors.leftMargin: singleColumn ? 0 : Theme.componentMargin
            anchors.rightMargin: singleColumn ? 0 : Theme.componentMargin

            text: qsTr("Qt Quick Controls")
            source: ""
        }

        Column {
            anchors.left: parent.left
            anchors.leftMargin: Theme.componentMarginXL
            anchors.right: parent.right
            anchors.rightMargin: Theme.componentMarginXL
            spacing: Theme.componentMarginXL

            Slider {
                anchors.left: parent.left
                anchors.right: parent.right
            }

            RangeSlider {
                anchors.left: parent.left
                anchors.right: parent.right
            }
        }
    }
}
