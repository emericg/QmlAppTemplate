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
                        title: "Buttons"
                        text: "Buttons and stuff."
                        icon: "qrc:/assets/icons_material/duotone-touch_app-24px.svg"
                        page: "qrc:/qml/PageButtons.qml"
                    }

                    ListElement {
                        title: "Selectors"
                        text: "Single choice selectors."
                        icon: "qrc:/assets/icons_material/baseline-insert_link-24px.svg"
                        page: "qrc:/qml/PageSelectors.qml"
                    }

                    ListElement {
                        title: "Date & Time"
                        text: "Datetime pickers."
                        icon: "qrc:/assets/icons_material/duotone-date_range-24px.svg"
                        page: "qrc:/qml/PageDialogs.qml"
                    }

                    ListElement {
                        title: "Dialogs"
                        text: "Various dialog popups."
                        icon: "qrc:/assets/icons_material/baseline-accessibility-24px.svg"
                        page: "qrc:/qml/PageDialogs.qml"
                    }

                    ListElement {
                        title: "Indicators"
                        text: "Thise are useful."
                        icon: "qrc:/assets/icons_material/baseline-sort-24px.svg"
                        page: "qrc:/qml/PageIndicators.qml"
                    }

                    ListElement {
                        title: "Sliders"
                        text: "We like sliders. Sliders are cools."
                        icon: "qrc:/assets/icons_material/baseline-sort-24px.svg"
                        page: "qrc:/qml/PageSliders.qml"
                    }

                    ListElement {
                        title: "TextFields"
                        text: "Various text inputs."
                        icon: "qrc:/assets/icons_material/duotone-edit-24px.svg"
                        page: "qrc:/qml/PageTextFields.qml"
                    }

                    ListElement {
                        title: "Tickers"
                        text: "Checkboxes and radiobuttons."
                        icon: "qrc:/assets/icons_material/baseline-flaky-24px.svg"
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
