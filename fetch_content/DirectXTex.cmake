include(utilities/fetch_content.cmake)

function(fetch_make_available_DirectXTex library_name)
	
FetchContent_Declare_URL_MakeAvailable(${library_name} https://github.com/microsoft/DirectXTex/archive/refs/heads/main.zip)

    set(ROOT "${${library_name}_SOURCE_DIR}")

    add_library(fox.cmake::${library_name} ALIAS DirectXTex)

endfunction()