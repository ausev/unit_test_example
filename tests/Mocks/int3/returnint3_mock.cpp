/*
 * This file has been auto-generated by CppUTestMock v0.4.
 *
 * Contents will NOT be preserved if it is regenerated!!!
 */

extern "C" {
#include "returnint3.h"
}

#include <CppUTestExt/MockSupport.h>

int intreturner3(int a)
{
    return mock().actualCall("intreturner3").withIntParameter("a", a).returnIntValue();
}

