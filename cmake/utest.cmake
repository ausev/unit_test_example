#sufixes, that must be added to test file and mock
Set(TEST_FILE_SUFIX "_test")
Set(TEST_MOCK_SUFIX "_mock")

# flags taht are necessary to build 32 bit exe
SET(CMAKE_CXX_FLAGS  "-m32")
SET(CMAKE_C_FLAGS  "-m32")
SET(CMAKE_EXE_LINKER_FLAGS  "-m32")

#gather cpputest required variables
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

#list witch holds test files and will be included in every test executable
set (test_exe_files
    tests/AllTests.cpp
)

# 1
# make original source libs
# here library is added for every test source and list with all names are created
get_property(test_source_list GLOBAL PROPERTY test_source_list)
foreach(test_source ${test_source_list})
    get_filename_component(lib_name ${test_source} NAME_WE)
    message(${test_source})
    list(APPEND source_lib_list ${lib_name})
    add_library(${lib_name} ${test_source})
endforeach()

# # 2
# # make mock libs
# here library is created for every mock and list with all of their names are created
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

# 4, 5
# creation of test executables, executing them and displaying results
# here test executables are created, by taking copy of mock lib list (which is created in step 3)
# and replacing X source mock with test source lib f.e.:
# if mock list is : X_mock; Y_mock; Z_mock and test file is X_test, than copy of mock list is changed to: X; Y_mock; Z_mock
# after each linkage of executable, it is launched, its stdout and stderr (in case of test failure) is storred in file and
# and file contents are displayed for user.
get_property(test_files_list GLOBAL PROPERTY test_files_list)
foreach(test_file ${test_files_list})
    # 4
    # extracting test file name without extension to test_exe variable
    get_filename_component(test_exe ${test_file} NAME_WE)
    # creating executable
    add_executable(${test_exe} ${test_exe_files} ${test_file})
    # creating mock lib copy for further manipulation
    set(mock_lib_list_copy ${mock_lib_list})
    # in following 2 actions TEST_FILE_SUFIX is removed from test file name and stored to test_source_to_use variable
    string(FIND ${test_exe} ${TEST_FILE_SUFIX} test_file_sufix_index)
    string(SUBSTRING ${test_exe} 0 ${test_file_sufix_index} test_source_to_use)
    # creating mock lib name which will have to be removed from mock lib copy
    string(CONCAT mock_to_remove ${found_str} ${TEST_MOCK_SUFIX})
    # removing mock lib from mock lib list
    list(REMOVE_ITEM mock_lib_list_copy ${mock_to_remove})
    # linking libs to executable
    target_link_libraries(${test_exe} ${test_source_to_use} ${mock_lib_list_copy} ${CPPUTEST_LDFLAGS})

    # 5
    # creating test result file to hold test output
    string(CONCAT test_result_file_name ${test_exe} ".txt")
    set(test_result_file ${CMAKE_BINARY_DIR}/${test_result_file_name})
    # making sure, that result file is removed if "make clean" is called
    set_property(
        TARGET ${test_exe}
        APPEND
        PROPERTY ADDITIONAL_CLEAN_FILES ${test_result_file}
)
    # adding command to execute test after it is build
    add_custom_command(TARGET ${test_exe} POST_BUILD
        WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
        # prepend test name to result file
        COMMAND /bin/bash -c "echo -e '\\033[1;33m${test_exe} result:\\033[0m' > ${test_result_file}"
        # append test result to result file
        COMMAND /bin/bash -c "${CMAKE_BINARY_DIR}/${test_exe} -c >> ${test_result_file} 2>&1; exit 0"
        # print result file contents
        COMMAND /bin/bash -c "cat ${test_result_file}"
        # if test failed and test result contains error log, exit command with error, so that every "make all" would print error message
        COMMAND /bin/bash -c "OK=$(cat -A ${test_result_file} | grep \"\\^\\[\\[32;1mOK\"); if [ -n \"$OK\" ]; then exit 0; else exit 1; fi"
        VERBATIM
    )

endforeach()