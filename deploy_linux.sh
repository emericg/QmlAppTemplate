#!/usr/bin/env bash

export APP_NAME="QmlAppTemplate"
export APP_VERSION=$(sed -n 's/^project(.*VERSION \([0-9.]*\).*/\1/p' CMakeLists.txt)
export GIT_VERSION=$(git rev-parse --short HEAD)

#export APP_NAME_CASE=${APP_NAME,,}   # lowercase
export APP_NAME_CASE=$APP_NAME        # not lowercase

# Detect the (host) OS architecture
export ARCH=$(uname -m)

# Target architecture for packaging (override with $PKG_ARCH for cross-compilation)
case "${PKG_ARCH:-$ARCH}" in
  x86_64)        PKG_ARCH="x86_64"; LD_ARCH="x86_64"  ;;
  aarch64|arm64) PKG_ARCH="arm64";  LD_ARCH="aarch64" ;;
  *) echo "Unsupported architecture: ${PKG_ARCH:-$ARCH}" 1>&2; exit 1 ;;
esac

echo "> $APP_NAME packager (Linux $PKG_ARCH) [v$APP_VERSION]"

## CHECKS ######################################################################

if [ "$(id -u)" == "0" ]; then
  echo "This script MUST NOT be run as root" 1>&2
  exit 1
fi

if [ ${PWD##*/} != $APP_NAME ]; then
  echo "This script MUST be run from the $APP_NAME/ directory"
  exit 1
fi

## SETTINGS ####################################################################

use_contribs=false
make_install=false
create_package=false
upload_package=false

while [[ $# -gt 0 ]]
do
case $1 in
  -c|--contribs)
  use_contribs=true
  ;;
  -i|--install)
  make_install=true
  ;;
  -p|--package)
  create_package=true
  ;;
  -u|--upload)
  upload_package=true
  ;;
  *)
  echo "> Unknown argument '$1'"
  ;;
esac
shift # skip argument or value
done

## PREP WORK ###################################################################

#unset LD_LIBRARY_PATH; #unset QT_PLUGIN_PATH;

if [[ $use_contribs = true ]] ; then
  export LD_LIBRARY_PATH=$(pwd)/contribs/src/env/linux_$LD_ARCH/usr/lib/:$LD_LIBRARY_PATH
fi

if [[ -n "${QT_ROOT_DIR:-}" ]] ; then
  # cleanup undeployable Qt plugins (present, but missing their own dependencies)
  # only if we are on a GitHub Action server, because this remove the plugins from the Qt directory
  echo '---- Remove undeployable Qt plugins'
  sudo rm $QT_ROOT_DIR/plugins/position/libqtposition_nmea.so
  sudo rm $QT_ROOT_DIR/plugins/sqldrivers/libqsqlmimer.so
  sudo rm $QT_ROOT_DIR/plugins/sqldrivers/libqsqlmysql.so
  sudo rm $QT_ROOT_DIR/plugins/sqldrivers/libqsqloci.so
  sudo rm $QT_ROOT_DIR/plugins/sqldrivers/libqsqlodbc.so
  sudo rm $QT_ROOT_DIR/plugins/sqldrivers/libqsqlpsql.so
fi

## linuxdeploy INSTALL #########################################################

echo '---- Prepare linuxdeploy + plugins'

# linuxdeploy and plugins
if [ ! -x contribs/deploy/linuxdeploy-$LD_ARCH.AppImage ]; then
  wget -c -nv "https://github.com/linuxdeploy/linuxdeploy/releases/download/continuous/linuxdeploy-$LD_ARCH.AppImage" -P contribs/deploy/
  wget -c -nv "https://github.com/linuxdeploy/linuxdeploy-plugin-appimage/releases/download/continuous/linuxdeploy-plugin-appimage-$LD_ARCH.AppImage" -P contribs/deploy/
  wget -c -nv "https://github.com/linuxdeploy/linuxdeploy-plugin-qt/releases/download/continuous/linuxdeploy-plugin-qt-$LD_ARCH.AppImage" -P contribs/deploy/
fi
chmod a+x contribs/deploy/linuxdeploy-$LD_ARCH.AppImage
chmod a+x contribs/deploy/linuxdeploy-plugin-appimage-$LD_ARCH.AppImage
chmod a+x contribs/deploy/linuxdeploy-plugin-qt-$LD_ARCH.AppImage

# linuxdeploy-plugin-qt hacks
#export QMAKE="qmake6" # force Qt6, if you have Qt5 installed
#export NO_STRIP=true  # workaround, strip not working on modern binutils

# linuxdeploy-plugin-qt settings
export EXTRA_QT_MODULES="svg;waylandcompositor;"
export EXTRA_QT_PLUGINS=""
export EXTRA_PLATFORM_PLUGINS="libqwayland.so" # Qt 6.10+
#export EXTRA_PLATFORM_PLUGINS="libqwayland-egl.so;libqwayland-generic.so" # Qt 5+
export QML_SOURCES_PATHS="$(pwd)/qml/"
export QML_MODULES_PATHS=""

## APP INSTALL #################################################################

if [[ $make_install = true ]] ; then
  echo '---- Running make install'
  make INSTALL_ROOT=bin/ install

  #echo '---- Installation directory content recap (after make install):'
  #find bin/
