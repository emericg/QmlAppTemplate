import QtQuick 2.15
import QtQuick.Controls 2.15

import ThemeEngine 1.0

Item {
    id: screenHostInfos
    width: 1280
    height: 720

    ////////////////////////////////////////////////////////////////////////////

    property int flow_width: (flow.width - flow.spacing)
    property int flow_divider: Math.round(flow_width / 512)
    property int www: ((flow_width - (flow.spacing * flow_divider)) / flow_divider)

    Flickable {
        anchors.fill: parent

        contentWidth: -1
        contentHeight: flow.height

        Flow {
            id: flow
            anchors.left: parent.left
            anchors.right: parent.right
            height: singleColumn ? maxheight : screenHostInfos.height

            property int maxheight: 2*topPadding + 3*spacing + itemSwInfo.height + itemHwInfo.height + itemScreen.height + itemApp.height

            topPadding: 14
            padding: 12
            bottomPadding: 14
            spacing: 12
            flow: Flow.TopToBottom

            ////////////////////////////////

            Rectangle {
                id: itemApp
                width: www
                height: itemAppContent.height + 24

                radius: Theme.componentRadius
                color: Theme.colorForeground
                border.width: 2
                border.color: Theme.colorSeparator

                Column {
                    id: itemAppContent
                    anchors.top: parent.top
                    anchors.topMargin: 12
                    anchors.left: parent.left
                    anchors.leftMargin: 12
                    anchors.right: parent.right
                    anchors.rightMargin: 12
                    spacing: 8

                    Column {
                        Text {
                            text: qsTr("App version")
                            textFormat: Text.PlainText
                            color: Theme.colorSubText
                            font.bold: true
                            font.pixelSize: Theme.fontSizeContentVerySmall
                            font.capitalization: Font.AllUppercase
                        }
                        Text {
                            text: utilsApp.appVersion()
                            textFormat: Text.PlainText
                            font.pixelSize: Theme.fontSizeContentBig
                            color: Theme.colorHighContrast
                        }
                    }

                    Column {
                        Text {
                            text: qsTr("App build date")
                            textFormat: Text.PlainText
                            color: Theme.colorSubText
                            font.bold: true
                            font.pixelSize: Theme.fontSizeContentVerySmall
                            font.capitalization: Font.AllUppercase
                        }
                        Text {
                            text: utilsApp.appBuildDateTime()
                            textFormat: Text.PlainText
                            font.pixelSize: Theme.fontSizeContentBig
                            color: Theme.colorHighContrast
                        }
                    }

                    Column {
                        Text {
                            text: qsTr("App build mode")
                            textFormat: Text.PlainText
                            color: Theme.colorSubText
                            font.bold: true
                            font.pixelSize: Theme.fontSizeContentVerySmall
                            font.capitalization: Font.AllUppercase
                        }
                        Text {
                            text: utilsApp.appBuildModeFull()
                            textFormat: Text.PlainText
                            font.pixelSize: Theme.fontSizeContentBig
                            color: Theme.colorHighContrast
                        }
                    }
                }
            }

            ////////////////////////////////

            Rectangle {
                id: itemScreen
                width: www
                height: itemScreenContent.height + 24

                radius: Theme.componentRadius
                color: Theme.colorForeground
                border.width: 2
                border.color: Theme.colorSeparator

                Column {
                    id: itemScreenContent
                    anchors.top: parent.top
                    anchors.topMargin: 12
                    anchors.left: parent.left
                    anchors.leftMargin: 12
                    anchors.right: parent.right
                    anchors.rightMargin: 12
                    spacing: 8

                    Column {
                        Text {
                            text: qsTr("Screen size")
                            textFormat: Text.PlainText
                            color: Theme.colorSubText
                            font.bold: true
                            font.pixelSize: Theme.fontSizeContentVerySmall
                            font.capitalization: Font.AllUppercase
                        }
                        Text {
                            text: utilsScreen.screenSize.toFixed(1) + " " + qsTr("inches")
                            textFormat: Text.PlainText
                            font.pixelSize: Theme.fontSizeContentBig
                            color: Theme.colorHighContrast
                        }
                    }

                    Column {
                        Text {
                            text: qsTr("Screen depth & rate")
                            textFormat: Text.PlainText
                            color: Theme.colorSubText
                            font.bold: true
                            font.pixelSize: Theme.fontSizeContentVerySmall
                            font.capitalization: Font.AllUppercase
                        }
                        Text {
                            text: utilsScreen.screenDepth + " bpp @ " + utilsScreen.screenRefreshRate.toFixed(1) + " Hz"
                            textFormat: Text.PlainText
                            font.pixelSize: Theme.fontSizeContentBig
                            color: Theme.colorHighContrast
                        }
                    }

                    Column {
                        Text {
                            text: qsTr("Screen geometry")
                            textFormat: Text.PlainText
                            color: Theme.colorSubText
                            font.bold: true
                            font.pixelSize: Theme.fontSizeContentVerySmall
                            font.capitalization: Font.AllUppercase
                        }
                        Text {
                            text: utilsScreen.screenWidth + " x " + utilsScreen.screenHeight
                            textFormat: Text.PlainText
                            font.pixelSize: Theme.fontSizeContentBig
                            color: Theme.colorHighContrast
                        }
                    }

                    Column {
                        visible: utilsScreen.screenPar != 1

                        Text {
                            text: qsTr("Screen geometry (physical)")
                            textFormat: Text.PlainText
                            color: Theme.colorSubText
                            font.bold: true
                            font.pixelSize: Theme.fontSizeContentVerySmall
                            font.capitalization: Font.AllUppercase
                        }
                        Text {
                            text: (utilsScreen.screenWidth*utilsScreen.screenPar).toFixed(1) + " x "
                                  + (utilsScreen.screenHeight*utilsScreen.screenPar).toFixed(1)
                            textFormat: Text.PlainText
                            font.pixelSize: Theme.fontSizeContentBig
                            color: Theme.colorHighContrast
                        }
                    }

                    Column {
                        Text {
                            text: qsTr("Screen DPI")
                            textFormat: Text.PlainText
                            color: Theme.colorSubText
                            font.bold: true
                            font.pixelSize: Theme.fontSizeContentVerySmall
                            font.capitalization: Font.AllUppercase
                        }
                        Text {
                            text: utilsScreen.screenDpi
                            textFormat: Text.PlainText
                            font.pixelSize: Theme.fontSizeContentBig
                            color: Theme.colorHighContrast
                        }
                    }

                    Column {
                        visible: utilsScreen.screenPar != 1

                        Text {
                            text: qsTr("Screen DPI (physical)")
                            textFormat: Text.PlainText
                            color: Theme.colorSubText
                            font.bold: true
                            font.pixelSize: Theme.fontSizeContentVerySmall
                            font.capitalization: Font.AllUppercase
                        }
                        Text {
                            text: (utilsScreen.screenDpi*utilsScreen.screenPar).toFixed(0)
                            textFormat: Text.PlainText
                            font.pixelSize: Theme.fontSizeContentBig
                            color: Theme.colorHighContrast
                        }
                    }

                    Column {
                        Text {
                            text: qsTr("Screen Pixel Aspect Ratio")
                            textFormat: Text.PlainText
                            color: Theme.colorSubText
                            font.bold: true
                            font.pixelSize: Theme.fontSizeContentVerySmall
                            font.capitalization: Font.AllUppercase
                        }
                        Text {
                            text: utilsScreen.screenPar.toFixed(1)
                            textFormat: Text.PlainText
                            font.pixelSize: Theme.fontSizeContentBig
                            color: Theme.colorHighContrast
                        }
                    }
                }
            }

            ////////////////////////////////

            Rectangle {
                id: itemHwInfo
                width: www
                height: itemHwInfoContent.height + 24

                radius: Theme.componentRadius
                color: Theme.colorForeground
                border.width: 2
                border.color: Theme.colorSeparator

                Column {
                    id: itemHwInfoContent
                    anchors.top: parent.top
                    anchors.topMargin: 12
                    anchors.left: parent.left
                    anchors.leftMargin: 12
                    anchors.right: parent.right
                    anchors.rightMargin: 12

                    spacing: 12

                    Column {
                        Text {
                            text: qsTr("CPU architecture")
                            textFormat: Text.PlainText
                            color: Theme.colorSubText
                            font.bold: true
                            font.pixelSize: Theme.fontSizeContentVerySmall
                            font.capitalization: Font.AllUppercase
                        }
                        Text {
                            text: utilsSysinfo.cpu_arch
                            textFormat: Text.PlainText
                            font.pixelSize: Theme.fontSizeContentBig
                            color: Theme.colorHighContrast
                        }
                    }

                    Column {
                        Text {
                            text: qsTr("Physical core count")
                            textFormat: Text.PlainText
                            color: Theme.colorSubText
                            font.bold: true
                            font.pixelSize: Theme.fontSizeContentVerySmall
                            font.capitalization: Font.AllUppercase
                        }
                        Text {
                            text: utilsSysinfo.cpu_coreCount_physical
                            textFormat: Text.PlainText
                            font.pixelSize: Theme.fontSizeContentBig
                            color: Theme.colorHighContrast
                        }
                    }

                    Column {
                        Text {
                            text: qsTr("Logical core count")
                            textFormat: Text.PlainText
                            color: Theme.colorSubText
                            font.bold: true
                            font.pixelSize: Theme.fontSizeContentVerySmall
                            font.capitalization: Font.AllUppercase
                        }
                        Text {
                            text: utilsSysinfo.cpu_coreCount_logical
                            textFormat: Text.PlainText
                            font.pixelSize: Theme.fontSizeContentBig
                            color: Theme.colorHighContrast
                        }
                    }

                    Column {
                        Text {
                            text: qsTr("RAM")
                            textFormat: Text.PlainText
                            color: Theme.colorSubText
                            font.bold: true
                            font.pixelSize: Theme.fontSizeContentVerySmall
                            font.capitalization: Font.AllUppercase
                        }
                        Text {
                            text: utilsSysinfo.ram_total + " " + qsTr("MB")
                            textFormat: Text.PlainText
                            color: Theme.colorHighContrast
                            font.pixelSize: Theme.fontSizeContentBig
                        }
                    }
                }
            }

            ////////////////////////////////

            Rectangle {
                id: itemSwInfo
                width: www
                height: itemSwInfoContent.height + 24

                radius: Theme.componentRadius
                color: Theme.colorForeground
                border.width: 2
                border.color: Theme.colorSeparator

                Column {
                    id: itemSwInfoContent
                    anchors.top: parent.top
                    anchors.topMargin: 12
                    anchors.left: parent.left
                    anchors.leftMargin: 12
                    anchors.right: parent.right
                    anchors.rightMargin: 12

                    spacing: 12

                    Column {
                        Text {
                            text: qsTr("Operating System")
                            textFormat: Text.PlainText
                            color: Theme.colorSubText
                            font.bold: true
                            font.pixelSize: Theme.fontSizeContentVerySmall
                            font.capitalization: Font.AllUppercase
                        }
                        Text {
                            text: utilsSysinfo.os_name
                            textFormat: Text.PlainText
                            color: Theme.colorHighContrast
                            font.pixelSize: Theme.fontSizeContentBig
                        }
                    }
                }
            }

            ////////////////////////////////
        }
    }
}
