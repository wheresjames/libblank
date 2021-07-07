
#====================================================================
# https://github.com/scikit-build/scikit-build-sample-projects


#====================================================================
include(../python.cmake)
include(../pybind11.cmake)


#====================================================================
set(BINARY ${PROJECT_NAME})


#====================================================================
# Library

include_directories("${CMAKE_CURRENT_SOURCE_DIR}/headers")
file(GLOB_RECURSE SOURCES "${CMAKE_CURRENT_SOURCE_DIR}/cpp/*.cpp")

add_library(${BINARY} MODULE ${SOURCES})
set_target_properties(${BINARY} PROPERTIES PREFIX "")
set_target_properties(${BINARY} PROPERTIES SUFFIX "${PYTHON_MODULE_EXTENSION}")
set_target_properties(${BINARY} PROPERTIES MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>")

add_custom_command(TARGET ${BINARY} POST_BUILD
                    COMMAND ${CMAKE_COMMAND} -E copy
                        "$<TARGET_FILE:${BINARY}>" "${CMAKE_LIBRARY_OUTPUT_DIRECTORY}")


#====================================================================
# Install

install(TARGETS ${BINARY} LIBRARY DESTINATION "${PYINSTALL}/${PROJECT_NAME}")
install(FILES "${CMAKE_CURRENT_SOURCE_DIR}/py/__init__.py" DESTINATION "${PYINSTALL}/${PROJECT_NAME}")

