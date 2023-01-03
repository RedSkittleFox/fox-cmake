include(FetchContent)

function(fetch_make_available_d3dx12 library_name)
	# HACK, we store it as fetch_content resource!
	
	file(DOWNLOAD 
		"https://raw.githubusercontent.com/microsoft/DirectX-Headers/main/include/directx/d3dx12.h" 
		"${FETCHCONTENT_BASE_DIR}/d3dx12/d3dx12.h"
		)

	file(DOWNLOAD 
		"https://raw.githubusercontent.com/microsoft/DirectX-Headers/main/include/directx/d3dx12_barriers.h" 
		"${FETCHCONTENT_BASE_DIR}/d3dx12/d3dx12_barriers.h"
		)

	file(DOWNLOAD 
		"https://raw.githubusercontent.com/microsoft/DirectX-Headers/main/include/directx/d3dx12_core.h" 
		"${FETCHCONTENT_BASE_DIR}/d3dx12/d3dx12_core.h"
		)
	
	file(DOWNLOAD 
		"https://raw.githubusercontent.com/microsoft/DirectX-Headers/main/include/directx/d3dx12_default.h" 
		"${FETCHCONTENT_BASE_DIR}/d3dx12/d3dx12_default.h"
		)

	file(DOWNLOAD 
		"https://raw.githubusercontent.com/microsoft/DirectX-Headers/main/include/directx/d3dx12_pipeline_state_stream.h" 
		"${FETCHCONTENT_BASE_DIR}/d3dx12/d3dx12_pipeline_state_stream.h"
		)

	file(DOWNLOAD 
		"https://raw.githubusercontent.com/microsoft/DirectX-Headers/main/include/directx/d3dx12_render_pass.h" 
		"${FETCHCONTENT_BASE_DIR}/d3dx12/d3dx12_render_pass.h"
		)

	file(DOWNLOAD 
		"https://raw.githubusercontent.com/microsoft/DirectX-Headers/main/include/directx/d3dx12_resource_helpers.h" 
		"${FETCHCONTENT_BASE_DIR}/d3dx12/d3dx12_resource_helpers.h"
		)

	file(DOWNLOAD 
		"https://raw.githubusercontent.com/microsoft/DirectX-Headers/main/include/directx/d3dx12_root_signature.h" 
		"${FETCHCONTENT_BASE_DIR}/d3dx12/d3dx12_root_signature.h"
		)

	file(DOWNLOAD 
		"https://raw.githubusercontent.com/microsoft/DirectX-Headers/main/include/directx/d3dx12_state_object.h" 
		"${FETCHCONTENT_BASE_DIR}/d3dx12/d3dx12_state_object.h"
		)

	file(DOWNLOAD 
		"https://raw.githubusercontent.com/microsoft/DirectX-Headers/main/include/directx/d3dx12_check_feature_support.h" 
		"${FETCHCONTENT_BASE_DIR}/d3dx12/d3dx12_check_feature_support.h"
		)

	file(DOWNLOAD 
		"https://raw.githubusercontent.com/microsoft/DirectX-Headers/main/include/directx/d3dx12_property_format_table.h" 
		"${FETCHCONTENT_BASE_DIR}/d3dx12/d3dx12_property_format_table.h"
		)

	add_library(${library_name} INTERFACE "${FETCHCONTENT_BASE_DIR}/d3dx12/d3dx12.h")
	target_include_directories(${library_name} INTERFACE "${FETCHCONTENT_BASE_DIR}/d3dx12/")

	add_library(fox.cmake::${library_name} ALIAS ${library_name})

endfunction()