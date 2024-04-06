import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import ThemeEngine

Loader {
    id: screenHostInfos
    anchors.fill: parent

    function loadScreen() {
        // load screen
        screenHostInfos.active = true

        // change screen
        appContent.state = "HostInfos"

        // get current wifi info (on mobile)
        utilsWiFi.refreshWiFi()
    }

    function backAction() {
        if (screenHostInfos.status === Loader.Ready)
            screenHostInfos.item.backAction()
    }

    ////////////////////////////////////////////////////////////////////////////

    active: false
    asynchronous: false

    sourceComponent: Flickable {
        anchors.fill: parent

        contentWidth: -1
        contentHeight: contentFlow.height

        boundsBehavior: isDesktop ? Flickable.OvershootBounds : Flickable.DragAndOvershootBounds
        ScrollBar.vertical: ScrollBar { visible: false }

        function backAction() {
            screenMainView.loadScreen()
        }

        property int flow_width: (contentFlow.width - contentFlow.spacing)
        property int flow_divider: Math.round(flow_width / 512)
        property int www: ((flow_width - (contentFlow.spacing * flow_divider)) / flow_divider)

        Flow {
            id: contentFlow
            anchors.left: parent.left
            anchors.right: parent.right

            property int maxheight: topPadding + bottomPadding + 5*spacing +
                                    itemAppInfo.height + itemQtInfo.height +
                                    itemOsInfo.height + itemHwInfo.height +
                                    itemScreenInfo.height + itemNwInfo.height

            height: singleColumn ? maxheight : screenHostInfos.height
            spacing: Theme.componentMargin
            padding: Theme.componentMargin
            flow: Flow.TopToBottom

            ////////////////////////////////

            FrameThemed {
                id: itemAppInfo
                width: www

                ColumnLayout {
                    anchors.fill: parent
                    spacing: Theme.componentMarginS

                    Column {
                        Text {
                            text: qsTr("App name")
                            textFormat: Text.PlainText
                            color: Theme.colorSubText
                            font.bold: true
                            font.pixelSize: Theme.fontSizeContentVerySmall
                            font.capitalization: Font.AllUppercase
                        }
                        Text {
                            text: utilsApp.appName()
                            textFormat: Text.PlainText
                            font.pixelSize: Theme.fontSizeContentBig
                            color: Theme.colorHighContrast
                        }
                    }

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

            FrameThemed {
                id: itemQtInfo
                width: www

                ColumnLayout {
                    anchors.fill: parent
                    spacing: Theme.componentMarginS

                    Column {
                        Text {
                            text: qsTr("Qt version")
                            textFormat: Text.PlainText
                            color: Theme.colorSubText
                            font.bold: true
                            font.pixelSize: Theme.fontSizeContentVerySmall
                            font.capitalization: Font.AllUppercase
                        }
                        Text {
                            text: utilsApp.qtVersion()
                            textFormat: Text.PlainText
                            font.pixelSize: Theme.fontSizeContentBig
                            color: Theme.colorHighContrast
                        }
                    }

                    Column {
                        visible: false

                        Text {
                            text: qsTr("Qt build mode")
                            textFormat: Text.PlainText
                            color: Theme.colorSubText
                            font.bold: true
                            font.pixelSize: Theme.fontSizeContentVerySmall
                            font.capitalization: Font.AllUppercase
                        }
                        Text {
                            text: utilsApp.qtBuildMode()
                            textFormat: Text.PlainText
                            font.pixelSize: Theme.fontSizeContentBig
                            color: Theme.colorHighContrast
                        }
                    }

                    Column {
                        Text {
                            text: qsTr("Qt build architecture")
                            textFormat: Text.PlainText
                            color: Theme.colorSubText
                            font.bold: true
                            font.pixelSize: Theme.fontSizeContentVerySmall
                            font.capitalization: Font.AllUppercase
                        }
                        Text {
                            text: utilsApp.qtArchitecture()
                            textFormat: Text.PlainText
                            font.pixelSize: Theme.fontSizeContentBig
                            color: Theme.colorHighContrast
                        }
                    }

                    Column {
                        visible: utilsApp.qtRhiBackend()

                        Text {
                            text: qsTr("Qt RHI backend")
                            textFormat: Text.PlainText
                            color: Theme.colorSubText
                            font.bold: true
                            font.pixelSize: Theme.fontSizeContentVerySmall
                            font.capitalization: Font.AllUppercase
                        }
                        Text {
                            text: utilsApp.qtRhiBackend()
                            textFormat: Text.PlainText
                            font.pixelSize: Theme.fontSizeContentBig
                            color: Theme.colorHighContrast
                        }
                    }
                }
            }

            ////////////////////////////////

            FrameThemed {
                id: itemOsInfo
                width: www

                ColumnLayout {
                    anchors.fill: parent
                    spacing: Theme.componentMarginS

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
                            text: utilsSysInfo.os_name
                            textFormat: Text.PlainText
                            color: Theme.colorHighContrast
                            font.pixelSize: Theme.fontSizeContentBig
                        }
                    }

                    Column {
                        visible: (utilsSysInfo.os_version !== "unknown")

                        Text {
                            text: qsTr("Operating System VERSION")
                            textFormat: Text.PlainText
                            color: Theme.colorSubText
                            font.bold: true
                            font.pixelSize: Theme.fontSizeContentVerySmall
                            font.capitalization: Font.AllUppercase
                        }
                        Text {
                            text: utilsSysInfo.os_version
                            textFormat: Text.PlainText
                            color: Theme.colorHighContrast
                            font.pixelSize: Theme.fontSizeContentBig
                        }
                    }

                    Column {
                        visible: utilsSysInfo.os_display_server

                        Text {
                            text: qsTr("Display Server")
                            textFormat: Text.PlainText
                            color: Theme.colorSubText
                            font.bold: true
                            font.pixelSize: Theme.fontSizeContentVerySmall
                            font.capitalization: Font.AllUppercase
                        }
                        Text {
                            text: utilsSysInfo.os_display_server
                            textFormat: Text.PlainText
                            color: Theme.colorHighContrast
                            font.pixelSize: Theme.fontSizeContentBig
                        }
                    }

                    Column {
                        visible: utilsApp.getAndroidSdkVersion() !== 0

                        Text {
                            text: qsTr("Android SDK version")
                            textFormat: Text.PlainText
                            color: Theme.colorSubText
                            font.bold: true
                            font.pixelSize: Theme.fontSizeContentVerySmall
                            font.capitalization: Font.AllUppercase
                        }
                        Text {
                            text: utilsApp.getAndroidSdkVersion()
                            textFormat: Text.PlainText
                            color: Theme.colorHighContrast
                            font.pixelSize: Theme.fontSizeContentBig
                        }
                    }
                }
            }

            ////////////////////////////////

            FrameThemed {
                id: itemHwInfo
                width: www

                ColumnLayout {
                    anchors.fill: parent
                    spacing: Theme.componentMarginS

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
                            text: utilsSysInfo.cpu_arch
                            textFormat: Text.PlainText
                            font.pixelSize: Theme.fontSizeContentBig
                            color: Theme.colorHighContrast
                        }
                    }

                    Column {
                        Text {
                            text: qsTr("Physical / Logical core count")
                            textFormat: Text.PlainText
                            color: Theme.colorSubText
                            font.bold: true
                            font.pixelSize: Theme.fontSizeContentVerySmall
                            font.capitalization: Font.AllUppercase
                        }
                        Text {
                            text: utilsSysInfo.cpu_coreCount_physical + " / " + utilsSysInfo.cpu_coreCount_logical
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
                            text: utilsSysInfo.ram_total + " " + qsTr("MB")
                            textFormat: Text.PlainText
                            color: Theme.colorHighContrast
                            font.pixelSize: Theme.fontSizeContentBig
                        }
                    }
                }
            }

            ////////////////////////////////

            FrameThemed {
                id: itemScreenInfo
                width: www

                ColumnLayout {
                    anchors.fill: parent
                    spacing: Theme.componentMarginS

                    Column {
                        visible: (utilsScreen.screenPar != 1)

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
                        visible: (utilsScreen.screenPar != 1)

                        Text {
                            text: qsTr("Screen DPI (physical)")
                            textFormat: Text.PlainText
                            color: Theme.colorSubText
                            font.bold: true
                            font.pixelSize: Theme.fontSizeContentVerySmall
                            font.capitalization: Font.AllUppercase
                        }
                        Text {
                            text: (utilsScreen.screenDpi*utilsScreen.screenPar).toFixed(1)
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

                    Column {
                        Text {
                            text: qsTr("Screen Aspect Ratio")
                            textFormat: Text.PlainText
                            color: Theme.colorSubText
                            font.bold: true
                            font.pixelSize: Theme.fontSizeContentVerySmall
                            font.capitalization: Font.AllUppercase
                        }
                        Text {
                            text: utilsScreen.screenDar.toFixed(2) + " (" + utilsScreen.screenDarStr + ")"
                            textFormat: Text.PlainText
                            font.pixelSize: Theme.fontSizeContentBig
                            color: Theme.colorHighContrast
                        }
                    }

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
                            text: qsTr("Screen refresh rate")
                            textFormat: Text.PlainText
                            color: Theme.colorSubText
                            font.bold: true
                            font.pixelSize: Theme.fontSizeContentVerySmall
                            font.capitalization: Font.AllUppercase
                        }
                        Text {
                            text: utilsScreen.screenRefreshRate.toFixed(1) + " Hz"
                            textFormat: Text.PlainText
                            font.pixelSize: Theme.fontSizeContentBig
                            color: Theme.colorHighContrast
                        }
                    }

                    Column {
                        Text {
                            text: qsTr("Screen color depth")
                            textFormat: Text.PlainText
                            color: Theme.colorSubText
                            font.bold: true
                            font.pixelSize: Theme.fontSizeContentVerySmall
                            font.capitalization: Font.AllUppercase
                        }
                        Text {
                            text: utilsScreen.screenDepth + " bpp"
                            textFormat: Text.PlainText
                            font.pixelSize: Theme.fontSizeContentBig
                            color: Theme.colorHighContrast
                        }
                    }
                }
            }

            ////////////////////////////////

            FrameThemed {
                id: itemNwInfo
                width: www

                visible: utilsWiFi.currentSSID

                ColumnLayout {
                    anchors.fill: parent
                    spacing: Theme.componentMarginS

                    Column {
                        Text {
                            text: qsTr("WiFi SSID:")
                            textFormat: Text.PlainText
                            color: Theme.colorSubText
                            font.bold: true
                            font.pixelSize: Theme.fontSizeContentVerySmall
                            font.capitalization: Font.AllUppercase
                        }
                        Text {
                            text: utilsWiFi.currentSSID
                            textFormat: Text.PlainText
                            font.pixelSize: Theme.fontSizeContentBig
                            color: Theme.colorHighContrast
                        }
                    }
                }
            }

            ////////////////////////////////////////////////////////////////
        }
    }
}
