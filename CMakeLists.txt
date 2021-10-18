cmake_minimum_required(VERSION 3.16)
project(ExampleProject VERSION 1.0.0)

SET(CMAKE_CXX_FLAGS  "-m32")
SET(CMAKE_C_FLAGS  "-m32")
SET(CMAKE_EXE_LINKER_FLAGS  "-m32")

# add_subdirectory(src)
# add_subdirectory(main)

# option(COMPILE_TESTS "Compile the tests" OFF)
# if(COMPILE_TESTS)
#   add_subdirectory(tests)
# endif(COMPILE_TESTS)

# (1) Look for installed version of CppUTest
if(DEFINED ENV{CPPUTEST_HOME})
    message(STATUS "Using CppUTest home: $ENV{CPPUTEST_HOME}")
    set(CPPUTEST_INCLUDE_DIRS $ENV{CPPUTEST_HOME}/include)
    set(CPPUTEST_LIBRARIES $ENV{CPPUTEST_HOME}/lib)
    set(CPPUTEST_LDFLAGS CppUTest CppUTestExt)
else()
    find_package(PkgConfig REQUIRED)
    pkg_search_module(CPPUTEST REQUIRED cpputest>=3.8)
    message(STATUS "Found CppUTest version ${CPPUTEST_VERSION}")
endif()

set(Test_files
    tests/intreturn1_test.cpp
    tests/intreturn2_test.cpp
    tests/intreturn3_test.cpp
)

set(Test_src
    src/drv/int1/returnint1.c
    src/drv/int2/returnint2.c
    src/drv/int3/returnint3.c
    src/api/num1/returnnum1.c
    src/api/num2/returnnum2.c
    src/api/num3/returnnum3.c

)

set (TEST_INC
    src/drv/int1/
    src/drv/int2/
    src/drv/int3/
    src/api/num1/
    src/api/num2/
    src/api/num3/
)

set (MOCKS
    tests/Mocks/int1/returnint1_mock.cpp
    tests/Mocks/int2/returnint2_mock.cpp
    tests/Mocks/int3/returnint3_mock.cpp
)


# (2) Our unit tests sources
# set(TEST_APP_NAME example_tests)
# set(TEST_SOURCES
#     AllTests.cpp
# )

# (3) Take care of include directories
include_directories(${CPPUTEST_INCLUDE_DIRS} ${TEST_INC})
link_directories(${CPPUTEST_LIBRARIES})

# (4) Build the unit tests objects and link then with the app library

add_library(intreturner1_mock tests/Mocks/int1/returnint1_mock.cpp)
add_library(intreturner2_mock tests/Mocks/int2/returnint2_mock.cpp)
add_library(intreturner3_mock tests/Mocks/int3/returnint3_mock.cpp)

add_library(numreturner1 src/api/num1/returnnum1.c)
add_library(numreturner2 src/api/num2/returnnum2.c)
add_library(numreturner3 src/api/num3/returnnum3.c)

add_library(intreturner1 src/drv/int1/returnint1.c)
add_library(intreturner2 src/drv/int2/returnint2.c)
add_library(intreturner3 src/drv/int3/returnint3.c)


#  int returner
add_executable(intreturn1_test tests/AllTests.cpp tests/intreturn1_test.cpp)
target_link_libraries(intreturn1_test intreturner1 intreturner2_mock intreturner3_mock ${CPPUTEST_LDFLAGS})

add_executable(intreturn2_test tests/AllTests.cpp tests/intreturn2_test.cpp)
target_link_libraries(intreturn2_test intreturner1_mock intreturner2 intreturner3_mock ${CPPUTEST_LDFLAGS})

add_executable(intreturn3_test tests/AllTests.cpp tests/intreturn3_test.cpp)
target_link_libraries(intreturn3_test intreturner1_mock intreturner2_mock intreturner3 ${CPPUTEST_LDFLAGS})


#  num returner
add_executable(numreturn1_test tests/AllTests.cpp tests/numreturn1_test.cpp)
target_link_libraries(numreturn1_test numreturner1 intreturner1_mock intreturner2_mock intreturner3_mock ${CPPUTEST_LDFLAGS})

add_executable(numreturn2_test tests/AllTests.cpp tests/numreturn2_test.cpp)
target_link_libraries(numreturn2_test numreturner2 intreturner1_mock intreturner2_mock intreturner3_mock ${CPPUTEST_LDFLAGS})

add_executable(numreturn3_test tests/AllTests.cpp tests/numreturn3_test.cpp)
target_link_libraries(numreturn3_test numreturner3 intreturner1_mock intreturner2_mock intreturner3_mock ${CPPUTEST_LDFLAGS})


# add_executable(${TEST_APP_NAME} ${TEST_SOURCES})
# add_executable(${TEST_APP_NAME} ${TEST_SOURCES})
# target_link_libraries(${TEST_APP_NAME} example ${CPPUTEST_LDFLAGS})

# (5) Run the test once the build is done
# add_custom_command(TARGET ${TEST_APP_NAME} COMMAND ./${TEST_APP_NAME} POST_BUILD)