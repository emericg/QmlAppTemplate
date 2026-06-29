// UtilsNumber.js
.pragma library

/* ************************************************************************** */

/*!
 * Pad a number
 * \param n: number to pad
 * \param width: width after padding (default 2)
 * \param z: character to insert (default '0')
 *
 * example: padNumber(2, 3, 'x') => xx2
 */
function padNumber(n, width = 2, z = '0') {
    return String(n).padStart(width, z);
}

/*!
 * Trim a number
 * \param n: number to trim
 * \param p: defines number of digit after coma
 *
 * example: trimNumber(154.54645698, 100000) => 154.54645
 */
function trimNumber(n, p) {
    p = p || 100000;

    return (Math.round(n * p)) / p;
}

/*!
 * Map a number from one range to another
 * \param n: number to map
 * \param srcMin: start of the range n is from
 * \param srcMax: end of the range n is from
 * \param dstMin: start of the range to map n to
 * \param dstMax: end of the range to map n to
 *
 * example: mapNumber(5, 0, 10, 100, 200) => 150
 */
function mapNumber(n, srcMin, srcMax, dstMin, dstMax) {
    if (srcMax === srcMin) return dstMin
    if (n < srcMin) n = srcMin
    if (n > srcMax) n = srcMax
    return (dstMin + ((n - srcMin) * (dstMax - dstMin)) / (srcMax - srcMin))
}

function mapNumber_nocheck(n, srcMin, srcMax, dstMin, dstMax) {
    if (srcMax === srcMin) return dstMin
    return (dstMin + ((n - srcMin) * (dstMax - dstMin)) / (srcMax - srcMin))
}

/*!
 * Normalize n between min and max
 */
function normalize(n, min, max) {
    if (n <= min) return 0
    if (n >= max) return 1
    return Math.min(((n - min) / (max - min)), 1)
}

/*!
 * Align n up to the next multiple of r
 * \param n: value to align
 * \param r: alignment step (any positive number)
 *
 * example: alignTo(13, 2) => 14 / alignTo(13, 8) => 16 / alignTo(16, 8) => 16
 */
function alignTo(n, r) {
    if (r <= 0) return n;
    return Math.ceil(n / r) * r;
}

/*!
 * Align n up to the next multiple of r, faster than alignTo(), BUT:
 * - 'r' MUST be a power of two
 * - 'n' will be truncated to 32 bits (because of bitwise ops)
 *
 * example: alignToPow2(13, 8) => 16 / alignToPow2(16, 8) => 16
 */
function alignToPow2(n, r) {
    return (n + (r - 1)) & ~(r - 1);
}

/*!
 * Round n to a multiple of two
 */
function round2(n) {
    return Math.ceil(n / 2) * 2;
}

/*!
 * Euclidean modulo
 */
function mod(n, modulo) {
    return ((n % modulo) + modulo) % modulo;
}

/* ************************************************************************** */

/*!
 * Return true if n is an int
 */
function isInt(n) {
    return Number(n) === n && n % 1 === 0;
}

/*!
 * Return true if n is a float
 */
function isFloat(n) {
    return Number(n) === n && n % 1 !== 0;
}

/*!
 * Return true if n is an even number
 */
function isEven(n) {
    return n % 2 === 0;
}

/*!
 * Return true if n is an odd number
 */
function isOdd(n) {
    return n % 2 !== 0;
}

/* ************************************************************************** */

function radToDeg(radian) {
    return radian * (180/Math.PI);
}

function degToRad(degree) {
    return degree * (Math.PI/180);
}

/* ************************************************************************** */

/*!
 * Fahrenheit to Celsius conversion
 */
function tempFahrenheitToCelsius(temp_f) {
    return (temp_f - 32) / 1.8;
}

/*!
 * Celsius to Fahrenheit conversion
 */
function tempCelsiusToFahrenheit(temp_c) {
    return (temp_c * 1.8 + 32);
}

/*!
 * Celsius to Fahrenheit conversion, if needed
 */
function tempCelsiusOrFahrenheit(temp_c, unit) {
    if (unit === 0) return temp_c
    return (temp_c * 1.8 + 32);
}
/*!
 * Fahrenheit to Celsius conversion, if needed
 */
function tempFahrenheitOrCelsius(temp_f, unit) {
    if (unit !== 0) return temp_f
    return (temp_f - 32) / 1.8;
}

/*!
 * Kilogramme to Pound conversion
 */
function weightKiloToPound(weight_kg) {
    return (weight_kg * 2.20462262185);
}

/*!
 * Pound to Kilogramme conversion
 */
function weightPoundToKilog(weight_lb) {
    return (weight_lb / 2.20462262185);
}

/* ************************************************************************** */
