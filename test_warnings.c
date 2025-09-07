#include <stdio.h>
#include <stdlib.h>

int main() {
    int unused = 42;        // Warning: unused variable
    char *ptr;              // Warning: uninitialized pointer
    *ptr = 'a';             // Warning: dereferencing uninitialized pointer
    return 0;
}
