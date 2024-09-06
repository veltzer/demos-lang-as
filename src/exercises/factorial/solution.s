.section .data
prompt:     .asciz "Enter a number (0-20): "
format_in:  .asciz "%ld"
format_out: .asciz "Factorial of %ld is: %ld\n"
number:     .quad 0
result:     .quad 1  # Initialize to 1 for correct calculation

.section .text
.globl main

main:
    pushq %rbp
    movq %rsp, %rbp

    # Print prompt
    movq $prompt, %rdi
    xorl %eax, %eax
    call printf

    # Read number
    movq $format_in, %rdi
    movq $number, %rsi
    xorl %eax, %eax
    call scanf

    # Calculate factorial
    movq number, %rcx  # Use rcx as loop counter
    movq $1, %rax      # Initialize result to 1

factorial_loop:
    cmpq $1, %rcx      # Compare counter with 1
    jle done           # If counter <= 1, we're done
    imulq %rcx, %rax   # Multiply result by counter
    decq %rcx          # Decrement counter
    jmp factorial_loop # Continue loop

done:
    # Store result
    movq %rax, result

    # Print result
    movq $format_out, %rdi
    movq number, %rsi
    movq result, %rdx
    xorl %eax, %eax
    call printf

    # Exit
    xorl %eax, %eax
    leave
    ret
