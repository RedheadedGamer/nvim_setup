#include <stdio.h>
#include <stdlib.h>

int main() {
    // Error: missing semicolon
    printf("Testing diagnostics")
    
    // Warning: unused variable
    int unused_var = 42;
    
    // Error: undeclared variable
    int result = undeclared_variable;
    
    // Warning: uninitialized pointer usage
    char *ptr;
    *ptr = 'a';
    
    return 0;
}
