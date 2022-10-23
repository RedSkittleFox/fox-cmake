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