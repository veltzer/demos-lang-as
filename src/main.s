/*
This is a different way to compile and run assembly code from the minimal.s
example. In this example we do link with the standard C library.
We no longer define the _start symbol, it will be supplied by the C library.
Instead we supply the 'main' symbol and write our code there.
So now we don't need to supply gcc with the -nostdlib flag.

We compile this program with:
	$ gcc [filename.s]
	For an a.out files resulting or:
	$ gcc [filename.s] -o [output_file_name]
	In this case we control the name of the output file.

*/

.global _start
_start:
	# 1 is the number of the _exit(2) system call
	mov $1, %eax
	# 7 is the status we pass to the exit(2) system call
	mov $7, %ebx
	int $0x80
