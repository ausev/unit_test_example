cmake_minimum_required(VERSION 3.16)
project(ExampleProject VERSION 1.0.0)

set (MOCKS
    tests/Mocks/int1/returnint1_mock.cpp
    tests/Mocks/int2/returnint2_mock.cpp
    tests/Mocks/int3/returnint3_mock.cpp
)

set (Test_list
    "Hello"
    "World"
)
set (Test_list2
    ${Test_list}
    "!"
)

set(wrld "wor" "ld")
string(CONCAT wrld_str ${wrld})

list(REMOVE_ITEM Test_list ${wrld_str})
# get_filename_component(FileName tests/Mocks/int1/returnint1_mock.cpp NAME_WE)
message("Hello world!")
# message(${len2})
# message(${Test_list})
message(${Test_list})
message(${wrld_str})
# message(${FileName})

string(FIND "numreturn1_test" "_test" str_index)
string(SUBSTRING "numreturn1_test" 0 ${str_index} found_str)
message(${found_str})

