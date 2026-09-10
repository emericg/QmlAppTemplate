import QtQuick
import QtQuick.Controls

import ComponentLibrary

Flickable {
    contentWidth: -1
    contentHeight: contentColumn.height

    boundsBehavior: isDesktop ? Flickable.OvershootBounds : Flickable.DragAndOvershootBounds
    ScrollBar.vertical: ScrollBar { visible: false }

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

        Column { // horizontal
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

                first.value: 0.25
                second.value: 0.75
            }
        }

        Row { // vertical
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
                first.value: 0.25
                second.value: 0.75
            }
        }

        ListTitle { ////////////////////////////////////////////////////////////
            anchors.leftMargin: singleColumn ? 0 : Theme.componentMargin
            anchors.rightMargin: singleColumn ? 0 : Theme.componentMargin

            text: qsTr("Conventional sliders (with graduations framework)")
            source: ""
        }

        Column { // horizontal
            anchors.left: parent.left
            anchors.leftMargin: Theme.componentMarginXL
            anchors.right: parent.right
            anchors.rightMargin: Theme.componentMarginXL
            spacing: Theme.componentMarginXL

            SliderThemed {
                anchors.left: parent.left
                anchors.right: parent.right

                value: 0.2

                graduation: true
                graduationTicks: [0, 0.1, 0.2, 0.4, 0.8, 1.0]
                graduationDefault: true
                graduationDefaultValue: 0.2
            }

            SliderThemed {
                anchors.left: parent.left
                anchors.right: parent.right

                value: 0.5

                graduation: true
                graduationStepSize: 0.1
                graduationDefault: true
                graduationDefaultValue: 0.5
            }

            MiddleSliderThemed {
                anchors.left: parent.left
                anchors.right: parent.right

                value: 0.5

                graduation: true
                graduationStepSize: 0.1
                graduationDefault: true
                graduationDefaultValue: 0.5
            }

            RangeSliderThemed {
                anchors.left: parent.left
                anchors.right: parent.right

                first.value: 0.25
                second.value: 0.75

                graduation: true
                graduationStepSize: 0.05
                graduationDefault: true
                graduationDefaultValue_first: 0.25
                graduationDefaultValue_second: 0.75
            }
        }

        ListTitle { ////////////////////////////////////////////////////////////
            anchors.leftMargin: singleColumn ? 0 : Theme.componentMargin
            anchors.rightMargin: singleColumn ? 0 : Theme.componentMargin

            text: qsTr("Arrow sliders")
            source: ""
        }

        Column { // horizontal
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

        Row { // vertical
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

            text: qsTr("Value sliders")
            source: ""
        }

        Column { // horizontal
            anchors.left: parent.left
            anchors.leftMargin: Theme.componentMarginXL
            anchors.right: parent.right
            anchors.rightMargin: Theme.componentMarginXL
            spacing: Theme.componentMarginXL

            RangeSliderValue {
                anchors.left: parent.left
                anchors.right: parent.right

                first.value: 0.2
                second.value: 0.8
                stepSize: 0.1
            }
        }

        Row { // vertical
            anchors.left: parent.left
            anchors.leftMargin: Theme.componentMarginXL
            anchors.right: parent.right
            anchors.rightMargin: Theme.componentMarginXL
            spacing: Theme.componentMarginXL

            RangeSliderValue {
                orientation: Qt.Vertical

                first.value: 0.2
                second.value: 0.8
                stepSize: 0.1
            }
        }

        ListTitle { ////////////////////////////////////////////////////////////
            anchors.leftMargin: singleColumn ? 0 : Theme.componentMargin
            anchors.rightMargin: singleColumn ? 0 : Theme.componentMargin

            text: qsTr("Solid sliders")
            source: ""
        }

        Column { // horizontal
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

                first.value: 0.2
                second.value: 0.8
                stepSize: 0.1
            }
        }

        Row { // vertical
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

                first.value: 0.2
                second.value: 0.8
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
