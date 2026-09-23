import QtQuick
import QtQuick.Controls

import ComponentLibrary

Loader {
    id: screenDesktopComponents
    anchors.fill: parent

    function loadScreen() {
        // load screen
        screenDesktopComponents.active = true

        // change screen
        appContent.state = "DesktopComponents"
    }

    function backAction() {
        if (screenDesktopComponents.status === Loader.Ready)
            return screenDesktopComponents.item.backAction()

        return false
    }

    property int stackViewDepth: {
        if (screenDesktopComponents.status === Loader.Ready)
            return screenDesktopComponents.item.stackViewDepth
        return 0
    }

    ////////////////////////////////////////////////////////////////////////////

    active: false
    asynchronous: false

    sourceComponent: Item {
        anchors.fill: parent

        property alias stackViewDepth: stackView.depth

        ////////

        function backAction() {
            if (stackView.depth > 1) {
                stackView.pop()
                return true
            }

            return false
        }

        ////////

        StackView {
            id: stackView
            anchors.fill: parent

            initialItem: mainView
        }

        Component {
            id: mainView

            Flickable {
                contentWidth: -1
                contentHeight: pagesGrid.height

                boundsBehavior: Flickable.OvershootBounds
                ScrollBar.vertical: ScrollBarThemed { }

                DemoPagesModel { id: pagesModel }

                ////////

                Flow {
                    id: pagesGrid

                    anchors.left: parent.left
                    anchors.leftMargin: Theme.componentMarginXL + (Theme.singleColumn ? 0 : parent.width*0.125)
                    anchors.right: parent.right
                    anchors.rightMargin: Theme.componentMarginXL + (Theme.singleColumn ? 0 : parent.width*0.125)

                    topPadding: Theme.componentMarginXL
                    bottomPadding: Theme.componentMarginXL
                    spacing: Theme.componentMargin

                    readonly property int columns: Math.max(1, Math.floor((width + spacing) / (480 + spacing)))
                    readonly property real cardWidth: (width - (columns - 1) * spacing) / columns

                    MediaCardLeft {
                        width: pagesGrid.cardWidth
                        height: implicitHeight

                        mediaWidth: pagesGrid.cardWidth * 0.40
                        iconSource: "qrc:/IconLibrary/material-symbols/hardware/computer.svg"

                        title: qsTr("Overview")
                        description: qsTr("Many components, all on one screen.")
                        gradientStops: GradientPresets.midnight
                        primaryText: qsTr("Open")
                        primaryStyle: CardActionRow.ButtonStyle.Clear
                        primarySource: "qrc:/IconLibrary/material-symbols/chevron_right.svg"
                        actionAlignment: Qt.AlignRight

                        onClicked: stackView.push("demo/ComponentsOverview.qml")
                        onPrimaryClicked: stackView.push("demo/ComponentsOverview.qml")

                        IconSvg {
                            anchors.horizontalCenter: parent.horizontalCenter
                            y: (parent.mediaHeight - height) / 2
                            width: 80
                            height: 80
                            color: "white"
                        }
                    }

                    Repeater {
                        model: pagesModel

                        delegate: MediaCardLeft {
                            width: pagesGrid.cardWidth
                            height: implicitHeight

                            mediaWidth: pagesGrid.cardWidth * 0.40
                            iconSource: model.icon

                            title: model.title
                            description: model.text
                            gradientStops: GradientPresets[model.gradient]

                            primaryText: qsTr("Open")
                            primaryStyle: CardActionRow.ButtonStyle.Clear
                            primarySource: "qrc:/IconLibrary/material-symbols/chevron_right.svg"
                            actionAlignment: Qt.AlignRight

                            onClicked: stackView.push(model.page)
                            onPrimaryClicked: stackView.push(model.page)
                        }
                    }
                }
            }
        }
    }

    ////////////////////////////////////////////////////////////////////////////
}
