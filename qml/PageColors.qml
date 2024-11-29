import QtQuick
import QtQuick.Controls

import ComponentLibrary

Flickable {
    contentWidth: -1
    contentHeight: contentColumn.height

    boundsBehavior: isDesktop ? Flickable.OvershootBounds : Flickable.DragAndOvershootBounds
    ScrollBar.vertical: ScrollBar { visible: false }

    Column {
        id: contentColumn

        anchors.left: parent.left
        anchors.right: parent.right

        topPadding: Theme.componentMarginXL
        bottomPadding: Theme.componentMarginXL
        spacing: Theme.componentMarginXL

        property int www: 48
        property int hhh: 48

        ListTitle { ////////////////////////////////////////////////////////////
            anchors.leftMargin: singleColumn ? 0 : Theme.componentMargin
            anchors.rightMargin: singleColumn ? 0 : Theme.componentMargin

            text: qsTr("App palette colors")
            source: ""
        }

        Grid {
            anchors.left: parent.left
            anchors.leftMargin: Theme.componentMarginXL
            anchors.right: parent.right
            anchors.rightMargin: Theme.componentMarginXL

            columns: 6
            spacing: -2

            ColoredSquare { color: Theme.colorRed }
            ColoredSquare { color: Theme.colorGreen }
            ColoredSquare { color: Theme.colorBlue }

            ColoredSquare { color: Theme.colorYellow }
            ColoredSquare { color: Theme.colorOrange }
            ColoredSquare { color: Theme.colorGrey }
        }

        //

        ListTitle { ////////////////////////////////////////////////////////////
            anchors.leftMargin: singleColumn ? 0 : Theme.componentMargin
            anchors.rightMargin: singleColumn ? 0 : Theme.componentMargin

            text: qsTr("Fixed colors (material)")
            source: ""
        }

        Grid {
            anchors.left: parent.left
            anchors.leftMargin: Theme.componentMarginXL
            anchors.right: parent.right
            anchors.rightMargin: Theme.componentMarginXL

            columns: 6
            spacing: -2

            ColoredSquare { color: Theme.colorMaterialRed }
            ColoredSquare { color: Theme.colorMaterialPink }
            ColoredSquare { color: Theme.colorMaterialPurple }
            ColoredSquare { color: Theme.colorMaterialDeepPurple }

            ColoredSquare { color: Theme.colorMaterialIndigo }
            ColoredSquare { color: Theme.colorMaterialBlue }
            ColoredSquare { color: Theme.colorMaterialLightBlue }
            ColoredSquare { color: Theme.colorMaterialCyan }

            ColoredSquare { color: Theme.colorMaterialTeal }
            ColoredSquare { color: Theme.colorMaterialGreen }
            ColoredSquare { color: Theme.colorMaterialLightGreen }
            ColoredSquare { color: Theme.colorMaterialLime }

            ColoredSquare { color: Theme.colorMaterialYellow }
            ColoredSquare { color: Theme.colorMaterialAmber }
            ColoredSquare { color: Theme.colorMaterialOrange }
            ColoredSquare { color: Theme.colorMaterialDeepOrange }

            ColoredSquare { color: Theme.colorMaterialBrown }
            ColoredSquare { color: Theme.colorMaterialGrey }
        }

        ListTitle { ////////////////////////////////////////////////////////////
            anchors.leftMargin: singleColumn ? 0 : Theme.componentMargin
            anchors.rightMargin: singleColumn ? 0 : Theme.componentMargin

            text: qsTr("Fixed colors (css / svg)")
            source: ""
        }

        Grid {
            anchors.left: parent.left
            anchors.leftMargin: Theme.componentMarginXL
            anchors.right: parent.right
            anchors.rightMargin: Theme.componentMarginXL

            columns: 6
            spacing: -2

            Repeater {
                model: [
                    "aliceblue", "antiquewhite", "aqua", "aquamarine", "azure",
                    "beige", "bisque", "black", "blanchedalmond", "blue",
                    "blueviolet", "brown", "burlywood", "cadetblue", "chartreuse",
                    "chocolate", "coral", "cornflowerblue", "cornsilk", "crimson",
                    "cyan", "darkblue", "darkcyan", "darkgoldenrod", "darkgray",
                    "darkgreen", "darkgrey", "darkkhaki", "darkmagenta", "darkolivegreen",
                    "darkorange", "darkorchid", "darkred", "darksalmon", "darkseagreen",
                    "darkslateblue", "darkslategray", "darkslategrey", "darkturquoise", "darkviolet",
                    "deeppink", "deepskyblue", "dimgray", "dimgrey", "dodgerblue",
                    "firebrick", "floralwhite", "forestgreen", "fuchsia", "gainsboro",
                    "ghostwhite", "gold", "goldenrod", "gray", "grey",
                    "green", "greenyellow", "honeydew", "hotpink", "indianred",
                    "indigo", "ivory", "khaki", "lavender", "lavenderblush",
                    "lawngreen", "lemonchiffon", "lightblue", "lightcoral", "lightcyan",
                    "lightgoldenrodyellow", "lightgray", "lightgreen", "lightgrey", "lightpink",
                    "lightsalmon", "lightseagreen", "lightskyblue", "lightslategray", "lightslategrey",
                    "lightsteelblue", "lightyellow", "lime", "limegreen", "linen",
                    "magenta", "maroon", "mediumaquamarine", "mediumblue", "mediumorchid",
                    "mediumpurple", "mediumseagreen", "mediumslateblue", "mediumspringgreen", "mediumturquoise",
                    "mediumvioletred", "midnightblue", "mintcream", "mistyrose", "moccasin",
                    "navajowhite", "navy", "oldlace", "olive", "olivedrab",
                    "orange", "orangered", "orchid", "palegoldenrod", "palegreen",
                    "paleturquoise", "palevioletred", "papayawhip", "peachpuff", "peru",
                    "pink", "plum", "powderblue", "purple", "red",
                    "rosybrown", "royalblue", "saddlebrown", "salmon", "sandybrown",
                    "seagreen", "seashell", "sienna", "silver", "skyblue",
                    "slateblue", "slategray", "slategrey", "snow", "springgreen",
                    "steelblue", "tan", "teal", "thistle", "tomato",
                    "turquoise", "violet", "wheat", "white", "whitesmoke",
                    "yellow", "yellowgreen"]
                ColoredSquare { color: modelData }
            }
        }
    }

    component ColoredSquare: Rectangle {
        width: contentColumn.www
        height: contentColumn.hhh
        border.width: 4
        border.color: "white"
    }
}
