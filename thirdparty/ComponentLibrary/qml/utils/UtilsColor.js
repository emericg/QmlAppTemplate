// UtilsColor.js
.pragma library

.import ComponentLibrary 1.0 as ComponentLibrary

// Color helpers, working on:
// - QML color types
// - strings ("#rrggbb", "transparent", ...)

/* ************************************************************************** */

/*!
 * Coerce a color argument to a proper QML color, so strings are accepted too.
 */
function _color(c) {
    return (typeof c === "string") ? Qt.color(c) : c
}

function luminance(c) {
    return luminance601(c)
}

/*!
 * Perceived luminance of a color, 0 (black) to 1 (white).
 * Uses the classical Rec.601 weights (0.299 / 0.587 / 0.114).
 */
function luminance601(c) {
    c = _color(c)
    return 0.299 * c.r + 0.587 * c.g + 0.114 * c.b
}

/*!
 * Perceived luminance of a color, 0 (black) to 1 (white).
 * Uses the Rec.709 weights (0.2126 / 0.7152 / 0.0722).
 */
function luminance709(c) {
    c = _color(c)
    return 0.2126 * c.r + 0.7152 * c.g + 0.0722 * c.b
}

/*!
 * True when color c is dark enough that a light color reads better on it.
 * \param threshold: luminance cut-off (default 0.8)
 */
function isDark(c, threshold) {
    return luminance(c) < ((threshold === undefined) ? 0.8 : threshold)
}

/*!
 * True when color c is light enough that a dark color reads better on it.
 * \param threshold: luminance cut-off (default 0.8)
 */
function isLight(c, threshold) {
    return luminance(c) > ((threshold === undefined) ? 0.8 : threshold)
}

/* ************************************************************************** */

/*!
 * Blend color c toward white.
 */
function lighten(c, t) {
    c = _color(c)
    return Qt.rgba(c.r + (1.0 - c.r) * t, c.g + (1.0 - c.g) * t, c.b + (1.0 - c.b) * t, c.a)
}

/*!
 * Blend color c toward black.
 */
function darken(c, t) {
    c = _color(c)
    return Qt.rgba(c.r * (1.0 - t), c.g * (1.0 - t), c.b * (1.0 - t), c.a)
}

/*!
 * Apply alpha to color c.
 */
function opacify(c, a) {
    c = _color(c)
    return Qt.rgba(c.r, c.g, c.b, a)
}

/*!
 * Emphasize color c: lift a dark color toward white, sink a light one toward black.
 * \param lightAmount: blend toward white when c is dark (default 0.22)
 * \param darkAmount: blend toward black when c is light (default 0.15)
 */
function emphasize(c, lightAmount, darkAmount) {
    lightAmount = (lightAmount === undefined) ? 0.22 : lightAmount
    darkAmount = (darkAmount === undefined) ? 0.15 : darkAmount

    return isDark(c) ? lighten(c, lightAmount) : darken(c, darkAmount)
}

/*!
 * Choose a color for texts / icons that reads well on the given background.
 * \param threshold: luminance threshold above which dark color is chosen (default 0.8)
 * \param darkColor: color for light backgrounds (default near-black)
 * \param lightColor: color for dark backgrounds (default white)
 */
function contrastColor(c, threshold, darkColor, lightColor) {
    threshold = (threshold === undefined) ? 0.8 : threshold
    darkColor = (darkColor === undefined) ? Qt.rgba(0.12, 0.12, 0.12, 1.0) : darkColor
    lightColor = (lightColor === undefined) ? Qt.rgba(1.0, 1.0, 1.0, 1.0) : lightColor

    return (luminance(c) > threshold) ? darkColor : lightColor
}

/*!
 * Same as contrastColor() function, but using ThemeEngine "contrast" colors.
 */
function contrastColorThemed(c, threshold) {
    return contrastColor(c, threshold, ComponentLibrary.Theme.colorLowContrast,
                                       ComponentLibrary.Theme.colorHighContrast)
}

/* ************************************************************************** */
