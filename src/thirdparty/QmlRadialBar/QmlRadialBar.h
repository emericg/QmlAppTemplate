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

#ifndef QMLRADIALBAR_H
#define QMLRADIALBAR_H
/* ************************************************************************** */

#include <QQuickPaintedItem>

/* ************************************************************************** */

class QmlRadialBar : public QQuickPaintedItem
{
    Q_OBJECT

    Q_PROPERTY(qreal size READ getSize WRITE setSize NOTIFY sizeChanged)
    Q_PROPERTY(qreal startAngle READ getStartAngle WRITE setStartAngle NOTIFY startAngleChanged)
    Q_PROPERTY(qreal spanAngle READ getSpanAngle WRITE setSpanAngle NOTIFY spanAngleChanged)
    Q_PROPERTY(qreal minValue READ getMinValue WRITE setMinValue NOTIFY minValueChanged)
    Q_PROPERTY(qreal maxValue READ getMaxValue WRITE setMaxValue NOTIFY maxValueChanged)
    Q_PROPERTY(qreal value READ getValue WRITE setValue NOTIFY valueChanged)
    Q_PROPERTY(int dialWidth READ getDialWidth WRITE setDialWidth NOTIFY dialWidthChanged)
    Q_PROPERTY(QColor backgroundColor READ getBackgroundColor WRITE setBackgroundColor NOTIFY backgroundColorChanged)
    Q_PROPERTY(QColor foregroundColor READ getForegroundColor WRITE setForegroundColor NOTIFY foregroundColorChanged)
    Q_PROPERTY(QColor progressColor READ getProgressColor WRITE setProgressColor NOTIFY progressColorChanged)
    Q_PROPERTY(Qt::PenCapStyle penStyle READ getPenStyle WRITE setPenStyle NOTIFY penStyleChanged)
    Q_PROPERTY(DialType dialType READ getDialType WRITE setDialType NOTIFY dialTypeChanged)

    Q_PROPERTY(bool showText READ isShowText WRITE setShowText)
    Q_PROPERTY(QFont textFont READ getTextFont WRITE setTextFont NOTIFY textFontChanged)
    Q_PROPERTY(QColor textColor READ getTextColor WRITE setTextColor NOTIFY textColorChanged)
    Q_PROPERTY(QString suffixText READ getSuffixText WRITE setSuffixText NOTIFY suffixTextChanged)

public:
    QmlRadialBar(QQuickItem *parent = nullptr);

    static void registerQML()
    {
        qmlRegisterType<QmlRadialBar>("QmlRadialBar", 1, 0, "QmlRadialBar");
    }

    void paint(QPainter *painter);

    enum DialType {
        FullDial,
        MinToMax,
        NoDial
    };
    Q_ENUM(DialType)

    qreal getSize() {return m_size;}
    qreal getStartAngle() {return m_startAngle;}
    qreal getSpanAngle() {return m_spanAngle;}
    qreal getMinValue() {return m_minValue;}
    qreal getMaxValue() {return m_maxValue;}
    qreal getValue() {return m_value;}
    int getDialWidth() {return m_dialWidth;}
    QColor getBackgroundColor() {return m_backgroundColor;}
    QColor getForegroundColor() {return m_dialColor;}
    QColor getProgressColor() {return m_progressColor;}
    QColor getTextColor() {return m_textColor;}
    QString getSuffixText() {return m_textSuffix;}
    bool isShowText() {return m_textEnabled;}
    Qt::PenCapStyle getPenStyle() {return m_penStyle;}
    DialType getDialType() {return m_dialType;}
    QFont getTextFont() {return m_textFont;}

    void setSize(qreal size);
    void setStartAngle(qreal angle);
    void setSpanAngle(qreal angle);
    void setMinValue(qreal value);
    void setMaxValue(qreal value);
    void setValue(qreal value);
    void setDialWidth(qreal width);
    void setBackgroundColor(QColor color);
    void setForegroundColor(QColor color);
    void setProgressColor(QColor color);
    void setTextColor(QColor color);
    void setSuffixText(QString text);
    void setShowText(bool show);
    void setPenStyle(Qt::PenCapStyle style);
    void setDialType(DialType type);
    void setTextFont(QFont font);

signals:
    void sizeChanged();
    void startAngleChanged();
    void spanAngleChanged();
    void minValueChanged();
    void maxValueChanged();
    void valueChanged();
    void dialWidthChanged();
    void backgroundColorChanged();
    void foregroundColorChanged();
    void progressColorChanged();
    void textColorChanged();
    void suffixTextChanged();
    void penStyleChanged();
    void dialTypeChanged();
    void textFontChanged();

private:
    qreal m_size;
    qreal m_startAngle = 40;
    qreal m_spanAngle = 280;

    qreal m_minValue = 0;
    qreal m_maxValue = 100;
    qreal m_value = 50;

    int m_dialWidth = 15;
    QColor m_dialColor;
    DialType m_dialType = DialType::MinToMax;

    Qt::PenCapStyle m_penStyle = Qt::FlatCap;
    QColor m_backgroundColor = Qt::transparent;
    QColor m_progressColor;

    bool m_textEnabled = false;
    QColor m_textColor;
    QString m_textSuffix;
    QFont m_textFont;
};

/* ************************************************************************** */
#endif // QMLRADIALBAR_H
