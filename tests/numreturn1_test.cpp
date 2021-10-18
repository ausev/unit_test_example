extern "C"
{
#include "returnnum1.h"
}

#include "CppUTest/TestHarness.h"
#include "CppUTestExt/MockSupport.h"

TEST_GROUP(numreturn1)
{
    void setup() {}
    void teardown() { 
      mock().clear(); 
    }
};

TEST(numreturn1, numreturner_BasicExample1)
{
  mock().expectOneCall("intreturner1")
    .withIntParameter("a", 1)
    .andReturnValue(1);
  CHECK_EQUAL(1,numreturner1(1));
}

