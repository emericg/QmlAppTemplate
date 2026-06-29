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

#include "utils_maths.h"

#include <cmath>
#include <limits>
#include <random>

/* ************************************************************************** */

int mapNumber(const int value, const int srcMin, const int srcMax,
                               const int dstMin, const int dstMax, bool checks)
{
    if (srcMax == srcMin) return dstMin;

    int n = value;
    if (checks)
    {
        if (n < srcMin) n = srcMin;
        if (n > srcMax) n = srcMax;
    }

    return (dstMin + ((n - srcMin) * (dstMax - dstMin)) / (srcMax - srcMin));
}

/* ************************************************************************** */

double roundTo(const double value, const int decimals)
{
    const double p = std::pow(10.0, decimals);
    return std::round(value * p) / p;
}

double normalize(const int value, const int min, const int max)
{
    if (value <= min) return 0.0;
    if (value >= max) return 1.0;
    return static_cast<double>(value - min) / static_cast<double>(max - min);
}

int alignTo(const int value, const int r)
{
    if (r <= 0) return value;
    return static_cast<int>(std::ceil(static_cast<double>(value) / r) * r);
}

int alignToEven(const int value)
{
    return static_cast<int>(std::ceil(static_cast<double>(value) / 2) * 2);
}

int alignToPow2(const int value, const int r)
{
    return (value + (r - 1)) & ~(r - 1);
}

/* ************************************************************************** */

int randomInt(int min, int max)
{
    static thread_local std::mt19937 generator{std::random_device{}()};
    std::uniform_int_distribution<int> distribution(min, max);
    return distribution(generator);
}

/* ************************************************************************** */

#define d2r (M_PI / 180.0)

double haversine_km(double lat1, double long1, double lat2, double long2)
{
    double dlong = (long2 - long1) * d2r;
    double dlat = (lat2 - lat1) * d2r;
    double a = pow(sin(dlat/2.0), 2) + cos(lat1*d2r) * cos(lat2*d2r) * pow(sin(dlong/2.0), 2);
    double c = 2 * atan2(sqrt(a), sqrt(1-a));
    double d = 6367 * c;

    return d;
}

double haversine_mi(double lat1, double long1, double lat2, double long2)
{
    double dlong = (long2 - long1) * d2r;
    double dlat = (lat2 - lat1) * d2r;
    double a = pow(sin(dlat/2.0), 2) + cos(lat1*d2r) * cos(lat2*d2r) * pow(sin(dlong/2.0), 2);
    double c = 2 * atan2(sqrt(a), sqrt(1-a));
    double d = 3956 * c;

    return d;
}

/* ************************************************************************** */
/* ************************************************************************** */

//implements relative method - do not use for comparing with zero
//use this most of the time, tolerance needs to be meaningful in your context
template<typename TReal>
static bool isApproximatelyEqual(TReal a, TReal b, TReal tolerance = std::numeric_limits<TReal>::epsilon())
{
    TReal diff = std::fabs(a - b);
    if (diff <= tolerance)
        return true;

    if (diff < std::fmax(std::fabs(a), std::fabs(b)) * tolerance)
        return true;

    return false;
}

//supply tolerance that is meaningful in your context
//for example, default tolerance may not work if you are comparing double with float
template<typename TReal>
static bool isApproximatelyZero(TReal a, TReal tolerance = std::numeric_limits<TReal>::epsilon())
{
    return (std::fabs(a) <= tolerance);
}

//use this when you want to be on safe side
//for example, don't start rover unless signal is above 1
template<typename TReal>
static bool isDefinitelyLessThan(TReal a, TReal b, TReal tolerance = std::numeric_limits<TReal>::epsilon())
{
    TReal diff = a - b;
    if (diff < tolerance)
        return true;

    if (diff < std::fmax(std::fabs(a), std::fabs(b)) * tolerance)
        return true;

    return false;
}

template<typename TReal>
static bool isDefinitelyGreaterThan(TReal a, TReal b, TReal tolerance = std::numeric_limits<TReal>::epsilon())
{
    TReal diff = a - b;
    if (diff > tolerance)
        return true;

    if (diff > std::fmax(std::fabs(a), std::fabs(b)) * tolerance)
        return true;

    return false;
}

//implements ULP method
//use this when you are only concerned about floating point precision issue
//for example, if you want to see if a is 1.0 by checking if its within
//10 closest representable floating point numbers around 1.0.
template<typename TReal>
static bool isWithinPrecisionInterval(TReal a, TReal b, unsigned int interval_size = 1)
{
    TReal min_a = a - (a - std::nextafter(a, std::numeric_limits<TReal>::lowest())) * interval_size;
    TReal max_a = a + (std::nextafter(a, std::numeric_limits<TReal>::max()) - a) * interval_size;

    return min_a <= b && max_a >= b;
}

/* ************************************************************************** */
