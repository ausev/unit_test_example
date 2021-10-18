extern "C"
{
#include "returnnum2.h"
}

#include "CppUTest/TestHarness.h"
#include "CppUTestExt/MockSupport.h"

TEST_GROUP(numreturn2)
{
    void setup() {}
    void teardown() { 
      mock().clear(); 
    }
};

TEST(numreturn2, numreturner_BasicExample1)
{
  mock().expectOneCall("intreturner2")
    .withIntParameter("a", 2)
    .andReturnValue(2);
  CHECK_EQUAL(2,numreturner2(2));
}

