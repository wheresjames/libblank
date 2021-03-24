
#====================================================================

# Output
set(BINARY ${PROJECT_NAME}-test)

include_directories("${CMAKE_SOURCE_DIR}/src/main/headers")

file(GLOB_RECURSE SOURCES LIST_DIRECTORIES true "cpp/*.cpp")

add_executable(${BINARY} ${SOURCES})

target_link_libraries(${BINARY} PRIVATE ${PROJECT_NAME})

if(UNIX)
    target_link_libraries(${BINARY} PRIVATE "-lpthread -lrt")
endif()

enable_testing()
add_test(NAME ${BINARY} COMMAND ${BINARY})
set_tests_properties(${BINARY} PROPERTIES TIMEOUT 10)
add_custom_command(TARGET ${BINARY} POST_BUILD
                   COMMAND ${CMAKE_CTEST_COMMAND} -C $<CONFIG> --output-on-failure --build-target ${BINARY})

install(TARGETS ${BINARY} DESTINATION share/${PROJECT_NAME} COMPONENT test)
