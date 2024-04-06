import QtQuick
import QtQuick.Controls

import ThemeEngine

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
            screenMobileComponents.item.backAction()
    }

    ////////////////////////////////////////////////////////////////////////////

    sourceComponent: Item {
        anchors.fill: parent

        function backAction() {
            //console.log("MobileComponents::backAction()")

            if (stackView.depth > 1) {
                stackView.pop()
                return
            }
        }

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
                        icon: "qrc:/assets/icons/material-icons/duotone/style.svg"
                        page: "qrc:/qml/PageColors.qml"
                    }

                    ListElement {
                        title: "Buttons"
                        text: "So many buttons..."
                        icon: "qrc:/assets/icons/material-icons/duotone/touch_app.svg"
                        page: "qrc:/qml/PageButtons.qml"
                    }

                    ListElement {
                        title: "Selectors"
                        text: "Single choice selectors."
                        icon: "qrc:/assets/icons/material-symbols/link.svg"
                        page: "qrc:/qml/PageSelectors.qml"
                    }

                    ListElement {
                        title: "Dialogs & pickers"
                        text: "Various dialog popups and datetime pickers."
                        icon: "qrc:/assets/icons/material-icons/duotone/date_range.svg"
                        page: "qrc:/qml/PageDialogs.qml"
                    }

                    ListElement {
                        title: "Indicators"
                        text: "Usually used to indicate."
                        icon: "qrc:/assets/icons/material-icons/duotone/speed.svg"
                        page: "qrc:/qml/PageIndicators.qml"
                    }

                    ListElement {
                        title: "Sliders"
                        text: "We like sliders. Sliders are cools."
                        icon: "qrc:/assets/icons/material-symbols/sort.svg"
                        page: "qrc:/qml/PageSliders.qml"
                    }

                    ListElement {
                        title: "Text fields"
                        text: "Various text inputs."
                        icon: "qrc:/assets/icons/material-icons/duotone/edit.svg"
                        page: "qrc:/qml/PageTextFields.qml"
                    }

                    ListElement {
                        title: "Tickers"
                        text: "Checkboxes, radiobuttons and others."
                        icon: "qrc:/assets/icons/material-symbols/flaky.svg"
                        page: "qrc:/qml/PageTickers.qml"
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
