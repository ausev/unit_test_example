#include "CppUTest/CommandLineTestRunner.h"
#include "CppUTest/TestHarness.h"

TEST_GROUP(BitnessChecker)
{
    void setup()
    {
    }

    void teardown()
    {
    }
};


TEST(BitnessChecker, CheckSizeOfSize_t)
{
    CHECK_EQUAL_TEXT(4,sizeof(size_t),"size_t takes more than 32bit to allocate variables");
}

TEST(BitnessChecker, CheckTestApplicaitionBitness)
{
    CHECK_TEXT((0xFFFFFFFF + 1) == 0,"Test application uses more than 32bit registers");
}

int main(int ac, char** av)
{
    return CommandLineTestRunner::RunAllTests(ac, av);
}

