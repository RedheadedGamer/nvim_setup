#include <stdio.h>
#include <stdlib.h>

int main() {
    int *ptr = malloc(sizeof(int) * 10);
    
    // Intentional issues for debugging demo
    for(int i = 0; i <= 10; i++) {  // Buffer overflow
        ptr[i] = i * 2;
    }
    
    printf("Debug test program\n");
    printf("Pointer value: %p\n", (void*)ptr);
    
    // Memory leak - not freeing ptr
    return 0;
}
