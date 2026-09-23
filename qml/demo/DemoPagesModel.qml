import QtQuick

ListModel {

    ListElement {
        title: "Colors"
        text: "Predefined colors."
        icon: "qrc:/IconLibrary/material-icons/duotone/style.svg"
        gradient: "sunset"
        page: "demo/PageColors.qml"
    }

    ListElement {
        title: "Gradients"
        text: "Gradient presets and decorated surfaces."
        icon: "qrc:/IconLibrary/material-symbols/media/gradient.svg"
        gradient: "aurora"
        page: "demo/PageGradients.qml"
    }

    ListElement {
        title: "Buttons"
        text: "So many buttons..."
        icon: "qrc:/IconLibrary/material-icons/duotone/touch_app.svg"
        gradient: "ocean"
        page: "demo/PageButtons.qml"
    }

    ListElement {
        title: "Selectors"
        text: "Single choice selectors."
        icon: "qrc:/IconLibrary/material-symbols/link.svg"
        gradient: "forest"
        page: "demo/PageSelectors.qml"
    }

    ListElement {
        title: "Tickers"
        text: "Checkboxes, radiobuttons and others."
        icon: "qrc:/IconLibrary/material-symbols/flaky.svg"
        gradient: "cosmic"
        page: "demo/PageTickers.qml"
    }

    ListElement {
        title: "Indicators"
        text: "Usually used to indicate."
        icon: "qrc:/IconLibrary/material-icons/duotone/speed.svg"
        gradient: "ember"
        page: "demo/PageIndicators.qml"
    }

    ListElement {
        title: "Sliders"
        text: "We like sliders. Sliders are cools."
        icon: "qrc:/IconLibrary/material-symbols/sort.svg"
        gradient: "violet"
        page: "demo/PageSliders.qml"
    }

    ListElement {
        title: "Text fields"
        text: "Various text inputs."
        icon: "qrc:/IconLibrary/material-icons/duotone/edit.svg"
        gradient: "emerald"
        page: "demo/PageTextFields.qml"
    }

    ListElement {
        title: "Layouts"
        text: "Frames, boxes and panes."
        icon: "qrc:/IconLibrary/material-symbols/layers.svg"
        gradient: "grape"
        page: "demo/PageLayouts.qml"
    }

    ListElement {
        title: "Cards"
        text: "Cards and list elements."
        icon: "qrc:/IconLibrary/material-symbols/note_stack.svg"
        gradient: "peach"
        page: "demo/PageCards.qml"
    }

    ListElement {
        title: "Dialogs & pickers"
        text: "Various dialog popups and datetime pickers."
        icon: "qrc:/IconLibrary/material-icons/duotone/date_range.svg"
        gradient: "lagoon"
        page: "demo/PageDialogs.qml"
    }
}
