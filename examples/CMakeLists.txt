function(setup_example example_directory)
    set(EXAMPLE_NAME_BASE "${example_directory}")
    file(GLOB EXAMPLE_SOURCE_FILES "${example_directory}/*.c")

    # Build executable
    foreach(SD_API_VER ${SD_API_VER_NUMS})
        set(EXAMPLE_NAME "${EXAMPLE_NAME_BASE}_v${SD_API_VER}")
        add_executable(${EXAMPLE_NAME} ${EXAMPLE_SOURCE_FILES})

        target_compile_definitions(${EXAMPLE_NAME} PRIVATE -DNRF_SD_BLE_API=${SD_API_VER})
        target_include_directories(${EXAMPLE_NAME} PRIVATE ../src/sd_api_v${SD_API_VER}/sdk/components/softdevice/s130/headers)
        target_include_directories(${EXAMPLE_NAME} PRIVATE ../src/sd_api_v${SD_API_VER}/sdk/components/softdevice/s132/headers)
        target_include_directories(${EXAMPLE_NAME} PRIVATE ../src/sd_api_v${SD_API_VER}/sdk/components/softdevice/s140/headers)

        if(WIN32)
            target_link_libraries(${EXAMPLE_NAME} PRIVATE pc_ble_driver_static_sd_api_v${SD_API_VER})
        elseif(APPLE)
            target_link_libraries(${EXAMPLE_NAME} PRIVATE pc_ble_driver_static_sd_api_v${SD_API_VER})
        else()
            # Assume Linux
            target_link_libraries(${EXAMPLE_NAME} PRIVATE pc_ble_driver_static_sd_api_v${SD_API_VER} "pthread")
        endif()
    endforeach()
endfunction(setup_example)

link_directories (
    ../build
)

if(MSVC)
    add_definitions(-DPC_BLE_DRIVER_STATIC)
    add_definitions(-D_CRT_SECURE_NO_WARNINGS)
endif()

setup_example(heart_rate_monitor)
setup_example(heart_rate_collector)
