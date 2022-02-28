import QtQuick 2.15

import ThemeEngine 1.0

Rectangle {
    id: header
    anchors.top: parent.top
    anchors.left: parent.left
    anchors.right: parent.right

    z: 10
    height: 64
    color: Theme.colorHeader

    ////////////////////////////////////////////////////////////////////////////

    signal backButtonClicked()
    signal rightMenuClicked() // compatibility

    signal refreshButtonClicked()

    signal mainButtonClicked()
    signal settingsButtonClicked()
    signal aboutButtonClicked()

    function setActiveMenu() {
        //
    }

    ////////////////////////////////////////////////////////////////////////////

    DragHandler {
        // Drag on the sidebar to drag the whole window // Qt 5.15+
        // Also, prevent clicks below this area
        onActiveChanged: if (active) appWindow.startSystemMove()
        target: null
    }

    MouseArea {
        width: 40
        height: 40
        anchors.left: parent.left
        anchors.leftMargin: 12
        anchors.verticalCenter: parent.verticalCenter

        hoverEnabled: (buttonBack.source !== "qrc:/assets/icons_material/baseline-arrow_back-24px.svg")
        onEntered: { buttonBackBg.opacity = 0.5; }
        onExited: { buttonBackBg.opacity = 0; buttonBack.width = 24; }

        onPressed: buttonBack.width = 20
        onReleased: buttonBack.width = 24
        onClicked: backButtonClicked()

        enabled: (buttonBack.source !== "qrc:/assets/icons_material/baseline-arrow_back-24px.svg" || wideMode)
        visible: enabled

        Rectangle {
            id: buttonBackBg
            anchors.fill: parent
            radius: height
            z: -1
            color: Theme.colorHeaderHighlight
            opacity: 0
            Behavior on opacity { OpacityAnimator { duration: 333 } }
        }

        IconSvg {
            id: buttonBack
            width: 24
            height: width
            anchors.centerIn: parent

            source: "qrc:/assets/icons_material/baseline-arrow_back-24px.svg"
            color: Theme.colorHeaderContent
        }
    }

    Text {
        id: title
        anchors.left: parent.left
        anchors.leftMargin: 64
        anchors.verticalCenter: parent.verticalCenter

        visible: wideMode
        text: "QmlAppTemplate"
        font.bold: true
        font.pixelSize: Theme.fontSizeHeader
        color: Theme.colorHeaderContent
    }

    ////////////////////////////////////////////////////////////////////////////

    Row {
        id: menus
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0

        //z: 1
        visible: true
        spacing: 12

        ////////////

        RoundButtonIcon {
            id: buttonMenu
            anchors.verticalCenter: parent.verticalCenter

            source: "qrc:/assets/icons_material/baseline-more_vert-24px.svg"
            iconColor: Theme.colorHeaderContent
            backgroundColor: Theme.colorHeaderHighlight

            onClicked: {
                actionMenu.x = mapToItem(appWindow.contentItem, buttonMenu.x, buttonMenu.y).x - actionMenu.width
                actionMenu.y = mapToItem(appWindow.contentItem, buttonMenu.x, buttonMenu.y).y + 16
                actionMenu.open()
            }

            ActionMenu {
                id: actionMenu
                //x: mapToItem(appWindow.contentItem, buttonMenu.x, buttonMenu.y).x - actionMenu.width
                //y: mapToItem(appWindow.contentItem, buttonMenu.x, buttonMenu.y).y + 16

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

        ButtonCompactable {
            id: buttonRefresh
            anchors.verticalCenter: parent.verticalCenter

            //visible: (deviceManager.bluetooth && menuMain.visible)
            //enabled: !deviceManager.scanning

            source: "qrc:/assets/icons_material/baseline-autorenew-24px.svg"
            textColor: Theme.colorHeaderContent
            iconColor: Theme.colorHeaderContent
            backgroundColor: Theme.colorHeaderHighlight
            text: qsTr("Refresh data")
            tooltipText: text

            property bool isclicked: false
            onClicked: isclicked = !isclicked

            animation: "rotate"
            animationRunning: isclicked
        }

        ////////////
/*
        Rectangle { // separator
            anchors.verticalCenter: parent.verticalCenter
            height: 40
            width: Theme.componentBorderWidth
            color: Theme.colorHeaderHighlight
            visible: (menuTest.visible)
        }

        Row {
            id: menuTest

            DesktopHeaderItem {
                id: menuMainView1
                height: header.height

                colorContent: Theme.colorHeaderContent
                colorHighlight: Theme.colorHeaderHighlight

                selected: (appContent.state === "MainView")
                source: "qrc:/assets/icons_material/duotone-touch_app-24px.svg"
                onClicked: mainButtonClicked()
            }
            DesktopHeaderItem {
                id: menuSettings1
                height: header.height

                colorContent: Theme.colorHeaderContent
                colorHighlight: Theme.colorHeaderHighlight

                selected: (appContent.state === "Settings")
                text: qsTr("Settings")
                //source: "qrc:/assets/icons_material/baseline-settings-20px.svg"
                onClicked: settingsButtonClicked()
            }
            DesktopHeaderItem {
                id: menuAbout1
                height: header.height

                colorContent: Theme.colorHeaderContent
                colorHighlight: Theme.colorHeaderHighlight

                selected: (appContent.state === "About")
                text: qsTr("Infos")
                source: "qrc:/assets/icons_material/outline-info-24px.svg"
                onClicked: aboutButtonClicked()
            }
        }
*/
        ////////////

        Rectangle { // separator
            anchors.verticalCenter: parent.verticalCenter
            height: 40
            width: Theme.componentBorderWidth
            color: Theme.colorHeaderHighlight
            visible: (menuMain.visible)
        }

        Row {
            id: menuMain

            DesktopHeaderItem {
                id: menuMainView
                height: header.height

                colorContent: Theme.colorHeaderContent
                colorHighlight: Theme.colorHeaderHighlight
                highlightMode: "background"

                selected: (appContent.state === "MainView")
                source: "qrc:/assets/icons_material/duotone-touch_app-24px.svg"
                onClicked: mainButtonClicked()
            }
            DesktopHeaderItem {
                id: menuSettings
                height: header.height

                colorContent: Theme.colorHeaderContent
                colorHighlight: Theme.colorHeaderHighlight
                highlightMode: "background"

                selected: (appContent.state === "Settings")
                source: "qrc:/assets/icons_material/baseline-settings-20px.svg"
                onClicked: settingsButtonClicked()
            }
            DesktopHeaderItem {
                id: menuAbout
                height: header.height

                colorContent: Theme.colorHeaderContent
                colorHighlight: Theme.colorHeaderHighlight
                highlightMode: "background"

                selected: (appContent.state === "About")
                source: "qrc:/assets/icons_material/outline-info-24px.svg"
                onClicked: aboutButtonClicked()
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
/*
        Rectangle { // shadow
            anchors.top: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right

            height: 8
            opacity: 0.66

            gradient: Gradient {
                orientation: Gradient.Vertical
                GradientStop { position: 0.0; color: Theme.colorHeaderHighlight; }
                GradientStop { position: 1.0; color: Theme.colorBackground; }
            }
        }
*/
    }
}
