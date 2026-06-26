import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import ComponentLibrary
import AppUtils

Loader {
    id: screenHostInfos
    anchors.fill: parent

    function loadScreen() {
        // load screen
        screenHostInfos.active = true

        // change screen
        appContent.state = "HostInfos"

        // get current wifi info (on mobile)
        UtilsWiFi.refreshWiFi()
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

        ////////

        function backAction() {
            if (isDesktop) screenDesktopComponents.loadScreen()
            else if (isMobile) screenMobileComponents.loadScreen()
        }

        ////////

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
                            text: UtilsApp.appName()
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
                            text: UtilsApp.appVersion()
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
                            text: UtilsApp.appBuildDateTime()
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
                            text: UtilsApp.appBuildModeFull()
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
                            text: UtilsApp.qtVersion()
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
                            text: UtilsApp.qtBuildMode()
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
                            text: UtilsApp.qtArchitecture()
                            textFormat: Text.PlainText
                            font.pixelSize: Theme.fontSizeContentBig
                            color: Theme.colorHighContrast
                        }
                    }

                    Column {
                        visible: UtilsApp.qtRhiBackend()

                        Text {
                            text: qsTr("Qt RHI backend")
                            textFormat: Text.PlainText
                            color: Theme.colorSubText
                            font.bold: true
                            font.pixelSize: Theme.fontSizeContentVerySmall
                            font.capitalization: Font.AllUppercase
                        }
                        Text {
                            text: UtilsApp.qtRhiBackend()
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
                            text: UtilsSysInfo.os_name
                            textFormat: Text.PlainText
                            color: Theme.colorHighContrast
                            font.pixelSize: Theme.fontSizeContentBig
                        }
                    }

                    Column {
                        visible: (UtilsSysInfo.os_version !== "unknown")

                        Text {
                            text: qsTr("Operating System VERSION")
                            textFormat: Text.PlainText
                            color: Theme.colorSubText
                            font.bold: true
                            font.pixelSize: Theme.fontSizeContentVerySmall
                            font.capitalization: Font.AllUppercase
                        }
                        Text {
                            text: UtilsSysInfo.os_version
                            textFormat: Text.PlainText
                            color: Theme.colorHighContrast
                            font.pixelSize: Theme.fontSizeContentBig
                        }
                    }

                    Column {
                        visible: UtilsSysInfo.os_display_server

                        Text {
                            text: qsTr("Display Server")
                            textFormat: Text.PlainText
                            color: Theme.colorSubText
                            font.bold: true
                            font.pixelSize: Theme.fontSizeContentVerySmall
                            font.capitalization: Font.AllUppercase
                        }
                        Text {
                            text: UtilsSysInfo.os_display_server
                            textFormat: Text.PlainText
                            color: Theme.colorHighContrast
                            font.pixelSize: Theme.fontSizeContentBig
                        }
                    }

                    Column {
                        visible: UtilsApp.getAndroidSdkVersion() !== 0

                        Text {
                            text: qsTr("Android SDK version")
                            textFormat: Text.PlainText
                            color: Theme.colorSubText
                            font.bold: true
                            font.pixelSize: Theme.fontSizeContentVerySmall
                            font.capitalization: Font.AllUppercase
                        }
                        Text {
                            text: UtilsApp.getAndroidSdkVersion()
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
                            text: UtilsSysInfo.cpu_arch
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
                            text: UtilsSysInfo.cpu_coreCount_physical + " / " + UtilsSysInfo.cpu_coreCount_logical
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
                            text: UtilsSysInfo.ram_total + " " + qsTr("MB")
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
                        visible: (UtilsScreen.screenPar != 1)

                        Text {
                            text: qsTr("Screen geometry (physical)")
                            textFormat: Text.PlainText
                            color: Theme.colorSubText
                            font.bold: true
                            font.pixelSize: Theme.fontSizeContentVerySmall
                            font.capitalization: Font.AllUppercase
                        }
                        Text {
                            text: (UtilsScreen.screenWidth*UtilsScreen.screenPar).toFixed(1) + " x "
                                  + (UtilsScreen.screenHeight*UtilsScreen.screenPar).toFixed(1)
                            textFormat: Text.PlainText
                            font.pixelSize: Theme.fontSizeContentBig
                            color: Theme.colorHighContrast
                        }
                    }

                    Column {
                        visible: (UtilsScreen.screenPar != 1)

                        Text {
                            text: qsTr("Screen DPI (physical)")
                            textFormat: Text.PlainText
                            color: Theme.colorSubText
                            font.bold: true
                            font.pixelSize: Theme.fontSizeContentVerySmall
                            font.capitalization: Font.AllUppercase
                        }
                        Text {
                            text: (UtilsScreen.screenDpi*UtilsScreen.screenPar).toFixed(1)
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
                            text: UtilsScreen.screenWidth + " x " + UtilsScreen.screenHeight
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
                            text: UtilsScreen.screenDpi
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
                            text: UtilsScreen.screenPar.toFixed(1)
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
                            text: UtilsScreen.screenDar.toFixed(2) + " (" + UtilsScreen.screenDarStr + ")"
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
                            text: UtilsScreen.screenSize.toFixed(1) + " " + qsTr("inches")
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
                            text: UtilsScreen.screenRefreshRate.toFixed(1) + " Hz"
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
                            text: UtilsScreen.screenDepth + " bpp"
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

                visible: UtilsWiFi.currentSSID

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
                            text: UtilsWiFi.currentSSID
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
