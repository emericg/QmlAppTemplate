# QmlAppTemplate

[![GitHub action](https://img.shields.io/github/actions/workflow/status/emericg/QmlAppTemplate/builds_desktop.yml?style=flat-square)](https://github.com/emericg/QmlAppTemplate/actions/workflows/builds_desktop.yml)
[![GitHub action](https://img.shields.io/github/actions/workflow/status/emericg/QmlAppTemplate/builds_mobile.yml?style=flat-square)](https://github.com/emericg/QmlAppTemplate/actions/workflows/builds_mobile.yml)
[![GitHub issues](https://img.shields.io/github/issues/emericg/QmlAppTemplate.svg?style=flat-square)](https://github.com/emericg/QmlAppTemplate/issues)
[![License: GPL v3](https://img.shields.io/badge/license-GPL%20v3-blue.svg?style=flat-square)](http://www.gnu.org/licenses/gpl-3.0)

A Qt6 / QML application template, with a full set of visual controls, helper modules, as well as build and deploy scripts and CI setups.

## About

#### Dependencies

You will need a C++17 compiler and Qt 6.5+. Qt 5 Compatibility Module is required.  
For macOS and iOS builds, you'll need Xcode (13+) installed.  
For Android builds, you'll need the appropriates JDK (17) SDK (24+) and NDK (25+). You can customize Android build environment using the `assets/android/gradle.properties` file.  

#### Building QmlAppTemplate

```bash
$ git clone https://github.com/emericg/QmlAppTemplate.git --recursive
$ cd QmlAppTemplate/build/
$ qmake .. # configure with QMake
$ cmake .. # OR configure with CMake
$ make
```

#### C++ modules

> [AppUtils](src/thirdparty/AppUtils/README.md) Various general purpose helpers

> [MobileUI](https://github.com/emericg/MobileUI) Interact with Android and iOS UI

> [MobileSharing](src/thirdparty/MobileSharing/README.md) Use Android and iOS cross application sharing features

> [SingleApplication](src/thirdparty/SingleApplication/README.md) Keep only one instance of your application active at a time

#### QML components

> TODO

#### Deploy scripts

> [Linux](deploy_linux.sh) application ZIP and AppImage

> [macOS](deploy_macos.sh) application ZIP (unsigned)

> [Windows](deploy_windows.sh) application ZIP and NSIS installer

#### GitHub CI workflows

These files are also useful to get an idea about the whole build and deploy process.

> [Desktop (qmake)](.github/workflows/builds_desktop.yml) Linux, macOS and Windows workflow

> [Desktop (cmake)](.github/workflows/builds_desktop_cmake.yml) Linux, macOS and Windows workflow

> [Mobile (qmake)](.github/workflows/builds_mobile.yml) Android and iOS workflow

> [Mobile (cmake)](.github/workflows/builds_mobile_cmake.yml) Android and iOS workflow (with store deployment)

> [Linux flatpak](.github/workflows/flatpak.yml) "on demand" workflow

## Screenshots

![GUI_MOBILE](https://i.imgur.com/gbwRel0.png)

![GUI_DESKTOP1](https://i.imgur.com/4QGJn5G.png)
![GUI_DESKTOP2](https://i.imgur.com/e0VWdYz.png)

## License

QmlAppTemplate is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 3 of the License, or (at your option) any later version.  
Read the [LICENSE](LICENSE.md) file or [consult the license on the FSF website](https://www.gnu.org/licenses/gpl-3.0.txt) directly.

> Emeric Grange <emeric.grange@gmail.com>
