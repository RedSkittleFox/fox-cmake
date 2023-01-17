include(FetchContent)

function(fetch_make_available_bs_thread_pool library_name)
    FetchContent_Declare(
        ${library_name}
        GIT_REPOSITORY  https://github.com/bshoshany/thread-pool.git
    )

    FetchContent_MakeAvailable(${library_name})

    set(SOURCE_DIR "${${library_name}_SOURCE_DIR}")

    add_library(
        ${library_name} 
        INTERFACE
        "${SOURCE_DIR}/BS_thread_pool.hpp"
    )

    target_include_directories(${library_name} INTERFACE "${SOURCE_DIR}/")

    add_library(fox.cmake::${library_name} ALIAS ${library_name})
endfunction()