#!/bin/sh

# A temperatura da GPU vem do mesmo driver NVIDIA usado para a utilização.
temperature="$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits 2>/dev/null | awk '/^[[:space:]]*[0-9]+([.][0-9]+)?[[:space:]]*$/ { gsub(/[[:space:]]/, ""); print; exit }')"

if [ -n "$temperature" ]; then
    printf '󰢮 %s°C\n' "$temperature"
else
    printf '󰢮 --\n'
fi
