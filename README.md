# Overview

This is a fork of Microsoft's vcpkg repository (https://github.com/microsoft/vcpkg) to assist building and installing GNUstep's implementation of the CoreFoundation, Foundation and AppKit libraries.<br>

It is unlikely that these changes will ever be merged back into the trunk as Microsoft's current policy is to block any port that cannot be built using their MSVC toolchain - shame. See https://github.com/microsoft/vcpkg/README.md for Microsoft's original spiel.

# Getting Started - WIP

```cmd
Install MSVC toolchain - a trial version of Visual Studio 2019 is sufficient.
```

```cmd
Start an "x64 Native Tools Command Prompt for VS 2019" shell
cd c:\
mkdir src
cd src
git clone https://github.com/screswel/vcpkg.git
cd vcpkg
git pull
bootstrap-vcpkg.bat -disableMetrics
vcpkg install libffi:x64-windows
vcpkg install libiconv:x64-windows
vcpkg install libxml2:x64-windows
vcpkg install libxslt:x64-windows
vcpkg install icu:x64-windows
vcpkg install libobjc2:x64-windows
vcpkg install libdispatch:x64-windows
vcpkg install libjpeg:x64-windows
vcpkg install libpng:x64-windows
vcpkg install tiff:x64-windows
exit
```

```cmd
Install MSYS - follow steps 1..6 from here https://www.msys2.org
```

```cmd
Start an MSYS shell
pacman -S --needed make autoconf automake libtool pkg-config
exit
```

```cmd
Start an "x64 Native Tools Command Prompt for VS 2019" shell
cd c:\
cd src
git clone https://github.com/screswel/tools-windows-msvc.git
cd tools-windows-msvc
git pull
build.bat --type Release --only gnustep-make
build.bat --type Release --only gnustep-base
build.bat --type Release --only gnustep-corebase
build.bat --type Release --only gnustep-gui
exit
```