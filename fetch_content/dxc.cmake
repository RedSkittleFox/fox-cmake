include(utilities/fetch_content.cmake)

function(fetch_make_available_dxc library_name)
	
	FetchContent_Declare_URL_Populate(${library_name} https://github.com/microsoft/DirectXShaderCompiler/releases/download/v1.6.2112/dxc_2021_12_08.zip)

	file(MAKE_DIRECTORY ${${library_name}_SOURCE_DIR}/include)
	file(COPY ${${library_name}_SOURCE_DIR}/inc/d3d12shader.h DESTINATION ${${library_name}_SOURCE_DIR}/include/dxc)
	file(COPY ${${library_name}_SOURCE_DIR}/inc/dxcapi.h DESTINATION ${${library_name}_SOURCE_DIR}/include/dxc)
	
	add_library(
		${library_name}
		INTERFACE
		"${${library_name}_SOURCE_DIR}/include/dxc/d3d12shader.h"
		"${${library_name}_SOURCE_DIR}/include/dxc/dxcapi.h"
	)

	target_include_directories(
		${library_name}
		INTERFACE
		"${${library_name}_SOURCE_DIR}/include"
	)
	
	target_link_libraries(
		${library_name}
		INTERFACE
		"${${library_name}_SOURCE_DIR}/lib/x64/dxcompiler.lib"
	)
	
	add_custom_target(${library_name}_copy_files)

	add_custom_command(
		TARGET ${library_name}_copy_files POST_BUILD
		COMMAND ${CMAKE_COMMAND} -E copy	
				"${${library_name}_SOURCE_DIR}/bin/x64/dxc.exe"
				${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/$<CONFIG>/dxc.exe
				
		COMMAND ${CMAKE_COMMAND} -E copy	
				"${${library_name}_SOURCE_DIR}/bin/x64/dxcompiler.dll"
				${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/$<CONFIG>/dxcompiler.dll
				
		COMMAND ${CMAKE_COMMAND} -E copy	
				"${${library_name}_SOURCE_DIR}/bin/x64/dxil.dll"
				${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/$<CONFIG>/dxil.dll
	)

	add_dependencies(${library_name} 
		${library_name}_copy_files
	)

	set(DXC_PATH "${${library_name}_SOURCE_DIR}/bin/x64/dxc.exe" CACHE INTERNAL "")

	dxc_fetch_shader_version(${DXC_PATH} DXC_SHADER_MODEL)
	dxc_fetch_hlsl_version(${DXC_PATH} DXC_HLSL_VERSION)

	set(DXC_SHADER_MODEL ${DXC_SHADER_MODEL} CACHE INTERNAL "")
	set(DXC_HLSL_VERSION ${DXC_HLSL_VERSION} CACHE INTERNAL "")

	message(STATUS "Selecting DXC shader model '${DXC_SHADER_MODEL}'")
	message(STATUS "Selecting DXC HLSL version '${DXC_HLSL_VERSION}'")

	add_library(fox.cmake::${library_name} ALIAS ${library_name})

endfunction()