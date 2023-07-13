#!/bin/bash

# Get the name fo the fasta input file
FASTA=$1

# Get the name stub of the fasta input file
# The input file MUST have one of the following extensions:
# .fa, .fas, .fasta
NAME=$(echo "$FASTA" | perl -pe 's/\.fa(s)?(ta)?$//')
BASENAME=$(basename "$NAME")
echo "Running mreps_workflow on: $BASENAME".fasta

# Run mreps to extract repeats (**file extension MUST be .fasta**)
echo "   Running mreps"
mreps -res 2 -minperiod 4 -maxperiod 4 -minsize 30 -maxsize 60 -fasta \
    "$NAME".fasta > "$NAME".mreps_01_repeats

# Run mreps_preformat.py to prepare the last step of output formating
echo "   Running mreps_preformat.py"
mreps_preformat.py "$NAME".mreps_01_repeats | \
    perl -pe 's/([ACTG]) ([ACTG])/\1_\2/g; s/\t/ /g; s/://g; \
    s/\->//; s/ +/\t/g; s/\t+/\t/g; \
    s/([ACTG])_([ACTG])/\1 \2/g' > "$NAME".mreps_02_formatted

# Run mreps_format_light.py to create more usable/readable output
echo "   Running mreps_format_light.py"
mreps_format_light.py "$NAME".mreps_02_formatted "$NAME".fasta "$NAME".mreps_03_light

# Run mreps_filter.py
echo "   Running mreps_filter.py"
mreps_filter.py "$NAME".mreps_03_light 0.1 200 "$NAME".mreps_04_filtered.tsv

# Output the number of markers found and the name of the filtered output file
echo -ne "Number of markers: "
grep -vcP "^name\tstart\tend" "$NAME".mreps_04_filtered.tsv
