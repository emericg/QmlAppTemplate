import QtQuick
import QtQuick.Controls

import ComponentLibrary
import AppUtils

Flickable {
    contentWidth: -1
    contentHeight: contentColumn.height

    boundsBehavior: Theme.isDesktop ? Flickable.OvershootBounds : Flickable.DragAndOvershootBounds
    ScrollBar.vertical: ScrollBarThemed { visible: Theme.isDesktop }

    // Shared demo content
    readonly property string demoTitle: qsTr("What's new in 0.8")
    readonly property string demoTag: qsTr("Release 0.8")
    readonly property string demoDescription: qsTr("A revamped UI and component library, rebuilt and expanded dialogs support.")
    readonly property string demoPrimary: qsTr("Read notes")
    readonly property string demoSecondary: qsTr("Dismiss")

    Column {
        id: contentColumn

        anchors.left: parent.left
        anchors.leftMargin: Theme.singleColumn ? 0 : parent.width*0.125
        anchors.right: parent.right
        anchors.rightMargin: Theme.singleColumn ? 0 : parent.width*0.125

        topPadding: Theme.componentMarginXL
        bottomPadding: Theme.componentMarginXL
        spacing: Theme.componentMarginXL

        ListTitle { ////////////////////////////////////////////////////////////
            anchors.leftMargin: singleColumn ? 0 : Theme.componentMargin
            anchors.rightMargin: singleColumn ? 0 : Theme.componentMargin

            text: qsTr("Media cards")
            source: ""
        }

        Flow {
            anchors.left: parent.left
            anchors.leftMargin: Theme.componentMarginXL
            anchors.right: parent.right
            anchors.rightMargin: Theme.componentMarginXL
            spacing: Theme.componentMarginXL

            readonly property int availableWidth: width

            MediaCardTop {
                width: Math.min(implicitWidth, parent.availableWidth)

                tagText: demoTag
                title: demoTitle
                description: demoDescription
                primaryText: demoPrimary
                secondaryText: demoSecondary
                hoverEffect: MediaCardTop.HoverEffect.Shadow

                onPrimaryClicked: console.log("MediaCardTop primary")
                onSecondaryClicked: console.log("MediaCardTop secondary")
            }

            MediaCardTopInset {
                width: Math.min(implicitWidth, parent.availableWidth)

                tagText: demoTag
                title: demoTitle
                description: demoDescription
                primaryText: demoPrimary
                secondaryText: demoSecondary
                hoverEffect: MediaCardTopInset.HoverEffect.Border

                onPrimaryClicked: console.log("MediaCardTopInset primary")
                onSecondaryClicked: console.log("MediaCardTopInset secondary")
            }

            MediaCardBottom {
                width: Math.min(implicitWidth, parent.availableWidth)

                tagText: demoTag
                title: demoTitle
                description: demoDescription
                primaryText: demoPrimary
                secondaryText: demoSecondary
                hoverEffect: MediaCardBottom.HoverEffect.Shadow

                onPrimaryClicked: console.log("MediaCardBottom primary")
                onSecondaryClicked: console.log("MediaCardBottom secondary")
            }

            MediaCardLeft {
                width: Math.min(implicitWidth, parent.availableWidth)

                tagText: demoTag
                title: demoTitle
                description: demoDescription
                primaryText: demoPrimary
                secondaryText: demoSecondary
                hoverEffect: MediaCardLeft.HoverEffect.Border

                onPrimaryClicked: console.log("MediaCardLeft primary")
                onSecondaryClicked: console.log("MediaCardLeft secondary")
            }

            MediaCardCompact {
                width: Math.min(implicitWidth, parent.availableWidth)

                tagText: demoTag
                title: demoTitle
                description: demoDescription
                primaryText: demoPrimary
                hoverEffect: MediaCardCompact.HoverEffect.Shadow

                onPrimaryClicked: console.log("MediaCardCompact primary")
            }

            MediaCardCompactInset {
                width: Math.min(implicitWidth, parent.availableWidth)

                tagText: demoTag
                title: demoTitle
                description: demoDescription
                primaryText: demoPrimary
                hoverEffect: MediaCardCompactInset.HoverEffect.Shadow

                onPrimaryClicked: console.log("MediaCardCompactInset primary")
            }
        }

        ListTitle { ////////////////////////////////////////////////////////////
            anchors.leftMargin: singleColumn ? 0 : Theme.componentMargin
            anchors.rightMargin: singleColumn ? 0 : Theme.componentMargin

            text: qsTr("CardSquare")
            source: ""
        }

        Flow {
            anchors.left: parent.left
            anchors.leftMargin: Theme.componentMarginXL
            anchors.right: parent.right
            anchors.rightMargin: Theme.componentMarginXL
            spacing: Theme.componentMarginXL

            Repeater {
                model: [
                    { value: "1.8k", trend: "78%", text: qsTr("Stars"), action: qsTr("Full Projects Report"),
                      icon: "folder.svg", stops: GradientPresets.violet },
                    { value: "98%", trend: "18.4%", text: qsTr("Satisfied users"), action: qsTr("Full Growth Report"),
                      icon: "insert_chart.svg", stops: GradientPresets.sunset },
                    { value: "1.2k", trend: "9.7%", text: qsTr("Active Runs"), action: qsTr("Full Activity Report"),
                      icon: "sensors/monitor_heart.svg", stops: GradientPresets.cosmic },
                    { value: "$42.9k", trend: "9.09%", text: qsTr("CI costs"), action: qsTr("Full Costs Rundown"),
                      icon: "storage.svg", stops: GradientPresets.emerald },
                ]

                delegate: CardSquare {
                    required property var modelData

                    text: modelData.value
                    legend: modelData.text
                    source: "qrc:/IconLibrary/material-symbols/" + modelData.icon
                    gradientStops: modelData.stops

                    tagIcon: "qrc:/IconLibrary/material-symbols/trending_up.svg"
                    tagText: modelData.trend

                    footerText: modelData.action

                    onPrimaryClicked: console.log("CardSquare clicked: " + modelData.action)
                }
            }
        }

        ListTitle { ////////////////////////////////////////////////////////////
            anchors.leftMargin: singleColumn ? 0 : Theme.componentMargin
            anchors.rightMargin: singleColumn ? 0 : Theme.componentMargin

            text: qsTr("Simple cards")
            source: ""
        }

        Flow {
            anchors.left: parent.left
            anchors.leftMargin: Theme.componentMarginXL
            anchors.right: parent.right
            anchors.rightMargin: Theme.componentMarginXL
            spacing: Theme.componentMarginXL

            Repeater {
                model: ListModel {
                    ListElement {
                        backgroundColor: "#9C27B0" // colorMaterialPurple
                        title: "Get started"
                        hint: "Set up your workspace in a few quick steps."
                        icon: "qrc:/IconLibrary/material-icons/duotone/touch_app.svg"
                    }
                    ListElement {
                        backgroundColor: "#009688" // colorMaterialTeal
                        title: "Explore"
                        hint: "Discover every component the library has to offer."
                        icon: "qrc:/IconLibrary/material-icons/duotone/style.svg"
                    }
                }

                delegate: SimpleCardTop {
                    width: 640
                    height: 480
                    onClicked: console.log("CardWelcome clicked: " + title)
                }
            }
        }

        Flow {
            anchors.left: parent.left
            anchors.right: parent.right
            spacing: Theme.componentMarginXL

            Repeater {
                model: ListModel {
                    ListElement {
                        cardText: "Now playing"
                        cardSubtext: "Ambient mix"
                        btn: "Play"
                        icon: "qrc:/ComponentLibraryAssets/patterns/topography_light.svg"
                    }
                    ListElement {
                        cardText: "Latest report"
                        cardSubtext: "Updated today"
                        btn: "Open"
                        icon: "qrc:/ComponentLibraryAssets/patterns/topography_ultralight.svg"
                    }
                }

                delegate: SimpleCardLeftRight {
                    width: 640
                    height: 480

                    text: model.cardText
                    subtext: model.cardSubtext
                    source: model.icon
                    btnText: model.btn
                }
            }
        }

        Column {
            anchors.left: parent.left
            anchors.leftMargin: Theme.componentMarginXL
            anchors.right: parent.right
            anchors.rightMargin: Theme.componentMarginXL
            spacing: Theme.componentMarginL

            Repeater {
                model: ListModel {
                    ListElement {
                        title: "Wireless"
                        subtitle: "Connected"
                        accent: "#2196F3" // colorMaterialBlue
                        icon: "qrc:/IconLibrary/material-symbols/link.svg"
                    }
                    ListElement {
                        title: "Storage"
                        subtitle: "128 GB available"
                        accent: "#009688" // colorMaterialTeal
                        icon: "qrc:/IconLibrary/material-icons/duotone/speed.svg"
                    }
                    ListElement {
                        title: "Appearance"
                        subtitle: "Theme and colors"
                        accent: "#9C27B0" // colorMaterialPurple
                        icon: "qrc:/IconLibrary/material-icons/duotone/style.svg"
                    }
                }

                delegate: SimpleCardList {
                    required subtitle
                    required property color accent

                    width: parent.width
                    accentColor: accent

                    onClicked: console.log("CardSimple clicked: " + title)
                }
            }
        }

        ////////////////////////////////////////////////////////////////////////
    }
}
