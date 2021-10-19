# utest_add_test_source()
# utest_add_test_file()
# utest_add_test_mock()
# utest_add_test_include_dir()

SET(CMAKE_CXX_FLAGS  "-m32")
SET(CMAKE_C_FLAGS  "-m32")
SET(CMAKE_EXE_LINKER_FLAGS  "-m32")

Set(TEST_FILE_SUFIX "_test")
Set(TEST_MOCK_SUFIX "_mock")

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

set(test_files_list
    # tests/returnint1_test.cpp
    # tests/returnint2_test.cpp
    # tests/returnint3_test.cpp
    # tests/returnnum1_test.cpp
    # tests/returnnum2_test.cpp
    # tests/returnnum3_test.cpp
)

set(test_source_list
    # src/drv/int1/returnint1.c
    # src/drv/int2/returnint2.c
    # src/drv/int3/returnint3.c
    # src/api/num1/returnnum1.c
    # src/api/num2/returnnum2.c
    # src/api/num3/returnnum3.c

)

set (test_include_dir_list
    # src/drv/int1/
    # src/drv/int2/
    # src/drv/int3/
    # src/api/num1/
    # src/api/num2/
    # src/api/num3/
)

set (test_mocks_list
    # tests/Mocks/int1/returnint1_mock.cpp
    # tests/Mocks/int2/returnint2_mock.cpp
    # tests/Mocks/int3/returnint3_mock.cpp
)

set (test_exe_files
    tests/AllTests.cpp
)

macro (utest_add_test_source test_source)
    list(APPEND test_source_list ${CMAKE_CURRENT_SOURCE_DIR}/${test_source})
endmacro()

macro (utest_add_test_file test_file)
    list(APPEND test_files_list ${CMAKE_CURRENT_SOURCE_DIR}/${test_file})
endmacro()

macro (utest_add_test_include_dir include_dir)
    list(APPEND test_include_dir_list ${CMAKE_CURRENT_SOURCE_DIR}/${include_dir})
endmacro()

macro (utest_add_test_mock test_mock)
    list(APPEND test_mocks_list ${CMAKE_CURRENT_SOURCE_DIR}/${test_mock})
endmacro()


# 1
# make original source libs
set(source_lib_list)
foreach(test_source ${test_source_list})
    get_filename_component(lib_name ${test_source} NAME_WE)
    list(APPEND source_lib_list ${lib_name})
    add_library(${lib_name} ${test_source})
endforeach()

# 2
# make mock libs
set(mock_lib_list)
foreach(test_mock ${test_mocks_list})
    get_filename_component(lib_name ${test_mock} NAME_WE)
    list(APPEND mock_lib_list ${lib_name})
    add_library(${lib_name} ${test_mock})
endforeach()

# 3
# add executables
set(TEST_RESULT_LIST)

# add_test(NAME mytest1 COMMAND ${CMAKE_CURRENT_SOURCE_DIR}/build/${test_exe} -c)

foreach(test_file ${test_files_list})
    # 
    get_filename_component(test_exe ${test_file} NAME_WE)
    add_executable(${test_exe} ${test_exe_files} ${test_file})
    # list(APPEND test_exe_LIST ${test_exe})
    set(mock_lib_list_copy ${mock_lib_list})
    string(FIND ${test_exe} ${TEST_FILE_SUFIX} test_file_sufix_index)
    string(SUBSTRING ${test_exe} 0 ${test_file_sufix_index} test_source_to_use)

    string(CONCAT mock_to_remove ${found_str} ${TEST_MOCK_SUFIX})
    list(REMOVE_ITEM mock_lib_list_copy ${mock_to_remove})

    target_link_libraries(${test_exe} ${test_source_to_use} ${mock_lib_list_copy} ${CPPUTEST_LDFLAGS})

    # string(CONCAT test_result_name ${test_exe} ".txt")
    # list(APPEND TEST_RESULT_LIST ${CMAKE_CURRENT_SOURCE_DIR}/build/${test_result_name})

    add_custom_command(TARGET ${test_exe} POST_BUILD
        WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/build
        COMMAND ${test_exe} -c
        # COMMAND /bin/bash -c "${CMAKE_CURRENT_SOURCE_DIR}/build/${test_exe} -c > ${CMAKE_CURRENT_SOURCE_DIR}/build/${test_result_name} 2>&1; exit 0"
        # COMMAND ${test_exe} -c | tee --output-error=exit ${test_result_name}
        # COMMAND ${test_exe} -c | tee ${test_result_name}
        # COMMAND echo "${test_exe} result" >> ${test_result_name}
        # COMMAND /bin/bash -c "${CMAKE_CURRENT_SOURCE_DIR}/build/${test_exe} -c | tee /dev/null"
        # COMMAND /bin/bash -c "/bin/cat ${CMAKE_CURRENT_SOURCE_DIR}/build/${test_result_name}"
        VERBATIM
    )
endforeach()