include(utilities/fetch_content.cmake)

function(fetch_make_available_d3d12_memory_allocator library_name)

    FetchContent_Declare_URL_MakeAvailable(${library_name}
        https://github.com/GPUOpen-LibrariesAndSDKs/D3D12MemoryAllocator/archive/refs/tags/v2.0.1.zip
    )

    add_library(fox.cmake::${library_name} ALIAS D3D12MemoryAllocator)

    target_include_directories(D3D12MemoryAllocator PUBLIC "${${library_name}_SOURCE_DIR}/include")

endfunction()