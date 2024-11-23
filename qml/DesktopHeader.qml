import QtQuick

import ComponentLibrary

Rectangle {
    id: appHeader
    anchors.top: parent.top
    anchors.left: parent.left
    anchors.right: parent.right

    height: headerHeight
    color: Theme.colorHeader
    clip: false
    z: 10

    property string headerTitle: "QmlAppTemplate"
    property int headerHeight: 64
    property int headerPosition: 64

    property bool componentsEnabled: true
    property bool componentsMirrored: false

    ////////////////////////////////////////////////////////////////////////////

    signal backButtonClicked()
    signal rightMenuClicked() // mobile header compatibility

    signal menuComponentsClicked()
    signal menuSettingsClicked()
    signal menuAboutClicked()

    ////////////////////////////////////////////////////////////////////////////

    DragHandler {
        // Drag on the sidebar to drag the whole window // Qt 5.15+
        // Also, prevent clicks below this area
        onActiveChanged: if (active) appWindow.startSystemMove()
        target: null
    }

    RoundButtonSunken { // buttonBack
        anchors.top: parent.top
        anchors.topMargin: 6
        anchors.left: parent.left
        anchors.leftMargin: 8
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 6
        width: height

        colorBackground: Theme.colorHeader
        colorHighlight: Theme.colorHeaderHighlight
        colorIcon: Theme.colorHeaderContent

        source: "qrc:/IconLibrary/material-symbols/arrow_back.svg"
        onClicked: backButtonClicked()
    }

    Text { // title
        anchors.left: parent.left
        anchors.leftMargin: 72
        anchors.verticalCenter: parent.verticalCenter

        text: appHeader.headerTitle
        font.bold: true
        font.pixelSize: Theme.fontSizeHeader
        color: Theme.colorHeaderContent
    }

    ////////////////////////////////////////////////////////////////////////////

    Row { // menus
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        spacing: 12
        visible: true

        ////////////

        Row {
            id: menuDesktopComponents
            anchors.verticalCenter: parent.verticalCenter

            spacing: 12
            visible: (appContent.state === "DesktopComponents")

            ButtonFlat {
                id: buttonRefresh
                anchors.verticalCenter: parent.verticalCenter
                width: 180

                source: "qrc:/IconLibrary/material-symbols/autorenew.svg"
                text: qsTr("Animate this")

                color: Theme.colorHeaderHighlight

                animation: "rotate"
                animationRunning: isclicked

                property bool isclicked: false
                onClicked: isclicked = !isclicked
            }

            ButtonFlat {
                id: buttonEnable
                anchors.verticalCenter: parent.verticalCenter
                width: 180

                color: Theme.colorHeaderHighlight

                text: componentsEnabled ? qsTr("Disable components") : qsTr("Enable components")
                onClicked: componentsEnabled = !componentsEnabled
            }

            ////////////

            Rectangle { // separator
                anchors.verticalCenter: parent.verticalCenter
                height: 40
                width: Theme.componentBorderWidth
                color: Theme.colorHeaderHighlight
            }

            ////////////

            RoundButtonSunken { //  buttonMenu
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                width: height

                colorBackground: Theme.colorHeader
                colorHighlight: Theme.colorHeaderHighlight
                colorIcon: Theme.colorHeaderContent

                source: "qrc:/IconLibrary/material-symbols/more_vert.svg"
                onClicked: actionMenu.open()

                ActionMenu_floating {
                    id: actionMenu
                    width: 240

                    titleTxt: "back"
                    titleSrc: "qrc:/IconLibrary/material-symbols/chevron_left.svg"

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

            ////////////

            Rectangle { // separator
                anchors.verticalCenter: parent.verticalCenter
                height: 40
                width: Theme.componentBorderWidth
                color: Theme.colorHeaderHighlight
                visible: (menuMain.visible)
            }
        }

        ////////////

        Row {
            id: menuMain

            DesktopHeaderItem {
                id: menuComponents
                height: appHeader.height

                colorContent: Theme.colorHeaderContent
                colorHighlight: Theme.colorHeaderHighlight
                highlightMode: "background"

                highlighted: (appContent.state === "DesktopComponents")
                source: "qrc:/IconLibrary/material-icons/duotone/touch_app.svg"
                onClicked: menuComponentsClicked()
            }
            DesktopHeaderItem {
                id: menuSettings
                height: appHeader.height

                colorContent: Theme.colorHeaderContent
                colorHighlight: Theme.colorHeaderHighlight
                highlightMode: "background"

                highlighted: (appContent.state === "Settings")
                source: "qrc:/IconLibrary/material-icons/duotone/tune.svg"
                onClicked: menuSettingsClicked()
            }
            DesktopHeaderItem {
                id: menuAbout
                height: appHeader.height

                colorContent: Theme.colorHeaderContent
                colorHighlight: Theme.colorHeaderHighlight
                highlightMode: "background"

                highlighted: (appContent.state === "About")
                source: "qrc:/IconLibrary/material-icons/duotone/info.svg"
                onClicked: menuAboutClicked()
            }
        }
    }

    ////////////

    CsdWindows { }

    CsdLinux { }

    ////////////

    Rectangle { // separator
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        visible: !headerUnicolor
        height: 2
        opacity: 0.5
        color: Theme.colorHeaderHighlight

        Rectangle { // shadow
            anchors.top: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right

            height: 8
            opacity: 0.66
            visible: false

            gradient: Gradient {
                orientation: Gradient.Vertical
                GradientStop { position: 0.0; color: Theme.colorHeaderHighlight; }
                GradientStop { position: 1.0; color: Theme.colorBackground; }
            }
        }
    }

    ////////////
}
