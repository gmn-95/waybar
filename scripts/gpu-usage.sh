#!/bin/sh

# Mantém a barra utilizável mesmo sem driver NVIDIA carregado.
usage="$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits 2>/dev/null | awk '/^[[:space:]]*[0-9]+([.][0-9]+)?[[:space:]]*$/ { gsub(/[[:space:]]/, ""); print; exit }')"

if [ -n "$usage" ]; then
    printf '󰢮 %s%%\n' "$usage"
else
    printf '󰢮 --\n'
fi
