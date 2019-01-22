#Create install target
set(NRF_BLE_DRIVER_INCLUDE_PREFIX "include/nrf/ble/driver")

include(GNUInstallDirs)
include(CMakePackageConfigHelpers)

install(FILES "LICENSE" DESTINATION share)

message(STATUS "CMAKE_INSTALL_LIBDIR: ${CMAKE_INSTALL_LIBDIR} CMAKE_INSTALL_INCLUDEDIR: ${CMAKE_INSTALL_INCLUDEDIR}")

foreach(SD_API_VER ${SD_API_VERS})
    string(TOLOWER ${SD_API_VER} SD_API_VER_L)

    install(
        TARGETS ${NRF_BLE_DRIVER_${SD_API_VER}_SHARED_LIB}
        EXPORT ${PROJECT_NAME}-targets
        LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
        ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
        RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
        PUBLIC_HEADER DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/${SD_API_VER_L}
        COMPONENT SDK
    )

    install(
        TARGETS ${NRF_BLE_DRIVER_${SD_API_VER}_STATIC_LIB}
        EXPORT ${PROJECT_NAME}-targets
        LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
        ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
        RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
        PUBLIC_HEADER DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/${SD_API_VER_L}
        COMPONENT SDK
    )
endforeach(SD_API_VER)

set(NRF_BLE_DRIVER_CMAKECONFIG_INSTALL_DIR "share/cmake" CACHE STRING "install path for nrf-ble-driverConfig.cmake")

configure_package_config_file(
    cmake/${PROJECT_NAME}Config.cmake.in
    "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}Config.cmake"
    INSTALL_DESTINATION ${NRF_BLE_DRIVER_CMAKECONFIG_INSTALL_DIR}
)

write_basic_package_version_file(
    "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}ConfigVersion.cmake"
    VERSION ${NRF_BLE_DRIVER_VERSION}
    COMPATIBILITY AnyNewerVersion
)

install(
    FILES
    ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}Config.cmake
    ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}ConfigVersion.cmake
    DESTINATION ${NRF_BLE_DRIVER_CMAKECONFIG_INSTALL_DIR}
)

install(
    EXPORT ${PROJECT_NAME}-targets
    FILE ${PROJECT_NAME}Targets.cmake
    NAMESPACE nrf::
    DESTINATION ${NRF_BLE_DRIVER_CMAKECONFIG_INSTALL_DIR}
)
