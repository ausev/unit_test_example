cmake_minimum_required(VERSION 3.16)
project(ExampleProject VERSION 1.0.0)

add_subdirectory(src)

# (3) include tests build instructions   
# option(COMPILE_TESTS "Compile the tests" OFF)
# if(COMPILE_TESTS)
#   add_subdirectory(tests)
# endif(COMPILE_TESTS)