This is example of having basic unit test setup.
It is planned to have 2 branches that shows example with raw Makefiles and Cmake

Commands to build:
cmake: 

Commands to build tests:
cmake: run "make test" inside project directory

Commands to build executables:
cmake: run commands inside project directory: "cmake -S . -B build && cmake --build build && build/src/out" 