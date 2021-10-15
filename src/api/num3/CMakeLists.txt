add_library(
    numreturner3
    returnnum3.c
    )

target_link_libraries(numreturner3 intreturner1 intreturner2 intreturner3)
target_include_directories(numreturner3 PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})