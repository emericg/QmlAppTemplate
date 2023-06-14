import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import ThemeEngine 1.0

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

    sourceComponent: GridLayout {
        id: grid
        anchors.fill: parent
        anchors.margins: 0

        columns: singleColumn ? 1 : 2
        columnSpacing: 0

        property int wwww: Math.floor((screenFontInfos.width) / (singleColumn ? 1 : 2))
        property int hhhh: Math.floor((screenFontInfos.height) / (singleColumn ? 2 : 1))

        ////////

        function backAction() {
            //
        }

        ////////

        ListView { // show different font sizes
            Layout.preferredWidth: grid.wwww
            Layout.preferredHeight: grid.hhhh

            clip: false
            interactive: false

            topMargin: 12
            bottomMargin: 12

            headerPositioning: ListView.OverlayHeader
            header: SectionTitle {
                anchors.leftMargin: singleColumn ? -parent.leftMargin : 0
                anchors.rightMargin: singleColumn ? -parent.rightMargin : 0
                text: "Font sizes:"
            }

            model: ListModel {
                Component.onCompleted: {
                    append( {"text": "Header", value: Theme.fontSizeHeader} );
                    append( {"text": "Title", value: Theme.fontSizeTitle} );
                    append( {"text": "ContentVeryVerySmall", value: Theme.fontSizeContentVeryVerySmall} );
                    append( {"text": "ContentVerySmall", value: Theme.fontSizeContentVerySmall} );
                    append( {"text": "ContentSmall", value: Theme.fontSizeContentSmall} );
                    append( {"text": "Content", value: Theme.fontSizeContent} );
                    append( {"text": "ContentBig", value: Theme.fontSizeContentBig} );
                    append( {"text": "ContentVeryBig", value: Theme.fontSizeContentVeryBig} );
                    append( {"text": "ContentVeryVeryBig", value: Theme.fontSizeContentVeryVeryBig} );
                    append( {"text": "Component", value: Theme.fontSizeComponent} );
                }
            }

            delegate: RowLayout {
                width: ListView.view.width
                height: 32
                spacing: 16

                Text {
                    Layout.preferredWidth: 192

                    text: model.text
                    textFormat: Text.PlainText
                    horizontalAlignment: Text.AlignRight
                    verticalAlignment: Text.AlignBottom
                    font.pixelSize: Theme.fontSizeComponent
                    color: Theme.colorSubText
                }
                Text {
                    Layout.fillWidth: true

                    text: model.text + " (" + model.value + "px)"
                    textFormat: Text.PlainText
                    font.pixelSize: model.value
                    color: Theme.colorText
                }
            }
        }

        ////////

        ListView { // list all fonts available on the host OS
            Layout.preferredWidth: grid.wwww
            Layout.preferredHeight: grid.hhhh

            clip: !singleColumn
            interactive: true

            topMargin: 16
            bottomMargin: 16

            ScrollBar.vertical: ScrollBar { }

            headerPositioning: ListView.OverlayHeader
            header: SectionTitle {
                anchors.leftMargin: singleColumn ? -12 : 0
                anchors.rightMargin: singleColumn ? -12 : 0
                text: "Fonts available:"
            }

            model: Qt.fontFamilies()
            delegate: Rectangle {
                height: 32
                width: ListView.view.width

                color: (index % 2) ? Theme.colorForeground :Theme.colorBackground

                Text {
                    anchors.left: parent.left
                    anchors.leftMargin: 16
                    anchors.verticalCenter: parent.verticalCenter

                    text: modelData
                    font.pixelSize: Theme.fontSizeComponent
                    color: Theme.colorText
                }
            }
        }

        ////////
    }

    ////////////////////////////////////////////////////////////////////////////
}
