#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""Prepare mreps output for mreps_format_light.py

Usage
    ./mreps_preformat.py mreps_output
"""

# Importing modules
import sys
import re

# Main
if __name__ == '__main__':
    try:
        infile = sys.argv[1]
    except:
        print __doc__
        sys.exit(1)
    with open(infile) as f:
        for line in f:
            if line.startswith("Processing"):
                current = line.strip().replace("Processing sequence ", "").replace("'", "")
            elif "->" in line and "from" not in line:
                print current + " " + line.strip()

