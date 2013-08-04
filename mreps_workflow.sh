#!/bin/bash

# Get the name fo the fasta input file
FASTA=$1

# Get the name stub of the fasta input file
# The input file MUST have one of the following extensions:
# .fa, .fas, .fasta
NAME=$(echo $FASTA | perl -pe 's/\.fa(s)?(ta)?$//')
BASENAME=$(basename $NAME)
echo $BASENAME

# Run mreps to extract repeats (**file extension MUST be .fasta**)
mreps -res 1 -minperiod 2 -maxperiod 4 -minsize 24 -maxsize 80 -fasta \
    $NAME.fasta > $NAME.mreps_repeats

# Run mreps_preformat.py to prepare the last step of output formating
mreps_preformat.py $NAME.mreps_repeats | \
    perl -pe 's/([ACTG]) ([ACTG])/\1_\2/g; s/\t/ /g; s/://g; \
    s/\->//; s/ +/\t/g; s/\t+/\t/g; \
    s/([ACTG])_([ACTG])/\1 \2/g' > $NAME.mreps_formated

# Run mreps_format_light.py to create more usable/readable output
./mreps_format_light.py $NAME.mreps_formated $NAME.fasta $NAME.mreps_final.tsv

# Output the number of markers found and the name of the final output file
echo -ne "Number of markers: "
wc -l $NAME.mreps_final.tsv

