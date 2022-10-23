function(dxc_fetch_shader_version DXC_PATH OUT_SHADER_VERSION)
	execute_process(COMMAND ${DXC_PATH} --help OUTPUT_VARIABLE DXC_OUT)
	string(REGEX MATCHALL "ps_([0-9]_[0-9]+)[,][ \t\r\n]+" OUT ${DXC_OUT})
	
	list(GET OUT -1 LAST_ITEM)
	string(REGEX MATCH "([0-9]_[0-9]+)" SHADER_VERSION ${LAST_ITEM})
	set(${OUT_SHADER_VERSION} ${SHADER_VERSION} PARENT_SCOPE)

	if("${SHADER_VERSION}" STREQUAL "")
		message("Failed to detect shader version. Defaulting to '6_0'")
		set(${OUT_SHADER_VERSION} "6_0" PARENT_SCOPE)
	endif()

endfunction()

function(dxc_fetch_hlsl_version DXC_PATH OUT_HLSL_VERSION)
	execute_process(COMMAND ${DXC_PATH} --help OUTPUT_VARIABLE DXC_OUT)
	string(REGEX MATCHALL "HLSL version \\([0-9, ]+\\)" OUT ${DXC_OUT})
	string(REGEX MATCHALL "[0-9][0-9][0-9][0-9]" HLSL_VERSIONS ${OUT})

	list(GET HLSL_VERSIONS -1 LAST_ITEM)
	set(${OUT_HLSL_VERSION} ${LAST_ITEM} PARENT_SCOPE)

	if("${LAST_ITEM}" STREQUAL "")
		message("Failed to detect hlsl version. Defaulting to '2018'")
		set(${OUT_HLSL_VERSION} "2018" PARENT_SCOPE)
	endif()
endfunction()

macro(add_dxc_shader_target PROJECT_NAME SOURCE_LIST SHADER_OUTPUT_PATH)
	set(shader_src ${${SOURCE_LIST}})
	set_source_files_properties(${shader_src} PROPERTIES VS_TOOL_OVERRIDE CustomBuild)

	include(FetchContent)
	FetchContent_MakeAvailable(dxc)

	if("${DXC_PATH}" STREQUAL "")
		message( FATAL_ERROR "DXC_PATH not defined." )
	endif()

	if("${DXC_SHADER_MODEL}" STREQUAL "")
		message( FATAL_ERROR "DXC_SHADER_MODEL not defined." )
	endif()

	if("${DXC_HLSL_VERSION}" STREQUAL "")
		message( FATAL_ERROR "DXC_HLSL_VERSION not defined." )
	endif()

	add_custom_target(
		${PROJECT_NAME} ALL
		SOURCES ${shader_src}
		DEPENDS ${shader_src}
	)

	foreach(FILE ${shader_src})
		# Deduce shader type
		get_filename_component(FILE_WLE ${FILE} NAME_WLE)
		get_filename_component(FILE_SHADER_TYPE ${FILE_WLE} LAST_EXT)
		string(SUBSTRING ${FILE_SHADER_TYPE} 1 -1 FILE_SHADER_TYPE)
	
		if(NOT ${FILE_SHADER_TYPE} MATCHES "ps|vs|gs|hs|ds|cs|lib|ms|as")
			MESSAGE("Unknown extension for shader source '${FILE}'.")
		else()
			# Set file shader type prop		
			set_source_files_properties(${FILE} PROPERTIES ShaderType ${FILE_SHADER_TYPE})
	
			list(APPEND CSO_FILES ${SHADER_OUTPUT_PATH}/${FILE_WLE}.cso)
			add_custom_command(
				OUTPUT ${SHADER_OUTPUT_PATH}/${FILE_WLE}.cso
				COMMAND ${DXC_PATH} 
					/nologo 
					/HV ${DXC_HLSL_VERSION} 
					/E main 
					/T ${FILE_SHADER_TYPE}_${DXC_SHADER_MODEL} 
					$<IF:$<CONFIG:DEBUG>, /Od, /O3> 
					/Zi 
					/Fo ${SHADER_OUTPUT_PATH}/${FILE_WLE}.cso 
					/Fd ${SHADER_OUTPUT_PATH}/${FILE_WLE}.pdb ${FILE}
				MAIN_DEPENDENCY ${FILE}
				COMMENT "HLSL ${FILE}"
				WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
				VERBATIM
			)	
		endif()
	endforeach()
endmacro()