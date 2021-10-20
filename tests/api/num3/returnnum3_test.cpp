extern "C"
{
#include "returnnum3.h"
}

#include "CppUTest/TestHarness.h"
#include "CppUTestExt/MockSupport.h"

TEST_GROUP(numreturn3)
{
    void setup() {}
    void teardown() { 
      mock().clear(); 
    }
};

TEST(numreturn3, numreturner_BasicExample1)
{
  mock().expectOneCall("intreturner3")
    .withIntParameter("a", 3)
    .andReturnValue(3);
  CHECK_EQUAL(3,numreturner3(3));
}

