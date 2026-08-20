#!/usr/bin/env python

""" Assemble a .s file with gcc and link it with bare ld (no crt startup),
reproducing the src_no_c build: gcc -c then ld -o. Each argument is a source
file; the .elf lands next to it. """

import os
import subprocess
import sys


def build_one(source):
    """ Assemble and ld-link a single source, return the exit code. """
    obj = os.path.splitext(source)[0] + ".o"
    elf = os.path.splitext(source)[0] + ".elf"
    ret = subprocess.call(["gcc", "-c", source, "-o", obj])
    if ret != 0:
        return ret
    return subprocess.call(["ld", "-o", elf, obj])


def main():
    """ main entry point """
    for source in sys.argv[1:]:
        ret = build_one(source)
        if ret != 0:
            sys.exit(ret)


if __name__ == "__main__":
    main()
