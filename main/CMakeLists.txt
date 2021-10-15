add_executable(out main.c)

set(DRV_LIBS 
    intreturner1 
    intreturner2 
    intreturner3
    numreturner1
    numreturner2
    numreturner3
    )

target_link_libraries(out ${DRV_LIBS})