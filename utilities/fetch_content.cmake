include(FetchContent)

macro(FetchContent_Declare_URL_Populate LIBRARY_NAME URL)

    if(NOT EXISTS "${FETCHCONTENT_BASE_DIR}/${LIBRARY_NAME}-src")
        FetchContent_Declare(
            ${LIBRARY_NAME}
            URL ${URL}
        )

        FetchContent_Populate(${LIBRARY_NAME})
    else()
        set(${LIBRARY_NAME}_SOURCE_DIR "${FETCHCONTENT_BASE_DIR}/${LIBRARY_NAME}-src")
    endif()

endmacro()

macro(FetchContent_Declare_URL_MakeAvailable LIBRARY_NAME URL)

    if(NOT EXISTS "${FETCHCONTENT_BASE_DIR}/${LIBRARY_NAME}-src")
        FetchContent_Declare(
            ${LIBRARY_NAME}
            URL ${URL}
        )

        FetchContent_MakeAvailable(${LIBRARY_NAME})
    else()
        set(${LIBRARY_NAME}_SOURCE_DIR "${FETCHCONTENT_BASE_DIR}/${LIBRARY_NAME}-src")
    endif()

endmacro()