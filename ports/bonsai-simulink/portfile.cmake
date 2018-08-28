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

set(VCPKG_LIBRARY_LINKAGE dynamic)
set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

include(vcpkg_common_functions)
set(SOURCE_PATH ${CURRENT_BUILDTREES_DIR}/src/bonsai-simulink)

# eventually this should point to a remote public repo in the BonsaiAI org
vcpkg_download_distfile(ARCHIVE
    URLS "https://s3.amazonaws.com/orendev-libbonsai-archive/bonsai-simulink-1.0.dev1.tar.gz"
    FILENAME "bonsai-simulink-1.0.dev1.tar.gz"
    SHA512 5367eea5e2714980082dfe500e58c10a797468016615694948398bdeb6a15aa86c0f36a57f36119561d5ab525cfa0de3aecf54044528ea2d0b6a71844ec8ae99    
)

vcpkg_extract_source_archive(${ARCHIVE})

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
)

vcpkg_install_cmake()

# Handle copyright
file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/bonsai-simulink RENAME copyright)
