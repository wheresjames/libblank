
#====================================================================
# https://github.com/scikit-build/scikit-build-sample-projects
# https://scikit-build.readthedocs.io/en/latest/cmake-modules/PythonExtensions.html

#====================================================================
set(BINARY ${PROJECT_NAME})


#====================================================================
# Must have python

set(NEWPYTHON "NO")
if(${NEWPYTHON})
    find_package (Python3 COMPONENTS Interpreter Development)
    if(NOT Python3_FOUND OR NOT Python3_Development_FOUND)
        message(FATAL_ERROR "Python not found")
    endif()
    set(PYINC ${Python3_INCLUDE_DIRS})
    set(PYLIB ${Python3_LIBRARY_DIRS})
    set(PYMAJOR ${Python3_VERSION_MAJOR})
    set(PYMINOR ${Python3_VERSION_MINOR})
else()
    find_package(PythonExtensions REQUIRED)
    python_extension_module(${BINARY})
    set(PYINC ${PYTHON_INCLUDE_DIR})
    get_filename_component(PYLIB ${PYTHON_LIBRARY} DIRECTORY)
    set(PYMAJOR ${PYTHON_VERSION_MAJOR})
    set(PYMINOR ${PYTHON_VERSION_MINOR})
endif()

include_directories(${PYINC})
link_directories(${PYLIB})

if(NOT ${PYMINOR})
    set(PYINSTALL "lib/python${PYMAJOR}/site-packages")
else()
    set(PYINSTALL "lib/python${PYMAJOR}.${PYMINOR}/site-packages")
endif()


#====================================================================
# Fetch pybind11

include(FetchContent)
FetchContent_Declare(
  pybind11
  GIT_REPOSITORY https://github.com/pybind/pybind11.git
  GIT_TAG        v2.6.2
)
FetchContent_MakeAvailable(pybind11)
include_directories("${pybind11_SOURCE_DIR}/include")


#====================================================================
# Library

include_directories("${CMAKE_CURRENT_SOURCE_DIR}/headers")
file(GLOB_RECURSE SOURCES LIST_DIRECTORIES true "${CMAKE_CURRENT_SOURCE_DIR}/cpp/*.cpp")

add_library(${BINARY} MODULE ${SOURCES})
set_target_properties(${BINARY} PROPERTIES PREFIX "")

#====================================================================
# Install

install(TARGETS ${BINARY} LIBRARY DESTINATION ${PYINSTALL}/${PROJECT_NAME})
install(FILES ${CMAKE_CURRENT_SOURCE_DIR}/py/__init__.py DESTINATION ${PYINSTALL}/${PROJECT_NAME})

