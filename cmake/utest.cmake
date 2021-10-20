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


set (test_exe_files
    tests/AllTests.cpp
)


# 1
# make original source libs
get_property(test_source_list GLOBAL PROPERTY test_source_list)
foreach(test_source ${test_source_list})
    get_filename_component(lib_name ${test_source} NAME_WE)
    message(${test_source})
    list(APPEND source_lib_list ${lib_name})
    add_library(${lib_name} ${test_source})
endforeach()
message(${source_lib_list})

# # 2
# # make mock libs
get_property(test_mocks_list GLOBAL PROPERTY test_mocks_list)
foreach(test_mock ${test_mocks_list})
    get_filename_component(lib_name ${test_mock} NAME_WE)
    list(APPEND mock_lib_list ${lib_name})
    add_library(${lib_name} ${test_mock})
endforeach()

# 3
# add includes
get_property(test_include_dir_list GLOBAL PROPERTY test_include_dir_list)
include_directories(${CPPUTEST_INCLUDE_DIRS} ${test_include_dir_list})
link_directories(${CPPUTEST_LIBRARIES})


get_property(test_files_list GLOBAL PROPERTY test_files_list)
foreach(test_file ${test_files_list})
    # 
    get_filename_component(test_exe ${test_file} NAME_WE)
    add_executable(${test_exe} ${test_exe_files} ${test_file})
    set(mock_lib_list_copy ${mock_lib_list})
    string(FIND ${test_exe} ${TEST_FILE_SUFIX} test_file_sufix_index)
    string(SUBSTRING ${test_exe} 0 ${test_file_sufix_index} test_source_to_use)

    string(CONCAT mock_to_remove ${found_str} ${TEST_MOCK_SUFIX})
    list(REMOVE_ITEM mock_lib_list_copy ${mock_to_remove})

    target_link_libraries(${test_exe} ${test_source_to_use} ${mock_lib_list_copy} ${CPPUTEST_LDFLAGS})

    string(CONCAT test_result_file_name ${test_exe} ".txt")
    set(test_result_file ${CMAKE_BINARY_DIR}/${test_result_file_name})

    # clean result file if "make clean" is called
    set_property(
        TARGET ${test_exe}
        APPEND
        PROPERTY ADDITIONAL_CLEAN_FILES ${test_result_file}
)

    add_custom_command(TARGET ${test_exe} POST_BUILD
        WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
        COMMAND /bin/bash -c "echo -e '\\033[1;33m${test_exe} result:\\033[0m' > ${test_result_file}"
        COMMAND /bin/bash -c "${CMAKE_BINARY_DIR}/${test_exe} -c >> ${test_result_file} 2>&1; exit 0"
        COMMAND /bin/bash -c "cat ${test_result_file}"
        COMMAND /bin/bash -c "OK=$(cat -A ${test_result_file} | grep \"\\^\\[\\[32;1mOK\"); if [ -n \"$OK\" ]; then exit 0; else exit 1; fi"
        VERBATIM
    )

endforeach()