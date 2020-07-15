#include <stdio.h>
#include "bit_ops.h"

// Return the nth bit of x.
// Assume 0 <= n <= 31
unsigned get_bit(unsigned x,
                 unsigned n) {
    return (x << (31 - n)) >> 31;
}
// Set the nth bit of the value of x to v.
// Assume 0 <= n <= 31, and v is 0 or 1
void set_bit(unsigned * x,
             unsigned n,
             unsigned v) {
    if (v) {    // if v == 1, we can use | 
        *x = (*x) | (v << n);
    }
    else {  // if v == 0, negate v and x, use | and negate x again. 
        *x = ~(~(*x) | (1 << n));
    }
}
// Flip the nth bit of the value of x.
// Assume 0 <= n <= 31
void flip_bit(unsigned * x,
              unsigned n) {
    unsigned bit = ((~get_bit(*x, n)) << 31) >> 31;
    set_bit(x, n, bit);
}

