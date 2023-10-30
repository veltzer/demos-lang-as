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
movl $SYS_write, %eax
movl $1, %ebx
movl $hello, %ecx
movl $14, %edx
int $0x80

## _exit(7)
movl $SYS_exit, %eax
movl $7, %ebx
int $0x80
