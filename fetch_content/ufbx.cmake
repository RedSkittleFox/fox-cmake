include(FetchContent)

function(fetch_make_available_ufbx library_name)
	
	FetchContent_Declare(
        ${library_name}
        GIT_REPOSITORY https://github.com/bqqbarbhg/ufbx.git
	)

	FetchContent_MakeAvailable(${library_name})

    add_library(
        ${library_name} STATIC
        "${${library_name}_SOURCE_DIR}/ufbx.h"
        "${${library_name}_SOURCE_DIR}/ufbx.c"
    )

    target_include_directories(${library_name} PUBLIC "${${library_name}_SOURCE_DIR}")

    add_library(fox.cmake::${library_name} ALIAS ${library_name})

endfunction()