include(FetchContent)

function(fetch_make_available_DirectXMath library_name)
	
	FetchContent_Declare(
        ${library_name}
        GIT_REPOSITORY https://github.com/microsoft/DirectXMath.git
        GIT_TAG main
	)

	FetchContent_MakeAvailable(${library_name})
    
    set(LIBRARY_HEADERS
        ${${library_name}_SOURCE_DIR}/Inc/DirectXCollision.h
        ${${library_name}_SOURCE_DIR}/Inc/DirectXCollision.inl
        ${${library_name}_SOURCE_DIR}/Inc/DirectXColors.h
        ${${library_name}_SOURCE_DIR}/Inc/DirectXMath.h
        ${${library_name}_SOURCE_DIR}/Inc/DirectXMathConvert.inl
        ${${library_name}_SOURCE_DIR}/Inc/DirectXMathMatrix.inl
        ${${library_name}_SOURCE_DIR}/Inc/DirectXMathMisc.inl
        ${${library_name}_SOURCE_DIR}/Inc/DirectXMathVector.inl
        ${${library_name}_SOURCE_DIR}/Inc/DirectXPackedVector.h
        ${${library_name}_SOURCE_DIR}/Inc/DirectXPackedVector.inl
        )

    add_library(
	    ${library_name}
	    INTERFACE
	    ${LIBRARY_HEADERS}
	)

    target_include_directories(
		${library_name}
	    INTERFACE
	    "${${library_name}_SOURCE_DIR}/Inc"
	)

    add_library(fox.cmake::${library_name} ALIAS ${library_name})

endfunction()