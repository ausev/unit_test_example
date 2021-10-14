add_library(
    intreturner1 
    drv/int1/returnint1.c 
    # drv/int1/returnint1.h
    )

target_include_directories(intreturner1 PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/drv/int1)