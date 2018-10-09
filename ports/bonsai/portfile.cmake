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
    REF client/sdk-2018.10.08
    SHA512 377efa798b451f4aa19e69b3550f598b5f77b37fe79cd4fcb0408314aefb6778907c7e27e91a563d9c579b40e13b7ab6e6ece86e3a1d0918a9841d0191900993
#    SHA512 ae0e75ff40a732c98a3e8fb00e26b573466faff71460dd528541b1bcee837c42dd7ba607b4f64594a979de3d5228be1d0e04ecbe51ce2a687ba5868fc1deb739    
    HEAD_REF master
)

# eventually this should point to the head of a remote git repo in the BonsaiAI org
# vcpkg_download_distfile(ARCHIVE
#     # URLS "https://s3.amazonaws.com/orendev-libbonsai-archive/bonsai-1.0.dev3.tar.gz"
#     # FILENAME "bonsai-1.0.dev3.tar.gz"
#     # SHA512 9944d67e64ecf66ccd528f3ae7f5ef45c926b338f17b3948e6041f0fc2800a66b031f92d089153a647bc661e8ff98050c84c2395755e4d127daaa2a305f480bd
#     URLS "https://s3.amazonaws.com/orendev-libbonsai-archive/libbonsai_2.0.4.pre.tar.gz"
#     FILENAME "libbonsai_2.0.4.pre.tar.gz"
#     SHA512 2d106c410f77f46d669579672ddcdb584f45e24d6ebfc60cd052d706ccde52a9c852b7b6cdd34ac13c06d40147a7096a9576e83807fc98fe25244ef1151a386c
# )
# vcpkg_extract_source_archive(${ARCHIVE})

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}/libbonsai
    OPTIONS -DWITH_TESTS=TRUE
)

vcpkg_install_cmake()

# Handle copyright
file(INSTALL ${SOURCE_PATH}/libbonsai/LICENSE.txt DESTINATION ${CURRENT_PACKAGES_DIR}/share/bonsai RENAME copyright)

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
