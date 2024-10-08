#!/bin/bash

# Define the input files
N1="input/r6_HA_Michigan_2024_sym_INPUT.pdb"
N2="input/r7_HA_Michigan_2024_sym_INPUT.pdb"
N3="input/r8_HA_Michigan_2024_sym_INPUT.pdb"
N4="input/r9_HA_Michigan_2024_sym_INPUT.pdb"
N5="input/r10_HA_Michigan_2024_sym_INPUT.pdb"


# Array of input files
input_files=($N1 $N2 $N3)

# Iterate over each input file
for input_file in "${input_files[@]}"
do
    # Extract the base name (without extension) for the folder name
    base_name=$(basename "$input_file" .pdb)

    # Create a folder named after the base name
    mkdir -p "$base_name"

    # Run the command with the current input file and direct output to the created folder
    docker run -v $(pwd):/home/iwe53/sissi/scripts/step1 -w /home/iwe53/sissi/scripts/step1 rosettacommons/rosetta:ml rosetta_scripts \
        -parser:protocol run_esm_and_save.xml \
        -s "$input_file" \
        -parser:script_vars pssm="$base_name" \
        -ex1 \
        -ex2aro \
        -nstruct 1000 \
        -beta \
        -out:path:all "$base_name" \
        -auto_download

done
