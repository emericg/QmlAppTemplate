# MobileUI

MobileUI allows QML applications to interact with Mobile specific features, like Android and iOS `status bar` and Android `navigation bar`.

You can see it in action in the [MobileUI demo](https://github.com/emericg/MobileUI_demo).

> Supports Qt6 and Qt5. QMake and CMake.

> Supports iOS 11 and up (tested with iOS 16 devices).

> Supports Android API 21 and up (tested with API 31 devices).

## Features

- Get Android OS theme
- Set Android `status bar` and `navigation bar` color and theme
- Set iOS `status bar` theme (iOS has no notion of status bar color, and has no navigation bar) 
- Get device `safe areas` (WIP)
- Lock screensaver
- Set screen orientation
- Trigger haptic feedback (vibration)

## Quick start

### Build

To get started, simply checkout the MobileUI repository as a submodule, or copy the
MobileUI directory into your project, then include the library files with either
the `MobileUI.pro` QMake project file or the `CMakeLists.txt` CMake project file.

```qmake
include(MobileUI/MobileUI.pri)
```

```cmake
add_subdirectory(MobileUI/)
target_link_libraries(${PROJECT_NAME} MobileUI::MobileUI)
```

### Use

First, you need to register the MobileUI QML module in your C++ main.cpp file.  
You can also use MobileUI directly in the C++ code if you want to.  

```cpp
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <MobileUI>

int main() {
    QGuiApplication app();

    MobileUI::registerQML(); // that is required

    MobileUI::setStatusbarColor("white"); // use it directly if you want

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
```

Example usage in QML:

```qml
import QtQuick
import MobileUI

ApplicationWindow {
    MobileUI {
        statusbarColor: "white"
        statusbarTheme: MobileUI.Light
        navbarColor: "white"
        navbarTheme: MobileUI.Light
    }
}
```


## Licensing

This project is licensed under the [MIT license](LICENSE).

This project is based on [qtstatusbar](https://github.com/jpnurmi/qtstatusbar) by jpnurmi.
