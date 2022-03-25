# Overview

This is a fork of Microsoft's vcpkg repository (https://github.com/microsoft/vcpkg) to assist building and installing GNUstep's implementation of the CoreFoundation, Foundation and AppKit libraries.<br>

It is unlikely that these changes will ever be merged back into the trunk as Microsoft's current policy is to block any port that cannot be built using their MSVC toolchain - shame. See https://github.com/microsoft/vcpkg/README.md for Microsoft's original spiel.

# Getting Started - WIP

```cmd
Install MSVC toolchain - a trial version of Visual Studio 2019 is sufficient.
```

Install and bootrap vcpkg:
```cmd
Start an "x64 Native Tools Command Prompt for VS 2019" shell
cd c:\
mkdir src
cd src
git clone https://github.com/screswel/vcpkg.git
cd vcpkg
git pull
bootstrap-vcpkg.bat -disableMetrics
exit
```

Install vcpkg LLVM toolchain - this is patched for Windows-specific Objective-C issues:
```cmd
Start an "x64 Native Tools Command Prompt for VS 2019" shell
cd c:\
cd src
cd vcpkg
vcpkg install llvm:x64-windows
exit
```

Edit path variable:
```cmd
Type "Control Panel" into the Windows Search Box and hit <return>
Click on "User Accounts"
Click on "User Accounts" - yes again!
Click on "Change my environment variables"
Create a new variable VCPKG_ROOT and assign it "C:\src\vcpkg"
Edit the "Path" variable - add %VCPKG_ROOT%
Edit the "Path" variable - add %VCPKG_ROOT%\installed\x64-windows\tools\llvm%
Order the new "Path" variables so they are before any Visual Studio toolchains
Close
```

Check path variable:
```cmd
Start an "x64 Native Tools Command Prompt for VS 2019" shell
where clang
  C:\src\vcpkg\installed\x64-windows\tools\llvm\clang.exe
  C:\Program Files (x86)\Microsoft Visual Studio\2019\Professional\VC\Tools\Llvm\x64\bin\clang.exe
exit
```

Install vcpkg libraries:
```cmd
Start an "x64 Native Tools Command Prompt for VS 2019" shell
cd c:\
cd src
cd vcpkg
vcpkg install libffi:x64-windows
vcpkg install libiconv:x64-windows
vcpkg install libxml2:x64-windows
vcpkg install libxslt:x64-windows
vcpkg install icu:x64-windows
vcpkg install libobjc2:x64-windows
vcpkg install libdispatch:x64-windows
vcpkg install libjpeg-turbo:x64-windows
vcpkg install libpng:x64-windows
vcpkg install tiff:x64-windows
exit
```

Install and configure MSYS:
```cmd
Install MSYS - follow steps 1..6 from here https://www.msys2.org

Start an MSYS shell
pacman -S --needed make autoconf automake libtool pkg-config
exit
```

Install and build GNUstep-provided libraries:
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