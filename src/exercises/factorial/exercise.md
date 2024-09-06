# x86-64 Assembly Factorial Calculator Exercise

## Objective
Write an x86-64 assembly program for Linux that calculates the factorial of a user-input number.

## Requirements
1. Prompt the user to enter a number between 0 and 20.
2. Read the number from stdin.
3. Calculate the factorial of the input number.
4. Print the result to stdout.
5. The program should work on 64-bit Linux systems.
6. Assume access to the C standard library functions (printf, scanf).

## Expected Behavior
- The program should correctly calculate factorials from 0! to 20!.
- It should handle edge cases like 0! and 1! correctly.
- For inputs larger than 20, the behavior is undefined (due to integer overflow).

## Example Interaction
```
Enter a number (0-20): 5
Factorial of 5 is: 120
```

## Implementation Notes
- Use AT&T syntax for x86-64 assembly.
- Utilize the C standard library for input and output operations.
- Ensure proper stack alignment and function calling conventions for x86-64.

## Compilation and Execution
- Save the assembly code in a file named `factorial.s`.
- Compile using GCC:
  ```
  gcc -o factorial factorial.s
  ```
- Run the program:
  ```
  ./factorial
  ```

## Learning Objectives
- Practice x86-64 assembly programming.
- Understand function calling conventions in assembly.
- Implement a simple algorithm (factorial) in low-level code.
- Interact with the C standard library from assembly.

## Bonus Challenges
1. Implement input validation to ensure the number is within the valid range.
2. Modify the program to use pure system calls instead of C library functions.
3. Optimize the factorial calculation for speed or code size.
