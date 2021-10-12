This is example of having basic unit test setup.
It is planned to have 2 branches that shows example with raw Makefiles and Cmake

Tags explained:

v1_makefile: Basic makefile example is implemented here, Tests as well as executable can be build. Commands:
exe: "make executable"
tests: "make tests"

v0_cmake: Basic cmake example is implemented here, ONLY EXECUTABLE is build and file structure is kept as "all in one place". Commands:
exe: "cmake -S . -B build && cmake --build build && build/out"
tests: NA

v1_cmake: Basic cmake example is implemented here, Tests as well as executable can be build. Test files are separated with src files. Commands:
exe: "cmake -S . -B build && cmake --build build && build/src/out"
tests: "cmake -DCOMPILE_TESTS=ON -S . -B build && cmake --build build && build/tests/example_tests 

ALL COMMANDS SHOULD BE EXECUTED FROM ROOT PROJECT DIR

NOTE: this example works with environment (tested on container) which has cpputest libs build with 32bit option. Also environment variable CPPUTEST_HOME should be equal to cpputest directory, for example /opt/cpputest