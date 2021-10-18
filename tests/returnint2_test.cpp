extern "C"
{
#include "returnint2.h"
}

#include "CppUTest/TestHarness.h"

TEST_GROUP(intreturn2)
{
    void setup() {}
    void teardown() {}
};

TEST(intreturn2, intreturner_BasicExample1)
{
  CHECK_EQUAL(2,intreturner2(2));
}

