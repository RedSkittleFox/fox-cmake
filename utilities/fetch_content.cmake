include(FetchContent)

macro(FetchContent_Declare_URL_Populate LIBRARY_NAME_M URL)

    if(NOT EXISTS "${FETCHCONTENT_BASE_DIR}/${LIBRARY_NAME_M}-src")
        FetchContent_Declare(
            ${LIBRARY_NAME_M}
            URL ${URL}
        )

        FetchContent_Populate(${LIBRARY_NAME_M})
    else()
        set(${LIBRARY_NAME_M}_SOURCE_DIR "${FETCHCONTENT_BASE_DIR}/${LIBRARY_NAME_M}-src")
    endif()
endmacro()

macro(FetchContent_Declare_URL_MakeAvailable LIBRARY_NAME_M URL)

    if(NOT EXISTS "${FETCHCONTENT_BASE_DIR}/${LIBRARY_NAME_M}-src")
        FetchContent_Declare(
            ${LIBRARY_NAME_M}
            URL ${URL}
        )

        FetchContent_MakeAvailable(${LIBRARY_NAME_M})
    else()
        set(${LIBRARY_NAME_M}_SOURCE_DIR "${FETCHCONTENT_BASE_DIR}/${LIBRARY_NAME_M}-src")
        add_subdirectory("${FETCHCONTENT_BASE_DIR}/${LIBRARY_NAME_M}-src/")
    endif()

endmacro()

macro(FetchContent_Declare_GIT_MakeAvailable LIBRARY_NAME_M URL)

    if(NOT EXISTS "${FETCHCONTENT_BASE_DIR}/${LIBRARY_NAME_M}-src")
        FetchContent_Declare(
            ${LIBRARY_NAME_M}
            GIT_REPOSITORY ${URL}
        )

        FetchContent_MakeAvailable(${LIBRARY_NAME_M})
    else()
        set(${LIBRARY_NAME_M}_SOURCE_DIR "${FETCHCONTENT_BASE_DIR}/${LIBRARY_NAME_M}-src")
        add_subdirectory("${FETCHCONTENT_BASE_DIR}/${LIBRARY_NAME_M}-src/")
    endif()

endmacro()