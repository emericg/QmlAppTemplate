pragma ComponentBehavior: Bound

import QtCore
import QtQuick
import QtQuick.Controls
import QtQuick.Dialogs

import ComponentLibrary

Item {
    id: editorPanel

    property int panelWidth: 512
    property bool opened: false
    property int currentTab: 0 // 0: status, 1: colors, 2: components, 3: fonts

    width: opened ? panelWidth : 0
    Behavior on width { NumberAnimation { duration: Theme.animationMediumSpeed; easing.type: Easing.OutQuad } }

    function toggle() {
        if (!opened) {
            opened = true
            loaderEditor.active = true
        } else {
            opened = false
        }
    }

    ////////////////////////////////////////////////////////////////////////////

    readonly property var themeColors: [
        { "section": qsTr("Content"),     "names": ["colorBackground", "colorForeground", "colorText", "colorSubText", "colorIcon", "colorSeparator", "colorLowContrast", "colorHighContrast"] },
        { "section": qsTr("Accent"),      "names": ["colorPrimary", "colorSecondary", "colorSuccess", "colorWarning", "colorError"] },
        { "section": qsTr("Header"),      "names": ["colorHeader", "colorHeaderContent", "colorHeaderHighlight"] },
        { "section": qsTr("Action bar"),  "names": ["colorActionbar", "colorActionbarContent", "colorActionbarHighlight"] },
        { "section": qsTr("Sidebar"),     "names": ["colorSidebar", "colorSidebarContent", "colorSidebarHighlight"] },
        { "section": qsTr("Status bar"),  "names": ["colorStatusbar"] },
        { "section": qsTr("Tablet menu"), "names": ["colorTabletmenu", "colorTabletmenuContent", "colorTabletmenuHighlight"] },
    ]
    readonly property var componentColors: [
        "colorComponent",
        "colorComponentText",
        "colorComponentContent",
        "colorComponentBorder",
        "colorComponentDown",
        "colorComponentBackground",
        "colorComponentShadow",
    ]
    readonly property var componentSizes: [
        { "name": "componentRadius",      "from": 0, "to": 64 },
        { "name": "componentBorderWidth", "from": 0, "to": 16 },
        { "name": "componentFontSize",    "from": 8, "to": 40 },
        { "name": "componentMarginXS",    "from": 0, "to": 64 },
        { "name": "componentMarginS",     "from": 0, "to": 64 },
        { "name": "componentMargin",      "from": 0, "to": 64 },
        { "name": "componentMarginL",     "from": 0, "to": 64 },
        { "name": "componentMarginXL",    "from": 0, "to": 64 },
        { "name": "componentHeightXS",    "from": 0, "to": 96 },
        { "name": "componentHeightS",     "from": 0, "to": 96 },
        { "name": "componentHeight",      "from": 0, "to": 96 },
        { "name": "componentHeightL",     "from": 0, "to": 96 },
        { "name": "componentHeightXL",    "from": 0, "to": 96 },
    ]
    readonly property var fontSizes: [
        "fontSizeOS",
        "fontSizeHeader",
        "fontSizeTitle",
        "fontSizeContentVeryVerySmall",
        "fontSizeContentVerySmall",
        "fontSizeContentSmall",
        "fontSizeContent",
        "fontSizeContentBig",
        "fontSizeContentVeryBig",
        "fontSizeContentVeryVeryBig",
    ]

    ////////////////////////////////////////////////////////////////////////////

    // Serialize the edited values as a ThemeEngine-style assignment block
    function themeToBlock() {
        function padName(n) { let s = "" + n; while (s.length < 26) s += " "; return s }
        function colorLine(n) { return padName(n) + "= \"" + Theme[n] + "\"" }
        function valueLine(n) { return padName(n) + "= " + Theme[n] }

        let lines = []
        lines.push("// " + Theme.getThemeName(Theme.currentTheme) +
                   (Theme.isDark ? " (Dark)" : " (Light)"))
        lines.push("")
        lines.push(valueLine("isLight"))
        lines.push(valueLine("isDark"))
        lines.push("")

        let groups = editorPanel.themeColors
        for (let g = 0; g < groups.length; g++) {
            lines.push("// " + groups[g].section)
            let names = groups[g].names
            for (let i = 0; i < names.length; i++) lines.push(colorLine(names[i]))
            lines.push("")
        }

        lines.push("// Component theming")
        let cc = editorPanel.componentColors
        for (let c = 0; c < cc.length; c++) lines.push(colorLine(cc[c]))
        lines.push("")
        let cs = editorPanel.componentSizes
        for (let s = 0; s < cs.length; s++) lines.push(valueLine(cs[s].name))

        return lines.join("\n") + "\n"
    }

    FileDialog {
        id: exportDialog

        title: qsTr("Export theme")
        fileMode: FileDialog.SaveFile
        nameFilters: [ qsTr("Text files") + " (*.txt)", qsTr("All files") + " (*)" ]
        defaultSuffix: "txt"

        currentFolder: StandardPaths.writableLocation(StandardPaths.HomeLocation)
        selectedFile: currentFolder + "/theme.txt"

        onAccepted: {
            ThemeExporter.saveText(exportDialog.selectedFile,
                                   editorPanel.themeToBlock())
        }
    }

    ////////////////////////////////////////////////////////////////////////////

    Loader {
        id: loaderEditor
        anchors.fill: parent

        active: false
        asynchronous: false

        sourceComponent: Rectangle {
            anchors.fill: parent

            clip: true
            color: Theme.colorForeground

            Rectangle { // separator
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                width: 1
                color: Theme.colorSeparator
            }

            ////////////////////////////////////////////////////////////////////

            Rectangle {
                id: tabBar

                anchors.top: parent.top
                anchors.left: parent.left
                anchors.leftMargin: 1
                anchors.right: parent.right

                height: Theme.componentHeightXL + Theme.componentMarginS
                color: Theme.colorForeground
                z: 10

                Row {
                    anchors.left: parent.left

                    Repeater {
                        model: [qsTr("Status"), qsTr("Colors"), qsTr("Components"), qsTr("Fonts")]

                        ButtonSimple {
                            height: tabBar.height

                            required property int index
                            required property string modelData

                            text: modelData

                            colorBackground: (editorPanel.currentTab === index) ? Theme.colorPrimary : "transparent"
                            colorText: (editorPanel.currentTab === index) ? "white" : Theme.colorText

                            onClicked: editorPanel.currentTab = index
                        }
                    }
                }

                ButtonSimple { // export button
                    anchors.right: parent.right
                    anchors.rightMargin: tabBar.height
                    width: tabBar.height
                    height: tabBar.height

                    source: "qrc:/IconLibrary/material-icons/duotone/save_alt.svg"
                    colorBackground: "transparent"
                    colorText: Theme.colorSubText

                    onClicked: exportDialog.open()
                }

                ButtonSimple { // close button
                    anchors.right: parent.right
                    width: tabBar.height
                    height: tabBar.height

                    text: "✕"
                    colorBackground: "transparent"
                    colorText: Theme.colorSubText

                    onClicked: editorPanel.opened = false
                }

                Rectangle {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    height: 1
                    color: Theme.colorSeparator
                }
            }

            ////////////////////////////////////////////////////////////////////

            Item {
                id: tabContent
                anchors.top: tabBar.bottom
                anchors.left: parent.left
                anchors.leftMargin: 1 // keep the left separator visible
                anchors.right: parent.right
                anchors.bottom: parent.bottom

                // Status tab //////////////////////////////////////////////////

                Flickable {
                    anchors.fill: parent
                    visible: (editorPanel.currentTab === 0)

                    contentWidth: width
                    contentHeight: statusColumn.height
                    boundsBehavior: Flickable.OvershootBounds
                    ScrollBar.vertical: ScrollBarThemed { }

                    Column {
                        id: statusColumn
                        width: parent.width

                        SectionHeader { text: qsTr("Theme") }

                        StatusRow { label: qsTr("Name"); value: Theme.getThemeName(Theme.currentTheme) + (Theme.isDark ? " (" + qsTr("Dark") + ")" : " (" + qsTr("Light") + ")") }
                        StatusRow { label: qsTr("Platform"); value: Theme.isDesktop ? qsTr("Desktop") : qsTr("Mobile") }

                        SectionHeader { text: qsTr("Metrics") }

                        StatusRow { label: qsTr("Window"); value: Theme.appWidth + " × " + Theme.appHeight }
                        StatusRow { label: qsTr("Screen DPI"); value: "" + Theme.screenDpi }
                        StatusRow { label: qsTr("Pixel ratio"); value: Theme.screenPar.toFixed(2) }
                        StatusRow { label: qsTr("Screen size"); value: Theme.screenSize.toFixed(1) + "″" }
                        StatusRow { label: qsTr("OS font size"); value: Theme.fontSizeOS + " px" }
                        StatusRow { label: qsTr("HiDPI"); value: Theme.isHdpi ? qsTr("yes") : qsTr("no") }
                        StatusRow { label: qsTr("Wide mode"); value: Theme.wideMode ? qsTr("yes") : qsTr("no") }
                        StatusRow { label: qsTr("Single column"); value: Theme.singleColumn ? qsTr("yes") : qsTr("no") }

                        SectionHeader { text: qsTr("Animations") }

                        StatusRow { label: qsTr("Fast"); value: Theme.animationFastSpeed + " ms" }
                        StatusRow { label: qsTr("Medium"); value: Theme.animationMediumSpeed + " ms" }
                        StatusRow { label: qsTr("Slow"); value: Theme.animationSlowSpeed + " ms" }
                    }
                }

                // Colors tab //////////////////////////////////////////////////

                Flickable {
                    anchors.fill: parent
                    visible: (editorPanel.currentTab === 1)

                    contentWidth: width
                    contentHeight: colorsColumn.height
                    boundsBehavior: Flickable.OvershootBounds
                    ScrollBar.vertical: ScrollBarThemed { }

                    Column {
                        id: colorsColumn
                        width: parent.width

                        Repeater {
                            model: editorPanel.themeColors

                            Column {
                                id: sectionCol
                                width: colorsColumn.width

                                SectionHeader { text: sectionCol.modelData.section }

                                required property var modelData
                                Repeater {
                                    model: sectionCol.modelData.names

                                    EditorElementColor {
                                        width: sectionCol.width
                                        propertyName: modelData
                                        required property string modelData
                                    }
                                }
                            }
                        }
                    }
                }

                // Components tab //////////////////////////////////////////////

                Flickable {
                    anchors.fill: parent
                    visible: (editorPanel.currentTab === 2)

                    contentWidth: width
                    contentHeight: componentColumn.height
                    boundsBehavior: Flickable.OvershootBounds
                    ScrollBar.vertical: ScrollBarThemed { }

                    Column {
                        id: componentColumn
                        width: parent.width

                        SectionHeader { text: qsTr("Colors") }

                        Repeater {
                            model: editorPanel.componentColors

                            EditorElementColor {
                                width: componentColumn.width
                                propertyName: modelData
                                required property string modelData
                            }
                        }

                        SectionHeader { text: qsTr("Sizes") }

                        Repeater {
                            model: editorPanel.componentSizes

                            EditorElementSpinBox {
                                width: componentColumn.width
                                propertyName: modelData.name
                                from: modelData.from
                                to: modelData.to
                                required property var modelData
                            }
                        }
                    }
                }

                // Fonts tab ///////////////////////////////////////////////////

                Flickable {
                    anchors.fill: parent
                    visible: (editorPanel.currentTab === 3)

                    contentWidth: width
                    contentHeight: fontColumn.height
                    boundsBehavior: Flickable.OvershootBounds
                    ScrollBar.vertical: ScrollBarThemed { }

                    Column {
                        id: fontColumn
                        width: parent.width

                        SectionHeader { text: qsTr("Font sizes") }

                        Repeater {
                            model: editorPanel.fontSizes

                            EditorElementFont {
                                width: fontColumn.width
                                propertyName: modelData
                                required property string modelData
                            }
                        }
                    }
                }

                ////////////////////////////////////////////////////////////////
            }
        }
    }

    ////////////////////////////////////////////////////////////////////////////

    // Uppercase subsection header
    component SectionHeader: Item {
        width: parent ? parent.width : 0
        height: Theme.componentHeightL

        property alias text: sectionText.text

        Text {
            id: sectionText
            anchors.left: parent.left
            anchors.leftMargin: Theme.componentMargin
            anchors.bottom: parent.bottom
            anchors.bottomMargin: Theme.componentMarginXS

            color: Theme.colorSubText
            font.pixelSize: Theme.fontSizeContentSmall
            font.bold: true
            font.capitalization: Font.AllUppercase
        }
    }

    // Read-only "label / value" row used by the status tab
    component StatusRow: Item {
        id: statusRow

        width: parent ? parent.width : 0
        height: Theme.componentHeightXL + Theme.componentMarginXS

        property string label
        property string value

        Text {
            anchors.left: parent.left
            anchors.leftMargin: Theme.componentMargin
            anchors.right: valueText.left
            anchors.rightMargin: Theme.componentMargin
            anchors.verticalCenter: parent.verticalCenter

            text: statusRow.label
            color: Theme.colorSubText
            font.pixelSize: Theme.fontSizeContent
            elide: Text.ElideRight
            verticalAlignment: Text.AlignVCenter
        }

        Text {
            id: valueText
            anchors.right: parent.right
            anchors.rightMargin: Theme.componentMargin
            anchors.verticalCenter: parent.verticalCenter

            text: statusRow.value
            color: Theme.colorText
            font.pixelSize: Theme.fontSizeContent
            font.bold: true
            verticalAlignment: Text.AlignVCenter
        }
    }

    ////////////////////////////////////////////////////////////////////////////
}
