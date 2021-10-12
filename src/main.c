#include "example.h"
// #include "example_test.h"
#include <stdio.h>
#include <stdint.h>
#include <stdbool.h>


int main(){
    printf ("result is %d\n\r", AverageThreeBytes(10,20,30));
    printf ("Hello World!\n");

    return 0;
}

// gcc main.c example.c -I. -o out