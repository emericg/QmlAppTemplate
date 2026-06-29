/*!
 * Copyright (c) 2018 Emeric Grange
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

#ifndef UTILS_MATHS_H
#define UTILS_MATHS_H
/* ************************************************************************** */

//! Map a number from range [srcMin, srcMax] to [dstMin, dstMax]
int mapNumber(const int value, const int srcMin, const int srcMax,
              const int dstMin, const int dstMax, bool checks = true);

//! Round 'value' to a given number of decimals
//! example: roundTo(154.54645698, 3) => 154.546
double roundTo(const double value, const int decimals = 0);

//! Normalize 'value' into [0, 1] relative to [min, max]
//! example: normalize(5, 0, 10) => 0.5
double normalize(const int value, const int min, const int max);

//! Align 'value' up to the next multiple of 'r' (any positive r)
//! example: alignTo(13, 2) => 14 / alignTo(13, 8) => 16
int alignTo(const int value, const int r);

//! Align 'value' up to the next even number (multiple of two)
int alignToEven(const int value);

//! Align 'value' up to the next multiple of 'r' (which MUST be a power of two)
//! example: alignToPow2(13, 8) => 16 / alignToPow2(16, 8) => 16
int alignToPow2(const int value, const int r);

//! Random integer in [min, max]
//! example: randomInt(1, 6) => 4
int randomInt(int min, int max);

/* ************************************************************************** */

//! Calculate haversine distance for linear distance (km)
double haversine_km(double lat1, double long1, double lat2, double long2);

//! Calculate haversine distance for linear distance (miles)
double haversine_mi(double lat1, double long1, double lat2, double long2);

/* ************************************************************************** */
#endif // UTILS_MATHS_H
