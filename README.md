This is example of having basic unit test setup.
It is planned to have 2 branches that shows example with raw Makefiles and Cmake

Commands to build tests:
cmake: run "cmake -DCOMPILE_TESTS=ON -S . -B build && cmake --build build && build/tests/example_tests " inside project directory

Commands to build executables:
cmake: run commands inside project directory: "cmake -S . -B build && cmake --build build && build/src/out" 

NOTE: this example works with environment (tested on container) which has cpputest libs build with 32bit option. Also environment variable CPPUTEST_HOME should be equal to cpputest directory, for example /opt/cpputest