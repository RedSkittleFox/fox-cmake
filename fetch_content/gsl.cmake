include(utilities/fetch_content.cmake)

function(fetch_make_available_gsl library_name)
	
    FetchContent_Declare_URL_Populate(${library_name} https://github.com/microsoft/GSL/archive/refs/tags/v4.0.0.zip)

    set(GSL_ROOT "${${library_name}_SOURCE_DIR}")

    add_library(${library_name} INTERFACE 
        ${GSL_ROOT}/GSL.natvis
        )

    target_include_directories(${library_name} INTERFACE 
        ${GSL_ROOT}/include
    )
    
    add_library(fox.cmake::${library_name} ALIAS ${library_name})

endfunction()