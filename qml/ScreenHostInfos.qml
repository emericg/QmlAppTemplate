import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import ThemeEngine 1.0

Loader {
    id: screenHostInfos
    anchors.fill: parent

    function loadScreen() {
        // load screen
        screenHostInfos.active = true

        // change screen
        appContent.state = "HostInfos"
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
        ScrollBar.vertical: ScrollBar { visible: isDesktop; }

        function backAction() {
            //
        }

        property int flow_width: (contentFlow.width - contentFlow.spacing)
        property int flow_divider: Math.round(flow_width / 512)
        property int www: ((flow_width - (contentFlow.spacing * flow_divider)) / flow_divider)

        Flow {
            id: contentFlow
            anchors.left: parent.left
            anchors.right: parent.right

            property int maxheight: topPadding + bottomPadding + 4*spacing +
                                    itemAppInfo.height + itemQtInfo.height +
                                    itemOsInfo.height + itemHwInfo.height + itemScreenInfo.height

            height: singleColumn ? maxheight : screenHostInfos.height
            spacing: 12
            flow: Flow.TopToBottom

            topPadding: 14
            padding: 12
            bottomPadding: 14

            ////////////////////////////////

            FrameThemed {
                id: itemAppInfo
                width: www

                ColumnLayout {
                    anchors.fill: parent
                    spacing: 12

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
                    spacing: 12

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
                }
            }

            ////////////////////////////////

            FrameThemed {
                id: itemOsInfo
                width: www

                ColumnLayout {
                    anchors.fill: parent
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

                    Column {
                        visible: utilsSysinfo.os_version !== "unknown"

                        Text {
                            text: qsTr("Operating System VERSION")
                            textFormat: Text.PlainText
                            color: Theme.colorSubText
                            font.bold: true
                            font.pixelSize: Theme.fontSizeContentVerySmall
                            font.capitalization: Font.AllUppercase
                        }
                        Text {
                            text: utilsSysinfo.os_version
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

            FrameThemed {
                id: itemScreenInfo
                width: www

                ColumnLayout {
                    anchors.fill: parent
                    spacing: 12

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

            ////////////////////////////////////////////////////////////////
        }
    }
}
