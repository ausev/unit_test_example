extern "C"
{
#include "returnint3.h"
}

#include "CppUTest/TestHarness.h"

TEST_GROUP(intreturn3)
{
    void setup() {}
    void teardown() {}
};

TEST(intreturn3, intreturner_BasicExample1)
{
  CHECK_EQUAL(3,intreturner3(3));
}

