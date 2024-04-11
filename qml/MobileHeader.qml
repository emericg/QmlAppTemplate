import QtQuick

import ThemeEngine

Rectangle {
    id: appHeader

    anchors.top: parent.top
    anchors.left: parent.left
    anchors.right: parent.right

    height: headerHeight + Math.max(screenPaddingTop, screenPaddingStatusbar)
    color: Theme.colorHeader
    clip: true
    z: 10

    property int headerHeight: 52

    property int headerPosition: 56

    property string headerTitle: utilsApp.appName()

    ////////////////////////////////////////////////////////////////////////////

    property string leftMenuMode: "drawer" // drawer / back / close
    signal leftMenuClicked()

    property string rightMenuMode: "off" // on / off
    signal rightMenuClicked()

    function rightMenuIsOpen() { return actionMenu.visible; }
    function rightMenuClose() { actionMenu.close(); }

    ////////////////////////////////////////////////////////////////////////////

    // prevent clicks below this area
    MouseArea { anchors.fill: parent; acceptedButtons: Qt.AllButtons; }

    // menu
    ActionMenu_bottom {
        id: actionMenu

        titleTxt: "ActionMenu"
        //titleSrc: "qrc:/assets/icons/material-symbols/chevron_left.svg"

        model: ListModel {
            id: lmActionMenu
            ListElement { t: "itm"; idx: 1; txt: "Action 1"; src: "qrc:/assets/icons/material-symbols/accessibility.svg"; }
            ListElement { t: "itm"; idx: 2; txt: "Action 2"; src: "qrc:/assets/icons/material-symbols/accessibility.svg"; }
            ListElement { t: "sep"; }
            ListElement { t: "itm"; idx: 3; txt: "Action 3"; src: "qrc:/assets/icons/material-symbols/accessibility.svg"; }
        }

        onMenuSelected: (index) => {
            //console.log("ActionMenu clicked #" + index)
        }
    }

    ////////////////////////////////////////////////////////////////////////////

    Rectangle { // OS statusbar area
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right

        height: Math.max(screenPaddingTop, screenPaddingStatusbar)
        color: Theme.colorStatusbar
    }

    Item {
        anchors.fill: parent
        anchors.topMargin: Math.max(screenPaddingTop, screenPaddingStatusbar)

        ////////////

        Row { // left area
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.leftMargin: 4
            anchors.bottom: parent.bottom

            spacing: 4

            ////

            MouseArea { // left button
                width: headerHeight
                height: headerHeight

                visible: true
                onClicked: leftMenuClicked()

                RippleThemed {
                    anchor: parent
                    width: parent.width
                    height: parent.height

                    pressed: parent.pressed
                    //active: enabled && parent.containsPress
                    color: Qt.rgba(Theme.colorHeaderHighlight.r, Theme.colorHeaderHighlight.g, Theme.colorHeaderHighlight.b, 0.33)
                }

                IconSvg {
                    anchors.centerIn: parent
                    width: (headerHeight / 2)
                    height: (headerHeight / 2)

                    source: {
                        if (leftMenuMode === "drawer") return "qrc:/assets/icons/material-symbols/menu.svg"
                        if (leftMenuMode === "close") return "qrc:/assets/icons/material-symbols/close.svg"
                        return "qrc:/assets/icons/material-symbols/arrow_back.svg"
                    }
                    color: Theme.colorHeaderContent
                }
            }

            ////
        }

        Text { // header title
            anchors.left: parent.left
            anchors.leftMargin: headerPosition
            anchors.right: rightArea.left
            anchors.rightMargin: 8
            anchors.verticalCenter: parent.verticalCenter

            text: headerTitle
            color: Theme.colorHeaderContent
            font.bold: true
            font.pixelSize: Theme.fontSizeHeader
            font.capitalization: Font.Capitalize
            verticalAlignment: Text.AlignVCenter
        }

        ////////////

        Row { // right area
            id: rightArea
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.rightMargin: 4
            anchors.bottom: parent.bottom

            spacing: 4

            ////

            Item { // right indicator
                anchors.verticalCenter: parent.verticalCenter

                width: parent.height
                height: width
                visible: (appContent.state === "MobileComponents")

                IconSvg {
                    id: workingIndicator
                    anchors.centerIn: parent

                    width: 24
                    height: 24

                    source: "qrc:/assets/icons/material-symbols/autorenew.svg"
                    color: Theme.colorHeaderContent
                    opacity: 0
                    Behavior on opacity { OpacityAnimator { duration: 333 } }

                    NumberAnimation on rotation {
                        from: 0
                        to: 360
                        duration: 2000
                        loops: Animation.Infinite
                        easing.type: Easing.Linear
                        running: false
                        alwaysRunToEnd: true
                        onStarted: workingIndicator.opacity = 1
                        onStopped: workingIndicator.opacity = 0
                    }
                    SequentialAnimation on opacity {
                        loops: Animation.Infinite
                        running: false
                        onStopped: workingIndicator.opacity = 0
                        PropertyAnimation { to: 1; duration: 750; }
                        PropertyAnimation { to: 0.33; duration: 750; }
                    }
                }
            }

            ////

            MouseArea { // right button
                width: headerHeight
                height: headerHeight

                visible: (appContent.state === "MobileComponents")

                onClicked: {
                    rightMenuClicked()
                    actionMenu.open()
                }

                RippleThemed {
                    width: parent.width
                    height: parent.height

                    pressed: parent.pressed
                    //active: enabled && parent.containsPress
                    color: Qt.rgba(Theme.colorHeaderHighlight.r, Theme.colorHeaderHighlight.g, Theme.colorHeaderHighlight.b, 0.33)
                }

                IconSvg {
                    anchors.centerIn: parent
                    width: (headerHeight / 2)
                    height: (headerHeight / 2)

                    source: "qrc:/assets/icons/material-symbols/more_vert.svg"
                    color: Theme.colorHeaderContent
                }
            }

            ////
        }

        ////////////
    }

    ////////////////////////////////////////////////////////////////////////////
}
