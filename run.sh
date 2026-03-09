#!/bin/bash

# Repository link
https://github.com/ikhalilismail2020-ai/Bioinformatics_Assignment_Group_17

# Clone repository
git clone $REPO_URL

# Enter repository folder
REPO_NAME=$(basename "$REPO_URL" .git)
cd $REPO_NAME

# Create CSV file with header
echo "Name,Email,Slack Username,Area of Interest" > bioinfo_output.csv

# Compile C++ files if present
for file in *.cpp
do
    if [ -f "$file" ]; then
        g++ "$file" -o program_exec
    fi
done

# Loop through scripts
for file in *
do

    if [[ $file == *.py ]]; then
        output=$(python3 "$file")

    elif [[ $file == *.R ]]; then
        output=$(Rscript "$file")

    elif [[ $file == *.cpp ]]; then
        output=$(./program_exec)

    else
        continue
    fi

    name=$(echo "$output" | sed -n '1p')
    email=$(echo "$output" | sed -n '2p')
    slack=$(echo "$output" | sed -n '3p')
    interest=$(echo "$output" | sed -n '4p')

    echo "$name,$email,$slack,$interest" >> bioinfo_output.csv

done

echo "CSV file generated: bioinfo_output.csv"
