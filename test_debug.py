#!/usr/bin/env python3

def factorial(n):
    if n <= 1:
        return 1
    return n * factorial(n - 1)

def main():
    numbers = [5, 10, 15, 20]
    
    print("Factorial calculations:")
    for num in numbers:
        result = factorial(num)
        print(f"{num}! = {result}")
    
    # Intentional issue for debugging
    zero_division = 10 / 0  # This will cause an error

if __name__ == "__main__":
    main()
