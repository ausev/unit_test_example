add_library(
    numreturner1 
    returnnum1.c
    )
target_link_libraries(numreturner1 intreturner1)
target_include_directories(numreturner1 PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})
