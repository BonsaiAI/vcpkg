# Common Ambient Variables:
#   CURRENT_BUILDTREES_DIR    = ${VCPKG_ROOT_DIR}\buildtrees\${PORT}
#   CURRENT_PACKAGES_DIR      = ${VCPKG_ROOT_DIR}\packages\${PORT}_${TARGET_TRIPLET}
#   CURRENT_PORT_DIR          = ${VCPKG_ROOT_DIR}\ports\${PORT}
#   PORT                      = current port name (zlib, etc)
#   TARGET_TRIPLET            = current triplet (x86-windows, x64-windows-static, etc)
#   VCPKG_CRT_LINKAGE         = C runtime linkage type (static, dynamic)
#   VCPKG_LIBRARY_LINKAGE     = target library linkage type (static, dynamic)
#   VCPKG_ROOT_DIR            = <C:\path\to\current\vcpkg>
#   VCPKG_TARGET_ARCHITECTURE = target architecture (x64, x86, arm)
#

# set(VCPKG_LIBRARY_LINKAGE dynamic)

include(vcpkg_common_functions)
set(SOURCE_PATH ${CURRENT_BUILDTREES_DIR}/src/bonsai)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO BonsaiAI/libbonsai
    REF client/sdk-2018.11.27
    SHA512 875fac9f4138bfae38915100e80c06e96c39dd9ec877b173ffabc26c2cc3f1c1d6684f278f62a364160efbe62886d88760a6d34f3e622e9fe45a2f10d8af3e78
    HEAD_REF master
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}/libbonsai
    OPTIONS -DWITH_TESTS=FALSE
)

vcpkg_install_cmake()

# Handle copyright
file(INSTALL ${SOURCE_PATH}/libbonsai/LICENSE.txt DESTINATION ${CURRENT_PACKAGES_DIR}/share/bonsai RENAME copyright)

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
