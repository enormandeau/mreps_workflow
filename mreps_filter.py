#!/usr/bin/env python3
"""Filter results of mreps_format_light.py

Usage:
    <program> input_file max_error min_flank output_file
"""

# Modules
import sys

# Parse user input
try:
    input_file = sys.argv[1]
    max_error = float(sys.argv[2])
    min_flank = int(sys.argv[3])
    output_file = sys.argv[4]
except:
    print(__doc__)
    sys.exit(1)

# Filter
with open(input_file, "rt") as infile:
    with open(output_file, "wt") as outfile:

        for line in infile:
            if line.startswith("name\tstart\tend"):
                outfile.write(line)

            else:
                l = line.strip().split("\t")

                if float(l[8]) > max_error:
                    continue

                if min([int(l[1]), int(l[4])]) < min_flank:
                    continue

                # Replace spaces by - in repeat
                l[9] = l[9].replace(" ", "-")

                # Limit sequence to repeat plus flanks
                l[10] = l[10][int(l[1]) - min_flank: int(l[2]) + min_flank]
                
                outfile.write("\t".join(l) + "\n")
