
#====================================================================

# Output
set(BINARY ${PROJECT_NAME})

# Include
include_directories("${CMAKE_CURRENT_SOURCE_DIR}/headers")

# Source files
file(GLOB_RECURSE SOURCES LIST_DIRECTORIES true "${CMAKE_CURRENT_SOURCE_DIR}/cpp/*.cpp")

add_library(${BINARY} ${SOURCES})

# No prefix
set_target_properties(${BINARY} PROPERTIES PREFIX "")

# Install
install(TARGETS ${BINARY} DESTINATION lib COMPONENT lib)
install(DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/headers/" DESTINATION include COMPONENT lib)
