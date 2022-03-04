/*!
 * COPYRIGHT (C) 2022 Emeric Grange - All Rights Reserved
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * \author    Emeric Grange <emeric.grange@gmail.com>
 * \date      2021
 */

#ifndef UTILS_SYSINFO_H
#define UTILS_SYSINFO_H
/* ************************************************************************** */

#include <QObject>
#include <QVariantMap>
#include <QQuickWindow>

/* ************************************************************************** */

/*!
 * \brief The UtilsSysinfo class
 */
class UtilsSysinfo: public QObject
{
    Q_OBJECT

    Q_PROPERTY(int coreCount_physical READ getCoreCount_physical CONSTANT)
    Q_PROPERTY(int coreCount_logical READ getCoreCount_logical CONSTANT)
    Q_PROPERTY(quint64 ramTotal READ getRamTotal CONSTANT)

    int m_coreCount_physical = 0;
    int m_coreCount_logical = 0;
    uint64_t m_ramTotal = 0;

    // Singleton
    static UtilsSysinfo *instance;
    UtilsSysinfo();
    ~UtilsSysinfo();

    void getCoreInfos();
    void getRamInfos();

public:
    static UtilsSysinfo *getInstance();

    void printInfos();

    Q_INVOKABLE int getCoreCount_physical() const { return m_coreCount_physical; };

    Q_INVOKABLE int getCoreCount_logical() const { return m_coreCount_logical; };

    Q_INVOKABLE uint64_t getRamTotal() const  { return m_ramTotal; };
};

/* ************************************************************************** */
#endif // UTILS_SYSINFO_H
