import QtQuick

import ThemeEngine

Rectangle {
    id: appHeader
    anchors.top: parent.top
    anchors.left: parent.left
    anchors.right: parent.right

    height: headerHeight
    color: Theme.colorHeader
    clip: false
    z: 10

    property int headerHeight: 64

    property int headerPosition: 64

    property string headerTitle: "QmlAppTemplate"

    property bool componentsEnabled: true

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

    RoundButtonIcon {
        id: buttonBack
        anchors.left: parent.left
        anchors.leftMargin: 12
        anchors.verticalCenter: parent.verticalCenter

        enabled: (buttonBack.source !== "qrc:/assets/icons_material/baseline-arrow_back-24px.svg" || wideMode)
        visible: enabled

        source: "qrc:/assets/icons_material/baseline-arrow_back-24px.svg"
        iconColor: Theme.colorHeaderContent
        backgroundColor: Theme.colorHeaderHighlight

        //hoverEnabled: (buttonBack.source !== "qrc:/assets/icons_material/baseline-arrow_back-24px.svg")
        //onPressed: buttonBack.width = 20
        //onReleased: buttonBack.width = 24

        onClicked: backButtonClicked()
    }

    Text { // title
        anchors.left: parent.left
        anchors.leftMargin: 64
        anchors.verticalCenter: parent.verticalCenter

        visible: wideMode
        text: appHeader.headerTitle
        font.bold: true
        font.pixelSize: Theme.fontSizeHeader
        color: Theme.colorHeaderContent
    }

    ////////////////////////////////////////////////////////////////////////////

    Row {
        id: menus
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

            ButtonCompactable {
                id: buttonRefresh
                anchors.verticalCenter: parent.verticalCenter

                source: "qrc:/assets/icons_material/baseline-autorenew-24px.svg"
                textColor: Theme.colorHeaderContent
                iconColor: Theme.colorHeaderContent
                backgroundColor: Theme.colorHeaderHighlight
                text: qsTr("Animate this")
                tooltipText: text

                animation: "rotate"
                animationRunning: isclicked

                property bool isclicked: false
                onClicked: isclicked = !isclicked
            }

            ButtonWireframe {
                id: buttonEnable
                anchors.verticalCenter: parent.verticalCenter

                text: componentsEnabled ? qsTr("Enable components") : qsTr("Disable components")
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

            RoundButtonIcon {
                id: buttonMenu
                anchors.verticalCenter: parent.verticalCenter

                source: "qrc:/assets/icons_material/baseline-more_vert-24px.svg"
                iconColor: Theme.colorHeaderContent
                backgroundColor: Theme.colorHeaderHighlight

                onClicked: actionMenu.open()

                ActionMenu_floating {
                    id: actionMenu

                    model: ListModel {
                        id: lmActionMenu
                        ListElement { t: "itm"; idx: 1; txt: "Action 1"; src: "qrc:/assets/icons_material/baseline-accessibility-24px.svg"; }
                        ListElement { t: "itm"; idx: 2; txt: "Action 2"; src: "qrc:/assets/icons_material/baseline-accessibility-24px.svg"; }
                        ListElement { t: "sep"; }
                        ListElement { t: "itm"; idx: 3; txt: "Action 3"; src: "qrc:/assets/icons_material/baseline-accessibility-24px.svg"; }
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

                selected: (appContent.state === "DesktopComponents")
                source: "qrc:/assets/icons_material/duotone-touch_app-24px.svg"
                onClicked: menuComponentsClicked()
            }
            DesktopHeaderItem {
                id: menuSettings
                height: appHeader.height

                colorContent: Theme.colorHeaderContent
                colorHighlight: Theme.colorHeaderHighlight
                highlightMode: "background"

                selected: (appContent.state === "Settings")
                source: "qrc:/assets/icons_material/duotone-tune-24px.svg"
                onClicked: menuSettingsClicked()
            }
            DesktopHeaderItem {
                id: menuAbout
                height: appHeader.height

                colorContent: Theme.colorHeaderContent
                colorHighlight: Theme.colorHeaderHighlight
                highlightMode: "background"

                selected: (appContent.state === "About")
                source: "qrc:/assets/icons_material/duotone-info-24px.svg"
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
}
