
#====================================================================
set(TARGET ${PROJECT_NAME}-pytest)
set(BINARY ${CMAKE_BINARY_DIR}/lib/test.py)


#====================================================================
# Must have python
set(NEWPYTHON "NO")
if(${NEWPYTHON})
    find_package (Python3 COMPONENTS Interpreter)
    if(NOT Python3_FOUND)
        message(FATAL_ERROR "Python not found")
    endif()
    set(PYEXE ${Python3_EXECUTABLE})
else()
    find_package(PythonExtensions REQUIRED)
    set(PYEXE ${PYTHON_EXECUTABLE})
endif()


#====================================================================
add_custom_target(${TARGET} ALL
                DEPENDS ${PROJECT_NAME}
                COMMENT "Building ${TARGET}" VERBATIM)

enable_testing()
add_test(NAME ${TARGET}
        WORKING_DIRECTORY ${CMAKE_BINARY_DIR}/lib
        COMMAND ${PYEXE} ${BINARY})

set_tests_properties(${TARGET} PROPERTIES TIMEOUT 10)

# Copy test file
add_custom_command(TARGET ${TARGET} POST_BUILD
                COMMAND ${CMAKE_COMMAND} -E copy "${CMAKE_CURRENT_SOURCE_DIR}/py/test.py" "${BINARY}")

# Execute test
add_custom_command(TARGET ${TARGET} POST_BUILD
                COMMAND ${CMAKE_CTEST_COMMAND} -C $<CONFIG> --output-on-failure --stop-on-failure) # --verbose)

