# TODO - should I be using $ENV{VCPKG_ROOT} ?
set(VCPKG_CHAINLOAD_TOOLCHAIN_FILE "${CURRENT_BUILDTREES_DIR}/../../scripts/toolchains/windows-llvm.cmake")

# XXX - needed to avoid some link.exe errors
set(VCPKG_POLICY_SKIP_ARCHITECTURE_CHECK enabled)
set(VCPKG_POLICY_SKIP_DUMPBIN_CHECKS enabled)

# XXX - setup Visual Studio environment - even though VCPKG_CHAINLOAD_TOOLCHAIN_FILE is set
set(VCPKG_LOAD_VCVARS_ENV ON)

# XXX - ensure clang-cl can treat all objc/objc++ files as c/c++ files
set(ENV{CCC_OVERRIDE_OPTIONS} "x-TC x-TP x/TC x/TP")

# This port needs to be updated at the same time as mongo-c-driver
vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO apple/swift-corelibs-libdispatch
    REF swift-5.5-RELEASE
    SHA512 58ad7122d2fac7b117f4e81eec2b5c1dfdf5256865337110d660790744e83c3fea5e82fbe521b6e56fd0e2f09684e5e1475cf2cac67989a8f78dd0a284fb0d21
    HEAD_REF master
    PATCHES
        0001-fix-redefinitions.patch
        0002-own-blocksruntime.patch
        0003-fix-cmake.patch
)

# XXX - match cmake command line arguments from tools-windows-msvc/phases/18-libdispatch.bat

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DBUILD_SHARED_LIBS=YES
        -DINSTALL_PRIVATE_HEADERS=YES
        # -DCMAKE_CXX_FLAGS_RELWITHDEBINFO="/Zi"
        # -DCMAKE_SHARED_LINKER_FLAGS_RELWITHDEBINFO="/INCREMENTAL:NO /DEBUG /OPT:REF /OPT:ICF"
        -DBlocksRuntime_INCLUDE_DIR="${CURRENT_INSTALLED_DIR}/include"
        -DBlocksRuntime_LIBRARIES="${CURRENT_INSTALLED_DIR}/lib/objc.lib"
)

vcpkg_cmake_install()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share")

file(INSTALL "${SOURCE_PATH}/LICENSE" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)

vcpkg_fixup_pkgconfig()