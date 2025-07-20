#!/bin/bash

if [[ $# -ne 1 ]]; then
    echo "Usage: roll <NdM> (e.g., 2d6, 1d20)"
    exit 1
fi

input="$1"

if ! [[ "$input" =~ ^([1-9][0-9]*)[dD]([1-9][0-9]*)$ ]]; then
    echo "Format must be NdM, like 2d6 or 1d20. Not your malformed bullshit."
    exit 1
fi

num_dice="${BASH_REMATCH[1]}"
num_sides="${BASH_REMATCH[2]}"

total=0
results=()

for ((i=0; i<num_dice; i++)); do
    roll=$(( RANDOM % num_sides + 1 ))
    results+=("$roll")
    (( total += roll ))
done

echo "Rolled: ${results[*]}  |  Total: $total"
