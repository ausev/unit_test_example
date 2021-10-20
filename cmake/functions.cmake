# unit test related functions
macro (utest_add_test_source test_source)
    set_property(GLOBAL APPEND PROPERTY test_source_list ${CMAKE_CURRENT_LIST_DIR}/${test_source})
endmacro()

macro (utest_add_test_file test_file)
    set_property(GLOBAL APPEND PROPERTY test_files_list ${CMAKE_CURRENT_LIST_DIR}/${test_file})
endmacro()

macro (utest_add_test_include_dir include_dir)
    set_property(GLOBAL APPEND PROPERTY test_include_dir_list ${CMAKE_CURRENT_LIST_DIR}/${include_dir})
endmacro()

macro (utest_add_test_mock test_mock)
    set_property(GLOBAL APPEND PROPERTY test_mocks_list ${CMAKE_CURRENT_LIST_DIR}/${test_mock})
endmacro()