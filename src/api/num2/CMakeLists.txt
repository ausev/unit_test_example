add_library(
    numreturner2
    returnnum2.c
    )

target_link_libraries(numreturner2 intreturner2)
target_include_directories(numreturner2 PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})