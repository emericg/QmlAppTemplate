import QtQuick
import QtQuick.Controls

import ComponentLibrary
import QmlAppTemplate

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
                return false
            }

            return true
        }

        ////////

        StackView {
            id: stackView
            anchors.fill: parent

            initialItem: mainView
        }

        Component {
            id: mainView

            Item {
                ListModel {
                    id: pagesModel

                    ListElement {
                        title: "Colors"
                        text: "Predefined colors."
                        icon: "qrc:/IconLibrary/material-icons/duotone/style.svg"
                        page: "PageColors.qml"
                    }

                    ListElement {
                        title: "Buttons"
                        text: "So many buttons..."
                        icon: "qrc:/IconLibrary/material-icons/duotone/touch_app.svg"
                        page: "PageButtons.qml"
                    }

                    ListElement {
                        title: "Selectors"
                        text: "Single choice selectors."
                        icon: "qrc:/IconLibrary/material-symbols/link.svg"
                        page: "PageSelectors.qml"
                    }

                    ListElement {
                        title: "Dialogs & pickers"
                        text: "Various dialog popups and datetime pickers."
                        icon: "qrc:/IconLibrary/material-icons/duotone/date_range.svg"
                        page: "PageDialogs.qml"
                    }

                    ListElement {
                        title: "Indicators"
                        text: "Usually used to indicate."
                        icon: "qrc:/IconLibrary/material-icons/duotone/speed.svg"
                        page: "PageIndicators.qml"
                    }

                    ListElement {
                        title: "Sliders"
                        text: "We like sliders. Sliders are cools."
                        icon: "qrc:/IconLibrary/material-symbols/sort.svg"
                        page: "PageSliders.qml"
                    }

                    ListElement {
                        title: "Text fields"
                        text: "Various text inputs."
                        icon: "qrc:/IconLibrary/material-icons/duotone/edit.svg"
                        page: "PageTextFields.qml"
                    }

                    ListElement {
                        title: "Tickers"
                        text: "Checkboxes, radiobuttons and others."
                        icon: "qrc:/IconLibrary/material-symbols/flaky.svg"
                        page: "PageTickers.qml"
                    }
                }

                Component {
                    id: listComponent

                    ////////

                    ItemDelegateThemed {
                        width: screenMobileComponents.width

                        onClicked: {
                            ListView.currentIndex = index
                            stackView.push(model.page)
                        }
                    }
                }

                ////////

                ListView {
                    currentIndex: -1
                    anchors.fill: parent

                    topMargin: Theme.componentMargin
                    bottomMargin: Theme.componentMargin

                    delegate: listComponent
                    model: pagesModel
                }

                ////////
            }
        }
    }

    ////////////////////////////////////////////////////////////////////////////
}
