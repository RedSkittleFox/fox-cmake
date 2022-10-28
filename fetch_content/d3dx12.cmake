include(FetchContent)

function(fetch_make_available_d3dx12 library_name)
	# HACK, we store it as fetch_content resource!
	file(DOWNLOAD 
		"https://raw.githubusercontent.com/microsoft/DirectX-Headers/main/include/directx/d3dx12.h" 
		"${FETCHCONTENT_BASE_DIR}/d3dx12/d3dx12.h"
		)
	add_library(${library_name} INTERFACE "${FETCHCONTENT_BASE_DIR}/d3dx12/d3dx12.h")
	target_include_directories(${library_name} INTERFACE "${FETCHCONTENT_BASE_DIR}/d3dx12/")

	add_library(fox.cmake::${library_name} ALIAS ${library_name})

endfunction()