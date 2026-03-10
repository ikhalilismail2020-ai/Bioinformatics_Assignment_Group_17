#!/bin/bash

# Already inside the repository
echo "Starting workflow..."

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

    elif [[ $file == *.cpp ]]; then
        output=$(./program_exec)

    elif [[ $file == *.js ]]; then
        output=$(node "$file")

    else
        continue
    fi

    name=$(echo "$output"     | sed -n '1p')
    email=$(echo "$output"    | sed -n '2p')
    slack=$(echo "$output"    | sed -n '3p')
    interest=$(echo "$output" | sed -n '4p')

    echo "$name,$email,$slack,$interest" >> bioinfo_output.csv

done

echo "✅ CSV file generated: bioinfo_output.csv"
cat bioinfo_output.csv
