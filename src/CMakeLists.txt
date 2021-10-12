add_library(example example.c)

add_executable(out main.c)

target_link_libraries(out example)