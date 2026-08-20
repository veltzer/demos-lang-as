#!/usr/bin/env python

""" Assemble one .s file with gcc and link it with bare ld (no crt startup),
reproducing the src_no_c build: gcc -c then ld -o. The generator invokes this
as asm_link_ld.py <input.s> <output.elf>; the .o goes next to the elf. """

import os
import subprocess
import sys


def main():
    """ main entry point """
    source, elf = sys.argv[1], sys.argv[2]
    obj = os.path.splitext(elf)[0] + ".o"
    os.makedirs(os.path.dirname(elf), exist_ok=True)
    ret = subprocess.call(["gcc", "-c", source, "-o", obj])
    if ret != 0:
        sys.exit(ret)
    sys.exit(subprocess.call(["ld", "-o", elf, obj]))


if __name__ == "__main__":
    main()
