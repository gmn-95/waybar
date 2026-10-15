#!/bin/sh

# Tctl/Tdie atendem AMD; "Package id 0" atende os sensores Intel mais comuns.
temperature="$(sensors 2>/dev/null | awk '/^(Tctl|Tdie|Package id 0):/ { value = $2; gsub(/[+°C]/, "", value); printf "%d", value; exit }')"

if [ -n "$temperature" ]; then
    printf ' %s°C\n' "$temperature"
else
    printf ' --\n'
fi
