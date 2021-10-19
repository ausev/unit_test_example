extern "C"
{
#include "returnint1.h"
}

#include "CppUTest/TestHarness.h"

TEST_GROUP(intreturn1)
{
    void setup() {}
    void teardown() {}
};

TEST(intreturn1, intreturner_BasicExample1)
{
  CHECK_EQUAL(1,intreturner1(1));

}

