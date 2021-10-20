This is example project of unit test setup with make + cpputest and cmake + cpputest. Mainly focused to build good example of unit tests

Tags explained:

v3_cmake: Example of test building and executing is implemented here. This example does not contain main Executable. Only tests are build and executed. 


command to build and tests: "cmake -DUNIT_TEST=ON -S . -B build && make -C build all -j$(nproc) --no-print-directory"


ALL COMMANDS SHOULD BE EXECUTED FROM ROOT PROJECT DIR


NOTE: this example works with environment (tested on container) which has cpputest libs build with 32bit option. Also environment variable CPPUTEST_HOME should be equal to cpputest directory, for example /opt/cpputest

