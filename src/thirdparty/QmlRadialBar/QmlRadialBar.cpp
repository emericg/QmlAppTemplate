/*
 * Copyright (c) 2017 Arun PK <mailztopk@gmail.com>
 * Copyright (c) 2021 Emeric Grange <emeric.grange@gmail.com>
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

/* ************************************************************************** */

#include <QPainter>

#include "QmlRadialBar.h"

/* ************************************************************************** */

QmlRadialBar::QmlRadialBar(QQuickItem *parent)
    : QQuickPaintedItem(parent),
      m_size(200),
      m_dialColor(QColor(80,80,80)),
      m_progressColor(QColor(135,26,5)),
      m_textColor(QColor(0, 0, 0))
{
    setWidth(200);
    setHeight(200);
    setSmooth(true);
    setAntialiasing(true);
}

/* ************************************************************************** */

void QmlRadialBar::paint(QPainter *painter)
{
    double startAngle;
    double spanAngle;
    qreal size = qMin(this->width(), this->height());
    setWidth(size);
    setHeight(size);
    QRectF rect = this->boundingRect();
    painter->setRenderHint(QPainter::Antialiasing);
    QPen pen = painter->pen();
    pen.setCapStyle(m_penStyle);

    startAngle = -90 - m_startAngle;
    if (FullDial != m_dialType)
    {
        spanAngle = 0 - m_spanAngle;
    }
    else
    {
        spanAngle = -360;
    }

    // Draw outer dial
    painter->save();
    pen.setWidth(m_dialWidth);
    pen.setColor(m_dialColor);
    painter->setPen(pen);
    qreal offset = m_dialWidth / 2;
    if (m_dialType == MinToMax)
    {
        painter->drawArc(rect.adjusted(offset, offset, -offset, -offset), startAngle * 16, spanAngle * 16);
    }
    else if (m_dialType == FullDial)
    {
        painter->drawArc(rect.adjusted(offset, offset, -offset, -offset), -90 * 16, -360 * 16);
    }
    else
    {
        // do not draw dial
    }
    painter->restore();

    // Draw background
    painter->save();
    painter->setBrush(m_backgroundColor);
    painter->setPen(m_backgroundColor);
    qreal inner = offset * 2;
    painter->drawEllipse(rect.adjusted(inner, inner, -inner, -inner));
    painter->restore();

    // Draw progress text with suffix
    painter->save();
    painter->setFont(m_textFont);
    pen.setColor(m_textColor);
    painter->setPen(pen);
    if (m_textEnabled)
    {
        painter->drawText(rect.adjusted(offset, offset, -offset, -offset), Qt::AlignCenter,QString::number(m_value) + m_textSuffix);
    }
    else
    {
        painter->drawText(rect.adjusted(offset, offset, -offset, -offset), Qt::AlignCenter, m_textSuffix);
    }
    painter->restore();

    // Draw progress bar
    painter->save();
    pen.setWidth(m_dialWidth);
    pen.setColor(m_progressColor);
    qreal valueAngle = ((m_value - m_minValue)/(m_maxValue - m_minValue)) * spanAngle; // Map value to angle range
    painter->setPen(pen);
    painter->drawArc(rect.adjusted(offset, offset, -offset, -offset), startAngle * 16, valueAngle * 16);
    painter->restore();
}

/* ************************************************************************** */

void QmlRadialBar::setSize(qreal size)
{
    if (m_size == size) return;

    m_size = size;
    emit sizeChanged();
}

void QmlRadialBar::setStartAngle(qreal angle)
{
    if (m_startAngle == angle) return;

    m_startAngle = angle;
    emit startAngleChanged();
}

void QmlRadialBar::setSpanAngle(qreal angle)
{
    if (m_spanAngle == angle) return;

    m_spanAngle = angle;
    emit spanAngleChanged();
}

void QmlRadialBar::setMinValue(qreal value)
{
    if (m_minValue == value) return;

    m_minValue = value;
    emit minValueChanged();
}

void QmlRadialBar::setMaxValue(qreal value)
{
    if (m_maxValue == value) return;

    m_maxValue = value;
    emit maxValueChanged();
}

void QmlRadialBar::setValue(qreal value)
{
    if (m_value == value) return;

    m_value = value;
    update(); // Update the radialbar
    emit valueChanged();
}

void QmlRadialBar::setDialWidth(qreal width)
{
    if (m_dialWidth == width) return;

    m_dialWidth = width;
    emit dialWidthChanged();
}

void QmlRadialBar::setBackgroundColor(QColor color)
{
    if (m_backgroundColor == color) return;

    m_backgroundColor = color;
    update();
    emit backgroundColorChanged();
}

void QmlRadialBar::setForegroundColor(QColor color)
{
    if (m_dialColor == color) return;

    m_dialColor = color;
    update();
    emit foregroundColorChanged();
}

void QmlRadialBar::setProgressColor(QColor color)
{
    if (m_progressColor == color) return;

    m_progressColor = color;
    update();
    emit progressColorChanged();
}

void QmlRadialBar::setTextColor(QColor color)
{
    if (m_textColor == color) return;

    m_textColor = color;
    emit textColorChanged();
}

void QmlRadialBar::setSuffixText(QString text)
{
    if (m_textSuffix == text) return;

    m_textSuffix = text;
    emit suffixTextChanged();
}

void QmlRadialBar::setShowText(bool show)
{
    if (m_textEnabled == show) return;
    m_textEnabled = show;
}

void QmlRadialBar::setPenStyle(Qt::PenCapStyle style)
{
    if (m_penStyle == style) return;

    m_penStyle = style;
    emit penStyleChanged();
}

void QmlRadialBar::setDialType(QmlRadialBar::DialType type)
{
    if (m_dialType == type) return;

    m_dialType = type;
    emit dialTypeChanged();
}

void QmlRadialBar::setTextFont(QFont font)
{
    if (m_textFont == font) return;

    m_textFont = font;
    emit textFontChanged();
}

/* ************************************************************************** */
