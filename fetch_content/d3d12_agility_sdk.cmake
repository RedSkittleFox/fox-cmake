include(FetchContent)

function(fetch_make_available_d3d12_agility_sdk library_name)
	
	FetchContent_Declare(${library_name}
       URL https://www.nuget.org/api/v2/package/Microsoft.Direct3D.D3D12/1.706.3-preview
	   )
	
	FetchContent_MakeAvailable(${library_name})
	file(GLOB_RECURSE d3d12-agility-inc "${${library_name}_SOURCE_DIR}/build/native/include/*.h")
	add_library(${library_name} INTERFACE ${d3d12-agility-inc})
	target_include_directories(${library_name} INTERFACE "${${library_name}_SOURCE_DIR}/build/native/include")
	target_link_libraries(${library_name} INTERFACE "d3d12.lib" "dxgi.lib")
	
	add_custom_target(${library_name}_copy_files)

	# Copy DLLS
	add_custom_command(
		TARGET ${library_name}_copy_files POST_BUILD
		COMMAND ${CMAKE_COMMAND} -E copy	
				"${${library_name}_SOURCE_DIR}/build/native/bin/x64/D3D12Core.dll"
				${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/$<CONFIG>/d3d12/D3D12Core.dll
				
		COMMAND ${CMAKE_COMMAND} -E copy	
				"${${library_name}_SOURCE_DIR}/build/native/bin/x64/D3D12Core.pdb"
				${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/$<CONFIG>/d3d12/D3D12Core.pbd
				
		COMMAND ${CMAKE_COMMAND} -E copy	
				"${${library_name}_SOURCE_DIR}/build/native/bin/x64/d3d12SDKLayers.dll"
				${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/$<CONFIG>/d3d12/d3d12SDKLayers.dll
				
		COMMAND ${CMAKE_COMMAND} -E copy	
				"${${library_name}_SOURCE_DIR}/build/native/bin/x64/d3d12SDKLayers.pdb"
				${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/$<CONFIG>/d3d12/d3d12SDKLayers.pbd
		)

	add_dependencies(${library_name} 
		${library_name}_copy_files
	)

endfunction()