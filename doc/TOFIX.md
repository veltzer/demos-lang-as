# TOFIX

Findings from a code scan on 2026-10-04.

## Medium

- `src/examples/using_puts.s:3` - `main` calls `puts` without realigning the stack (on entry `%rsp` is 8 mod 16, so the `call` at line 5 violates the SysV 16-byte alignment rule that `src/exercises/factorial/exercise.md:34` itself teaches); add `push %rbp`/`pop %rbp` (or `sub $8, %rsp`/`add $8, %rsp`) around the call. Also drop the redundant `\0` in `.asciz "Hello, World!\0"` at line 8 (the comment already says `.asciz` appends the zero).
- `src_32/exit.S:7` - the `#include <asm/unistd.h>`/`<syscall.h>` lines are commented out, so `$SYS_exit` at line 14 is undefined and the file cannot assemble; `src_32/` is also not built at all (`rsconstruct.toml` comment: "src_32 ... is not built"). Either restore the includes and add a `cc_single_file` instance with `-m32` (and the needed multilib), or delete `src_32/`.
- `rsconstruct.toml:42` - `[processor.ruff]`/`[processor.mypy]` list `src` and `config` in `src_dirs`, but those hold only assembly/markdown and Lua; the only Python is `scripts/asm_link_ld.py`. Narrow both to `["scripts"]`.

## Low

- `src_64/exit.S:15` - comment says "error code 0" but the code passes 7; same at `src_64/hello_world.S:25`.
- `src_no_c/exit.s:2` - typos "minial" (line 2) and "To to compile" (line 8); and the program uses the 32-bit `int $0x80` ABI (lines 34-37) in a 64-bit build without saying so, unlike `src_no_c/hello_world.s` which uses `syscall`; note it or switch to `mov $60, %rax`/`syscall`.
- `config/project.lua:4` - keyword typos "assmembly", "assmembler".
