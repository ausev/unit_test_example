#include "example.h"
// #include "returnnum1.h"
// #include "returnnum2.h"
// #include "returnnum3.h"
#include "returnint1.h"
#include "returnint2.h"
#include "returnint3.h"
#include <stdio.h>
#include <stdint.h>
#include <stdbool.h>


int main(){
    printf ("Hello World!\n");
    printf ("Average of 10, 20, 30 is %d\n\r", AverageThreeBytes(10,20,30));
    // printf ("numreturner1 returns %d\n\r", numreturner1(1));
    // printf ("numreturner2 returns %d\n\r", numreturner2(2));
    // printf ("numreturner3 returns %d\n\r", numreturner3(3));
    printf ("intreturner1 returns %d\n\r", intreturner1(1));
    printf ("intreturner2 returns %d\n\r", intreturner2(2));
    printf ("intreturner3 returns %d\n\r", intreturner3(3));

    return 0;
}

// gcc main.c example.c -I. -o out