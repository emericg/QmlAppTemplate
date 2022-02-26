import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.15

import ThemeEngine 1.0

Loader {
    anchors.top: parent.top
    anchors.topMargin: 0
    anchors.right: parent.right
    anchors.rightMargin: 0

    width: 96
    height: 32

    //enabled: (settingsManager.appThemeCSD && Qt.platform.os !== "windows" && Qt.platform.os !== "osx")
    //visible: (settingsManager.appThemeCSD && Qt.platform.os !== "windows" && Qt.platform.os !== "osx")

    asynchronous: true
    sourceComponent: (settingsManager.appThemeCSD && Qt.platform.os !== "windows" && Qt.platform.os !== "osx")
                         ? componentCsdLinux : null

    Component {
        id: componentCsdLinux

        Row {
            id: csdLinux
            anchors.centerIn: parent
            spacing: 4

            ////////

            Rectangle { // button minimize
                width: 28; height: 28; radius: 28;
                color: hovered ? "#33aaaaaa" : "transparent"

                property bool hovered: false

                Rectangle {
                    width: 10; height: 1;
                    anchors.centerIn: parent
                    color: "transparent"
                    border.width: 1
                    border.color: parent.hovered ? Theme.colorHighContrast : Theme.colorIcon
                }

                MouseArea {
                    anchors.fill: parent

                    hoverEnabled: true
                    onEntered: parent.hovered = true
                    onExited: parent.hovered = false
                    onCanceled: parent.hovered = false
                    onClicked: appWindow.showMinimized()
                }
            }

            ////////

            Rectangle { // button maximize
                width: 28; height: 28; radius: 28;
                color: hovered ? "#33aaaaaa" : "transparent"

                property bool hovered: false

                Rectangle {
                    width: 11; height: 11;
                    anchors.centerIn: parent
                    color: "transparent"
                    border.width: 1
                    border.color: parent.hovered ? Theme.colorHighContrast : Theme.colorIcon
                }

                MouseArea {
                    anchors.fill: parent

                    hoverEnabled: true
                    onEntered: parent.hovered = true
                    onExited: parent.hovered = false
                    onCanceled: parent.hovered = false
                    onClicked: {
                        if (appWindow.visibility === ApplicationWindow.Maximized)
                            appWindow.showNormal()
                        else
                            appWindow.showMaximized()
                    }
                }
            }

            ////////

            Rectangle { // button close
                width: 28; height: 28; radius: 28;
                color: hovered ? "red" : "transparent"

                property bool hovered: false

                Rectangle {
                    width: 14; height: 1; radius: 1;
                    anchors.centerIn: parent
                    rotation: 45
                    color: parent.hovered ? "white" : Theme.colorIcon
                }
                Rectangle {
                    width: 14; height: 1; radius: 1;
                    anchors.centerIn: parent
                    rotation: -45
                    color: parent.hovered ? "white" : Theme.colorIcon
                }

                MouseArea {
                    anchors.fill: parent

                    hoverEnabled: true
                    onEntered: parent.hovered = true
                    onExited: parent.hovered = false
                    onCanceled: parent.hovered = false
                    onClicked: appWindow.close()
                }
            }
        }
    }
}
