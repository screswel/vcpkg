# TODO - should I be using $ENV{VCPKG_ROOT} ?
set(VCPKG_CHAINLOAD_TOOLCHAIN_FILE "${CURRENT_BUILDTREES_DIR}/../../scripts/toolchains/windows-llvm.cmake")

# XXX - needed to avoid some link.exe errors
set(VCPKG_POLICY_SKIP_ARCHITECTURE_CHECK enabled)
set(VCPKG_POLICY_SKIP_DUMPBIN_CHECKS enabled)

# XXX - ensure clang-cl can treat all objc/objc++ files as c/c++ files
set(ENV{CCC_OVERRIDE_OPTIONS} "x-TC x-TP x/TC x/TP")

set(SOURCE_PATH ${CURRENT_BUILDTREES_DIR}/src/${PORT})

find_program(GIT git)

set(GIT_URL "https://github.com/gnustep/libobjc2.git")

if(NOT EXISTS "${SOURCE_PATH}/.git")
    # message(STATUS "Cloning and fetching submodules")
    vcpkg_execute_required_process(
        COMMAND ${GIT} clone --recurse-submodules ${GIT_URL} ${SOURCE_PATH}
        WORKING_DIRECTORY ${CURRENT_BUILDTREES_DIR}
        LOGNAME clone
    )

    # message(STATUS "Patch")
    vcpkg_apply_patches(
        SOURCE_PATH "${SOURCE_PATH}"
        PATCHES
            0001-fix-cmake-install.patch   
    )
endif()

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    GENERATOR Ninja
)

vcpkg_cmake_install()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share")

file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/bin)
file(RENAME ${CURRENT_PACKAGES_DIR}/lib/objc.dll ${CURRENT_PACKAGES_DIR}/bin/objc.dll)

file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/debug/bin)
file(RENAME ${CURRENT_PACKAGES_DIR}/debug/lib/objc.dll ${CURRENT_PACKAGES_DIR}/debug/bin/objc.dll)

file(INSTALL "${SOURCE_PATH}/COPYING" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)

vcpkg_fixup_pkgconfig()