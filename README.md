# QmlAppTemplate

[![GitHub action](https://img.shields.io/github/actions/workflow/status/emericg/QmlAppTemplate/builds_desktop_cmake.yml?style=flat-square)](actions/workflows/builds_desktop_cmake.yml)
[![GitHub action](https://img.shields.io/github/actions/workflow/status/emericg/QmlAppTemplate/builds_mobile_cmake.yml?style=flat-square)](actions/workflows/builds_mobile_cmake.yml)
[![GitHub issues](https://img.shields.io/github/issues/emericg/QmlAppTemplate.svg?style=flat-square)](issues/)
[![GitHub license](https://img.shields.io/github/license/emericg/QmlAppTemplate?style=flat-square&color=blue)](LICENSE.md)

## About

A Qt6 / QML application template, with a full set of visual controls, helper modules, as well as build and deploy scripts and CI setups.

#### Prerequisites

You will need a C++17 compiler and Qt 6.8 LTS (or better).  

For macOS and iOS builds, you'll need Xcode (15+) installed.  
For Android builds, you'll need the appropriates JDK (17) SDK (28+) and NDK (26b+). You can customize Android build environment using the `assets/android/gradle.properties` file.  

> https://doc.qt.io/qt-6.8/supported-platforms.html

#### Platform support

- Linux
- macOS 12+
- Windows 10+
- Android 9+
- iOS 16+

#### Recent changes

Qt 6.8 brings big changes and hard platform requirements, so I took this "opportunity"
to modernize this template a bit. Let's embrace breaking everything! Again.

For instance QmlAppTemplate is now using cmake only. Maintaining both cmake and qmake
variants of many things was just too much work, and both sides were suffering of
less than ideal support. Qt 6 is geared toward cmake, and latest Qt 6 releases are
introducing even more tighly coupled features and tooling requirements anyway.

At the time of this writing, Qt 6.8 just released, so if you can't meet these requirements,
or still want to use qmake, you can check out the code from the 0.7 release.

#### Building QmlAppTemplate

```bash
$ git clone https://github.com/emericg/QmlAppTemplate.git --recursive
$ cmake -B build/
$ cmake --build build/
```

To build for Android and iOS, you should use the qt-cmake script from your Qt installation.

```bash
$ /path/to/Qt/bin/qt-cmake -B build/
$ cmake --build build/
```

## Content

#### C++ modules

> [AppUtils](thirdparty/AppUtils/README.md) Various general purpose helpers

> [MobileUI](https://github.com/emericg/MobileUI) Interact with Android and iOS UI

> [MobileSharing](thirdparty/MobileSharing/README.md) Use Android and iOS cross application sharing features

> [SingleApplication](thirdparty/SingleApplication/README.md) Keep only one instance of your desktop application active at a time

#### QML component library

> TODO

#### Icon library

> TODO

#### Deploy scripts

> [Linux](deploy_linux.sh) application ZIP and AppImage

> [macOS](deploy_macos.sh) application ZIP (unsigned)

> [Windows](deploy_windows.sh) application ZIP and NSIS installer

#### GitHub CI workflows

These files are also useful to get an idea about the whole build and deploy process.

> [Desktop (cmake)](.github/workflows/builds_desktop_cmake.yml) Linux, macOS and Windows workflow

> [Mobile (cmake)](.github/workflows/builds_mobile_cmake.yml) Android and iOS workflow (with store deployment)

> [Linux flatpak](.github/workflows/flatpak.yml) "on demand" workflow

## Screenshots

![GUI_MOBILE](https://i.imgur.com/gbwRel0.png)

![GUI_DESKTOP1](https://i.imgur.com/4QGJn5G.png)
![GUI_DESKTOP2](https://i.imgur.com/e0VWdYz.png)

## Licensing

QmlAppTemplate is released under the terms of the [MIT license](license.md).

> Emeric Grange <emeric.grange@gmail.com>

* [AppUtils](thirdparty/AppUtils/README.md) uses MIT license

* [MobileUI](https://github.com/emericg/MobileUI) uses MIT license

* [MobileSharing](thirdparty/MobileSharing/README.md) uses MIT license

* [SingleApplication](thirdparty/SingleApplication/README.md) uses MIT license

* [ComponentLibrary](thirdparty/ComponentLibrary/) uses MIT license

* [IconLibrary](assets/icons/) uses a combinaison of licenses, see [COPYING](assets/icons/COPYING)
