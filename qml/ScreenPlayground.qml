import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import ComponentLibrary

Loader {
    id: screenPlayground
    anchors.fill: parent

    function loadScreen() {
        // load screen
        screenPlayground.active = true

        // change screen
        appContent.state = "Playgrounds"
    }

    function backAction() {
        if (screenPlayground.status === Loader.Ready)
            return screenPlayground.item.backAction()

        return false
    }

    ////////////////////////////////////////////////////////////////////////////

    active: false
    asynchronous: false

    sourceComponent: Item {
        anchors.fill: parent
        anchors.margins: 32

        ////////

        function backAction() {
            return false
        }

        ////////

        SelectorMenuSunken {
            id: playgroundSelector

            anchors.top: parent.top
            anchors.topMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
            height: 32

            colorBackground: Theme.colorBackground
            colorForeground: Theme.colorPrimary

            model: ListModel {
                ListElement { idx: 1; txt: "one"; src: ""; sz: 0; }
                ListElement { idx: 2; txt: "two"; src: ""; sz: 0; }
                ListElement { idx: 3; txt: "three"; src: ""; sz: 0; }
            }

            currentSelection: 1
            onMenuSelected: (index) => { currentSelection = index }
        }

        ////////

        PlaygroundOne {
            anchors.fill: parent
            visible: playgroundSelector.currentSelection === 1
        }

        PlaygroundTwo {
            anchors.fill: parent
            visible: playgroundSelector.currentSelection === 2
        }

        PlaygroundThree {
            anchors.fill: parent
            visible: playgroundSelector.currentSelection === 3
        }

        ////////
    }

    ////////////////////////////////////////////////////////////////////////////
}
