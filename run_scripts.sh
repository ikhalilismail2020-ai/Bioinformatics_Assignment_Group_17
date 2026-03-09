#!/bin/bash

echo "Name,Email,Slack Username,Area of Interest" > output.csv

for file in *.py *.R *.pl *.js
do
    if [ -f "$file" ]; then
        output=$(python3 $file 2>/dev/null || Rscript $file 2>/dev/null || perl $file 2>/dev/null || node $file 2>/dev/null)
        name=$(echo "$output" | sed -n 1p)
        email=$(echo "$output" | sed -n 2p)
        slack=$(echo "$output" | sed -n 3p)
        interest=$(echo "$output" | sed -n 4p)

        echo "$name,$email,$slack,$interest" >> output.csv
    fi
done
