include(utilities/fetch_content.cmake)

function(fetch_make_available_eastl library_name)
    # EABASE
    FetchContent_Declare_URL_MakeAvailable(
        ${library_name}_eabase
        https://github.com/electronicarts/EABase/archive/refs/heads/master.zip
    )

    # We don't want to do recursive include
    FetchContent_Declare_URL_MakeAvailable(
        ${library_name} 
        https://github.com/electronicarts/EASTL/archive/refs/heads/master.zip
    )

    set(EASTL_ROOT_DIR ${${library_name}_SOURCE_DIR}) 
    set(CMAKE_MODULE_PATH "${CMAKE_MODULE_PATH};${EASTL_ROOT_DIR}/scripts/CMake")

    # EAASSERT
    FetchContent_Declare_URL_MakeAvailable(
        ${library_name}_eassert
        https://github.com/electronicarts/EAAssert/archive/refs/heads/master.zip
    )

    # EAThread
    FetchContent_Declare_URL_MakeAvailable(
        ${library_name}_eathread
        https://github.com/RedSkittleFox/EAThread/archive/refs/heads/patch-1.zip # Until pull-requrest is accepted
    )

    # EAStdC
    FetchContent_Declare_URL_MakeAvailable(
        ${library_name}_eastdc
        https://github.com/electronicarts/EAStdC/archive/refs/heads/master.zip
    )

    file(WRITE "${EASTL_ROOT_DIR}/eastl_default_allocator.cpp"
"// AUTOGENERATED WITH CMAKE
#include <cstdint>

void* __cdecl operator new[](size_t size, const char* name, int flags, unsigned debugFlags, const char* file, int line)
{
	return new uint8_t[size];
}

void* __cdecl operator new[](size_t size, size_t alignment, size_t alignmentOffset, const char* pName, int flags, unsigned debugFlags, const char* file, int line)
{
    return new uint8_t[size];
}
"
    )

    add_library(
        ${library_name}_allocator
        STATIC
        ${EASTL_ROOT_DIR}/eastl_default_allocator.cpp
        ${EASTL_ROOT_DIR}/doc/EASTL.natvis 
    )

    target_link_libraries(${library_name}_allocator PUBLIC 
        EABase
        EASTL
        EAAssert
        EAThread
        EAStdC
        )

    add_library(fox.cmake::${library_name} ALIAS ${library_name}_allocator)

endfunction()