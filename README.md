# QmlAppTemplate

[![GitHub action](https://img.shields.io/github/workflow/status/emericg/QmlAppTemplate/Desktop%20CI%20builds.svg?style=flat-square)](https://github.com/emericg/QmlAppTemplate/actions/workflows/builds_desktop.yml)
[![GitHub action](https://img.shields.io/github/workflow/status/emericg/QmlAppTemplate/Mobile%20CI%20builds.svg?style=flat-square)](https://github.com/emericg/QmlAppTemplate/actions/workflows/builds_mobile.yml)
[![GitHub issues](https://img.shields.io/github/issues/emericg/QmlAppTemplate.svg?style=flat-square)](https://github.com/emericg/QmlAppTemplate/issues)
[![License: GPL v3](https://img.shields.io/badge/license-GPL%20v3-blue.svg?style=flat-square)](http://www.gnu.org/licenses/gpl-3.0)

A Qt6 / QML application template, with a full set of visual controls, helper modules, as well as build and deploy scripts and CI setups.

## About

### Application

A simple template application.

You will need a C++17 compiler and Qt 6.3+.  
For macOS and iOS builds, you'll need Xcode installed.  
For Android builds, you'll need the appropriates JDK (11) SDK (23+) and NDK (22+). You can customize Android build environment using the `assets/android/gradle.properties` file.  

Qt 6 'Additional Librairies':
- Qt 5 Compatibility Module

```bash
$ git clone https://github.com/emericg/QmlAppTemplate.git
$ cd QmlAppTemplate/
$ qmake
$ make
```

### C++ modules

> [AppUtils](src/thirdparty/AppUtils/README.md)

> [MobileUI](src/thirdparty/MobileUI/README.md)

> [MobileSharing](src/thirdparty/MobileSharing/README.md)

> [SingleApplication](src/thirdparty/SingleApplication/README.md)

### QML components

> TODO

### Deploy scripts

> [Linux](deploy_linux.sh) AppImage

> [macOS](deploy_macos.sh) zip

> [Windows](deploy_windows.sh) zip and NSIS installer

### GitHub CI workflows

These files are also useful to get an idea about the whole build and deploy process.

> [Desktop](.github/workflows/builds_desktop.yml)

> [Mobile](.github/workflows/builds_mobile.yml)

> [Linux flatpak](.github/workflows/flatpak.yml)

## License

QmlAppTemplate is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 3 of the License, or (at your option) any later version.  
Read the [LICENSE](LICENSE.md) file or [consult the license on the FSF website](https://www.gnu.org/licenses/gpl-3.0.txt) directly.

> Emeric Grange <emeric.grange@gmail.com>
