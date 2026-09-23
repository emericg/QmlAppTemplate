import QtQuick
import QtQuick.Controls

import ComponentLibrary

Loader {
    id: screenMobileComponents
    anchors.fill: parent

    function loadScreen() {
        // load screen
        screenMobileComponents.active = true

        // change screen
        appContent.state = "MobileComponents"
    }

    function backAction() {
        if (screenMobileComponents.status === Loader.Ready)
            return screenMobileComponents.item.backAction()

        return false
    }

    property int stackViewDepth: {
        if (screenMobileComponents.status === Loader.Ready)
            return screenMobileComponents.item.stackViewDepth
        return 0
    }

    ////////////////////////////////////////////////////////////////////////////

    sourceComponent: Item {
        anchors.fill: parent

        property alias stackViewDepth: stackView.depth

        ////////

        function backAction() {
            //console.log("MobileComponents::backAction()")

            if (stackView.depth > 1) {
                stackView.pop()
                return true
            }

            return false
        }

        ////////

        Loader {
            id: stackViewHeader
            anchors.left: parent.left
            anchors.right: parent.right
            height: 56
            z: 10

            active: isDesktop
            asynchronous: true

            sourceComponent: Rectangle {
                anchors.left: parent.left
                anchors.right: parent.right
                height: 56

                color: Theme.colorActionbar

                Row {
                    anchors.top: parent.top
                    anchors.topMargin: 8
                    anchors.left: parent.left
                    anchors.leftMargin: 16
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 8
                    spacing: 16

                    SquareButtonClear { // buttonBack
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        width: height

                        //colorBackground: Theme.colorActionbar
                        //colorHighlight: Theme.colorActionbarHighlight
                        //colorIcon: Theme.colorActionbarContent

                        source: "qrc:/IconLibrary/material-symbols/arrow_back.svg"
                        onClicked: backAction()
                    }

                    SquareButtonClear { // buttonMenu
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        width: height

                        //colorBackground: Theme.colorActionbar
                        //colorHighlight: Theme.colorActionbarHighlight
                        //colorIcon: Theme.colorActionbarContent

                        source: "qrc:/IconLibrary/material-symbols/more_vert.svg"
                        onClicked: actionMenu.open()

                        ActionMenu_bottom {
                            id: actionMenu

                            titleTxt: "ActionMenu"
                            //titleSrc: "qrc:/IconLibrary/material-symbols/chevron_left.svg"

                            model: ListModel {
                                id: lmActionMenu
                                ListElement { t: "itm"; idx: 1; txt: "Action 1"; src: "qrc:/IconLibrary/material-symbols/accessibility.svg"; }
                                ListElement { t: "itm"; idx: 2; txt: "Action 2"; src: "qrc:/IconLibrary/material-symbols/accessibility.svg"; }
                                ListElement { t: "sep"; }
                                ListElement { t: "itm"; idx: 3; txt: "Action 3"; src: "qrc:/IconLibrary/material-symbols/accessibility.svg"; }
                            }

                            onMenuSelected: (index) => {
                                //console.log("ActionMenu clicked #" + index)
                            }
                        }
                    }
                }
            }
        }

        ////////

        StackView {
            id: stackView

            anchors.top: parent.top
            anchors.topMargin: stackViewHeader.active ? stackViewHeader.height : 0
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom

            initialItem: mainView
        }

        Component {
            id: mainView

            Item {
                DemoPagesModel { id: pagesModel }

                ////////

                ListView {
                    id: pagesView
                    currentIndex: -1
                    anchors.fill: parent

                    topMargin: Theme.componentMargin
                    bottomMargin: Theme.componentMargin

                    property real sideMargin: Theme.singleColumn ? 0 : width*0.125

                    model: pagesModel
                    delegate: Item {
                        width: pagesView.width
                        height: listElement.height

                        ListElementThemed {
                            id: listElement
                            anchors.left: parent.left
                            anchors.leftMargin: pagesView.sideMargin
                            anchors.right: parent.right
                            anchors.rightMargin: pagesView.sideMargin

                            text: model.title
                            subtitle: model.text
                            source: model.icon

                            onClicked: {
                                pagesView.currentIndex = index
                                stackView.push(model.page)
                            }
                        }
                    }
                }

                ////////
            }
        }
    }

    ////////////////////////////////////////////////////////////////////////////
}
