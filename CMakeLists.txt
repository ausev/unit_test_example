cmake_minimum_required(VERSION 3.16)
project(ExampleProject VERSION 1.0.0)

SET(CMAKE_CXX_FLAGS  "-m32")
SET(CMAKE_C_FLAGS  "-m32")
SET(CMAKE_EXE_LINKER_FLAGS  "-m32")

add_subdirectory(src)

option(COMPILE_TESTS "Compile the tests" OFF)
if(COMPILE_TESTS)
  add_subdirectory(tests)
endif(COMPILE_TESTS)