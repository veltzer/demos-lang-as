/*
 * An example of how to write a classic "Hello, World!\n" program in assembly
 * see: https://en.wikibooks.org/wiki/X86_Assembly/Interfacing_with_Linux
 */

#include <asm/unistd.h>
#include <syscall.h>

.section .rodata
hello:
.ascii "Hello, world!\n"

.section .text
.global _start
_start:
## write(1,hello,14)
movq $1, %rax # use the `write` [fast] syscall
movq $1, %rdi # write to stdout
movq $hello, %rsi # use string "Hello World"
movq $14, %rdx # write 14 characters
syscall # make syscall

## _exit(7)
movq $60, %rax # use the `_exit` [fast] syscall
movq $7, %rdi # error code 0
syscall # make syscall
