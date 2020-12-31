/*
This is the minial assembly program you can write

You can prefix the ".global _start" line with a
".section .text" line but this is superfluous since by
default we are in a text section.

To to compile this program?
$ gcc -nostdlib [file.s]
	This will create an a.out file
$ gcc -nostdlib [file.s] -o [executable_file_name]
	This will allow you to set the name of the newly created executable file.
$ as [file.s] -o [file.o]; ld file.o
	This will create an a.out file
$ as [file.s] -o [file.o]; ld file.o -o [executable_file_name]
	This will allow you to set the name of the newly created executable file.

You cannot compile with gcc just like this:
	$ gcc [file.s] -o [executable_file]
Since gcc links with the standard library which defines the real _start symbol and
and this will create link conflict.

Maybe you can define your own 'main' symbol and manage to do that, I still have
not tyied.

References:
- https://scottc130.medium.com/writing-your-first-x86-program-3fd2b33139d6

*/
.global _start

_start:
	# 1 is the number of the _exit(2) system call
	mov $1, %eax
	# 7 is the status we pass to the exit(2) system call
	mov $7, %ebx
	int $0x80
