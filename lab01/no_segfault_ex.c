#include <stdio.h>
int main() {
    int a[5] = {1, 2, 3, 4, 5};
    unsigned int total = 0;
    printf("%lu\n", sizeof(a));
    for (int j = 0; j < sizeof(a); j++) {
        total += a[j];	// accesses uninitialized memory, undefined behavior
    }
    printf("sum of array is %d\n", total);
}