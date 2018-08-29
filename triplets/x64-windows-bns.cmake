set(VCPKG_TARGET_ARCHITECTURE x64)
set(VCPKG_CRT_LINKAGE static)
set(VCPKG_LIBRARY_LINKAGE static)

if (PORT MATCHES "bonsai")
 set(VCPKG_LIBRARY_LINKAGE dynamic)
endif()

if (PORT MATCHES "bonsai-simulink")
 set(VCPKG_BUILD_TYPE release)
endif()

