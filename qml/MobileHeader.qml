import QtQuick 2.15

import ThemeEngine 1.0

Rectangle {
    id: appHeader
    anchors.top: parent.top
    anchors.left: parent.left
    anchors.right: parent.right

    z: 10
    height: screenPaddingStatusbar + screenPaddingNotch + headerHeight
    color: Theme.colorHeader

    property int headerHeight: 52

    property string headerTitle: "QmlAppTemplate"

    ////////////////////////////////////////////////////////////////////////////

    property string leftMenuMode: "drawer" // drawer / back / close
    signal leftMenuClicked()

    onLeftMenuModeChanged: {
        if (leftMenuMode === "drawer")
            leftMenuImg.source = "qrc:/assets/icons_material/baseline-menu-24px.svg"
        else if (leftMenuMode === "close")
            leftMenuImg.source = "qrc:/assets/icons_material/baseline-close-24px.svg"
        else // back
            leftMenuImg.source = "qrc:/assets/icons_material/baseline-arrow_back-24px.svg"
    }

    ////////////////////////////////////////////////////////////////////////////

    property string rightMenuMode: "off" // on / off
    signal rightMenuClicked()

    function rightMenuIsOpen() { return actionMenu.visible; }
    function rightMenuClose() { actionMenu.close(); }

    ////////////////////////////////////////////////////////////////////////////

    // prevent clicks below this area
    MouseArea { anchors.fill: parent; acceptedButtons: Qt.AllButtons; }

    Item {
        anchors.fill: parent
        anchors.topMargin: screenPaddingStatusbar + screenPaddingNotch

        MouseArea {
            id: leftArea
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.bottom: parent.bottom

            width: headerHeight
            height: headerHeight
            visible: true

            onClicked: leftMenuClicked()

            IconSvg {
                id: leftMenuImg
                anchors.left: parent.left
                anchors.leftMargin: 16
                anchors.verticalCenter: parent.verticalCenter

                width: (headerHeight / 2)
                height: (headerHeight / 2)

                source: "qrc:/assets/icons_material/baseline-menu-24px.svg"
                color: Theme.colorHeaderContent
            }
        }

        Text { // title
            height: parent.height
            anchors.left: parent.left
            anchors.leftMargin: 64
            anchors.verticalCenter: parent.verticalCenter

            text: appHeader.headerTitle
            color: Theme.colorHeaderContent
            font.bold: true
            font.pixelSize: Theme.fontSizeHeader
            font.capitalization: Font.Capitalize
            verticalAlignment: Text.AlignVCenter
        }

        ////////////

        Row {
            id: menu
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.rightMargin: 4
            anchors.bottom: parent.bottom

            spacing: 4
            visible: true

            Item {
                anchors.verticalCenter: parent.verticalCenter

                width: parent.height
                height: width
                visible: (appContent.state === "MobileComponents")

                IconSvg {
                    id: workingIndicator
                    anchors.centerIn: parent

                    width: 24
                    height: 24

                    source: "qrc:/assets/icons_material/baseline-autorenew-24px.svg"
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

            ////////////

            MouseArea {
                id: rightMenu

                width: headerHeight
                height: headerHeight
                visible: (appContent.state === "MobileComponents")

                onClicked: {
                    rightMenuClicked()
                    actionMenu.open()
                }

                IconSvg {
                    id: rightMenuImg
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter

                    width: (headerHeight / 2)
                    height: (headerHeight / 2)

                    source: "qrc:/assets/icons_material/baseline-more_vert-24px.svg"
                    color: Theme.colorHeaderContent
                }

                ActionMenu_bottom {
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
        }
    }

    ////////////
}
