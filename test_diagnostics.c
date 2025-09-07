#include <stdio.h>
#include <stdlib.h>

int main() {
    // This will create warnings and errors for testing diagnostics
    int unused_variable;  // Warning: unused variable
    
    printf("Missing semicolon here")  // Error: missing semicolon
    
    int x = undeclared_var;  // Error: undeclared variable
    
    char *ptr;
    *ptr = 'a';  // Warning: use of uninitialized pointer
    
    return 0;
}