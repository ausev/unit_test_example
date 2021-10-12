extern "C"
{
#include "example.h"
}

#include "CppUTest/TestHarness.h"

TEST_GROUP(example)
{
    void setup() {}
    void teardown() {}
};

TEST(unit_test_example, intreturner_BasicExample1)
{
  CHECK_EQUAL(2,AverageThreeBytes(1,2,3));
}

