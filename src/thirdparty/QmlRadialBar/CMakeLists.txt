cmake_minimum_required(VERSION 3.20)

project(QmlRadialBar LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

################################################################################

if(NOT QT_DEFAULT_MAJOR_VERSION)
    set(QT_DEFAULT_MAJOR_VERSION 6 CACHE STRING "Qt version to use (5 or 6), defaults to 6")
endif()

# Generic dependencies
set(CORE_COMPONENTS Core Quick)
find_package(Qt${QT_DEFAULT_MAJOR_VERSION} REQUIRED COMPONENTS ${CORE_COMPONENTS})

set(CORE_LIBRARIES Qt::Core Qt::Quick)

# Generic sources
set(CORE_SOURCES
    QmlRadialBar.h
    QmlRadialBar.cpp)

# OS specific sources & dependencies
set(PLATFORM_SOURCES "")
set(PLATFORM_LIBRARIES "")

################################################################################

add_library(QmlRadialBar OBJECT ${CORE_SOURCES} ${PLATFORM_SOURCES})
add_library(QmlRadialBar::QmlRadialBar ALIAS QmlRadialBar)

target_link_libraries(QmlRadialBar PRIVATE ${CORE_LIBRARIES} ${PLATFORM_LIBRARIES})
target_include_directories(QmlRadialBar PUBLIC ${CMAKE_CURRENT_LIST_DIR})
