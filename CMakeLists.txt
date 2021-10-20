cmake_minimum_required(VERSION 3.16)
project(ExampleProject VERSION 1.0.0)

include(${CMAKE_CURRENT_LIST_DIR}/cmake/functions.cmake)

add_subdirectory(src)
add_subdirectory(tests)
add_subdirectory(mocks)

option(UNIT_TEST "Compile and run unit tests" OFF)
if(UNIT_TEST)
    include(${CMAKE_CURRENT_LIST_DIR}/cmake/utest.cmake)
endif(UNIT_TEST)

