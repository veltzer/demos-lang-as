/*
 * this is an example of doing the exit system call in assembly...
 * you can see this is running ok if you use 'echo $?' after the run
 * and see the return code coming up ok...
 */

#include <asm/unistd.h>
#include <syscall.h>

.text
.global _start
_start:
## _exit(7)
movq $60, %rax # use the `_exit` [fast] syscall
movq $7, %rdi # error code 0
syscall # make syscall
