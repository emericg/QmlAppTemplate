# QmlRadialBar

QmlRadialBar allows QML applications to draw nice radial bars. Works with Qt5 and Qt6.

QmlRadialBar module is based on RadialBar demo by Arun PK.

> https://github.com/arunpkqt/RadialBarDemo  

## Quick start

### Build

Copy the QmlRadialBar directory into your project, then include the library files with
either the `QmlRadialBar.pro` QMake project file or the `CMakeLists.txt` CMake project file.

```qmake
include(src/thirdparty/QmlRadialBar/QmlRadialBar.pri)
```

```cmake
add_subdirectory(src/thirdparty/QmlRadialBar)
target_link_libraries(${PROJECT_NAME} QmlRadialBar::QmlRadialBar)
```

### Usage

First, you need to register the QmlRadialBar QML module in your C++ main.cpp file.  
You can also use QmlRadialBar directly in the code if you want to.  

```cpp
#include <QmlRadialBar>

int main() {
    QGuiApplication app();

    QmlRadialBar::registerQML();

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
```

Example usage in QML:

```qml
import QmlRadialBar 1.0

ApplicationWindow {
    QmlRadialBar {
        width: 256
        height: 256
    
        startAngle: 20
        spanAngle: 320
        dialWidth: 16
        penStyle: Qt.RoundCap
    
        minValue: 0
        maxValue: 100
        value: 66
    
        progressColor: "blue"
        foregroundColor: "grey"
    }
}
```

## License

This project is licensed under the MIT license, see LICENSE file for details.
