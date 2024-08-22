import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import ThemeEngine

Loader {
    id: screenFontInfos
    anchors.fill: parent

    function loadScreen() {
        // load screen
        screenFontInfos.active = true

        // change screen
        appContent.state = "FontInfos"
    }

    function backAction() {
        if (screenFontInfos.status === Loader.Ready)
            screenFontInfos.item.backAction()
    }

    ////////////////////////////////////////////////////////////////////////////

    active: false
    asynchronous: false

    sourceComponent: Grid {
        id: grid
        anchors.fill: parent

        anchors.topMargin: Theme.componentMargin
        anchors.leftMargin: singleColumn ? 0 : Theme.componentMargin
        anchors.rightMargin: singleColumn ? 0 : Theme.componentMargin
        anchors.bottomMargin: singleColumn ? 0 : Theme.componentMargin

        rows: singleColumn ? 2 : 1
        columns: 1-rows

        property int wwww: Math.floor((grid.width) / (singleColumn ? 1 : 2))
        property int hhhh: Math.floor((grid.height) / (singleColumn ? 2 : 1))

        ////////

        function backAction() {
            if (isDesktop) screenDesktopComponents.loadScreen()
            else if (isMobile) screenMobileComponents.loadScreen()
        }

        ////////

        ColumnLayout { // show different font sizes
            width: grid.wwww
            height: grid.hhhh

            ListTitle {
                Layout.preferredWidth: singleColumn ? parent.width : parent.width - Theme.componentMargin*0.5
                Layout.alignment: Qt.AlignLeft

                anchors.left: undefined
                anchors.right: undefined

                text: "Font sizes"
            }

            ListView {
                Layout.preferredWidth: singleColumn ? parent.width : parent.width - Theme.componentMargin*0.5
                Layout.fillHeight: true
                Layout.alignment: Qt.AlignLeft

                clip: false
                interactive: false

                model: ListModel {
                    Component.onCompleted: {
                        append( {"text": "Header", value: Theme.fontSizeHeader} );
                        append( {"text": "Title", value: Theme.fontSizeTitle} );
                        append( {"text": "VeryVeryBig", value: Theme.fontSizeContentVeryVeryBig} );
                        append( {"text": "VeryBig", value: Theme.fontSizeContentVeryBig} );
                        append( {"text": "Big", value: Theme.fontSizeContentBig} );
                        append( {"text": "(default)", value: Theme.fontSizeContent} );
                        append( {"text": "(components)", value: Theme.componentFontSize} );
                        append( {"text": "Small", value: Theme.fontSizeContentSmall} );
                        append( {"text": "VerySmall", value: Theme.fontSizeContentVerySmall} );
                        append( {"text": "VeryVerySmall", value: Theme.fontSizeContentVeryVerySmall} );
                    }
                }

                delegate: RowLayout {
                    width: ListView.view.width
                    height: Math.max(fontsize.contentHeight, 20)
                    spacing: Theme.componentMargin

                    Text {
                        id: legend
                        Layout.preferredWidth: isDesktop ? 192 : parent.width*0.33
                        Layout.alignment: Qt.AlignBaseline

                        text: model.text
                        textFormat: Text.PlainText
                        horizontalAlignment: Text.AlignRight
                        verticalAlignment: Text.AlignBottom
                        font.pixelSize: Theme.componentFontSize
                        color: Theme.colorSubText
                    }
                    Text {
                        id: fontsize
                        Layout.fillWidth: true
                        Layout.alignment: Qt.AlignBaseline

                        text: model.text + " (" + model.value + "px)"
                        textFormat: Text.PlainText
                        font.pixelSize: model.value
                        color: Theme.colorText
                    }
                }
            }
        }

        ////////

        ColumnLayout { // list all fonts available on the host OS
            width: grid.wwww
            height: grid.hhhh

            ListTitle {
                Layout.preferredWidth: singleColumn ? parent.width : parent.width - Theme.componentMargin*0.5
                Layout.alignment: Qt.AlignRight

                anchors.left: undefined
                anchors.right: undefined

                text: "Fonts available"
            }

            ListView {
                Layout.preferredWidth: singleColumn ? parent.width : parent.width - Theme.componentMargin*0.5
                Layout.fillHeight: true
                Layout.alignment: Qt.AlignRight

                clip: false
                interactive: true

                ScrollBar.vertical: ScrollBar { visible: true }

                model: Qt.fontFamilies()
                delegate: Rectangle {
                    height: 28
                    width: ListView.view.width

                    color: (index % 2) ? Theme.colorForeground :Theme.colorBackground

                    Text {
                        anchors.left: parent.left
                        anchors.leftMargin: screenPaddingLeft + Theme.componentMargin
                        anchors.verticalCenter: parent.verticalCenter

                        text: modelData
                        font.pixelSize: Theme.componentFontSize
                        color: Theme.colorText
                    }
                }
            }
        }

        ////////
    }

    ////////////////////////////////////////////////////////////////////////////
}