fi

## PACKAGE (AppImage) ##########################################################

if [[ $create_package = true ]] ; then
  echo '---- Format appdir'
  mkdir -p bin/usr/bin/
  mkdir -p bin/usr/share/appdata/
  mkdir -p bin/usr/share/applications/
  mkdir -p bin/usr/share/pixmaps/
  mkdir -p bin/usr/share/icons/hicolor/scalable/apps/
  mv bin/$APP_NAME bin/usr/bin/$APP_NAME
  cp platforms/linux/$APP_NAME_CASE.appdata.xml bin/usr/share/appdata/$APP_NAME_CASE.appdata.xml
  cp platforms/linux/$APP_NAME_CASE.desktop bin/usr/share/applications/$APP_NAME_CASE.desktop
  cp platforms/linux/$APP_NAME_CASE.svg bin/usr/share/pixmaps/$APP_NAME_CASE.svg
  cp platforms/linux/$APP_NAME_CASE.svg  bin/usr/share/icons/hicolor/scalable/apps/$APP_NAME_CASE.svg

  echo '---- Running AppImage packager'
  ./contribs/deploy/linuxdeploy-$LD_ARCH.AppImage --appdir bin --plugin qt --output appimage
  mv $APP_NAME-$LD_ARCH.AppImage $APP_NAME-$APP_VERSION-$PKG_ARCH.AppImage

  #echo '---- Installation directory content recap (after linuxdeploy):'
  #find bin/
fi

## PACKAGE (archive) ###########################################################

if [[ $create_package = true ]] ; then
  echo '---- Reorganize appdir into a regular directory'
  mkdir bin/$APP_NAME/
  mv bin/usr/bin/* bin/$APP_NAME/
  mv bin/usr/lib/* bin/$APP_NAME/
  mv bin/usr/plugins bin/$APP_NAME/
  mv bin/usr/qml bin/$APP_NAME/
  mv bin/usr/share/appdata/$APP_NAME_CASE.appdata.xml bin/$APP_NAME/
  mv bin/usr/share/applications/$APP_NAME_CASE.desktop bin/$APP_NAME/
  mv bin/usr/share/pixmaps/$APP_NAME_CASE.svg bin/$APP_NAME/
  printf '[Paths]\nPrefix = .\nPlugins = plugins\nImports = qml\n' > bin/$APP_NAME/qt.conf
  printf '#!/bin/sh\nappname=`basename $0 | sed s,\.sh$,,`\ndirname=`dirname $0`\nexport LD_LIBRARY_PATH=$dirname\n$dirname/$appname' > bin/$APP_NAME/$APP_NAME_CASE.sh
  chmod +x bin/$APP_NAME/$APP_NAME_CASE.sh

  #echo '---- MapLibre deployment hack'
  #export MAPLIBRE_VERSION=3.0.0
  #cp -r $QT_ROOT_DIR/qml/MapLibre/ bin/$APP_NAME/qml/MapLibre/
  #cp $QT_ROOT_DIR/plugins/geoservices/libqtgeoservices_maplibre.so bin/$APP_NAME/plugins/geoservices/libqtgeoservices_maplibre.so
  #cp $QT_ROOT_DIR/lib/libQMapLibre.so.$MAPLIBRE_VERSION            bin/$APP_NAME/libQMapLibre.so.3
  #cp $QT_ROOT_DIR/lib/libQMapLibreLocation.so.$MAPLIBRE_VERSION    bin/$APP_NAME/libQMapLibreLocation.so.3

  #echo '---- WebEngine deployment hack'
  #export QT_VERSION=6.10.3
  #mkdir -p bin/$APP_NAME/plugins/webview
  #cp $QT_ROOT_DIR/plugins/webview/libqtwebview_webengine.so  bin/$APP_NAME/plugins/webview/libqtwebview_webengine.so
  #cp $QT_ROOT_DIR/lib/libQt6WebEngineCore.so.$QT_VERSION     bin/$APP_NAME/libQt6WebEngineCore.so.6
  #cp $QT_ROOT_DIR/lib/libQt6WebEngineQuick.so.$QT_VERSION    bin/$APP_NAME/libQt6WebEngineQuick.so.6
  #cp $QT_ROOT_DIR/lib/libQt6WebChannel.so.$QT_VERSION        bin/$APP_NAME/libQt6WebChannel.so.6
  #cp $QT_ROOT_DIR/lib/libQt6WebChannelQuick.so.$QT_VERSION   bin/$APP_NAME/libQt6WebChannelQuick.so.6
  #cp $QT_ROOT_DIR/libexec/QtWebEngineProcess                 bin/$APP_NAME/QtWebEngineProcess
  #cp -r $QT_ROOT_DIR/resources bin/$APP_NAME/resources
  #rm bin/$APP_NAME/resources/qtwebengine_devtools_resources.pak

  echo '---- Compressing package'
  cd bin
  tar zcvf ../$APP_NAME-$APP_VERSION-$PKG_ARCH.tar.gz $APP_NAME/
fi

## UPLOAD ######################################################################

if [[ $upload_package = true ]] ; then
  : # TODO: upload package
fi
