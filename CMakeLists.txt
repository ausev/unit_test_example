cmake_minimum_required(VERSION 3.16)

project(ExampleProject VERSION 1.0.0)

add_library(
    example
    example.c
    example.h
)

add_executable(test main.c example.c)
target_link_libraries(test PRIVATE example)