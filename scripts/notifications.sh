#!/bin/sh

# O swaync informa "true" quando o modo Não Perturbe está ativo.
if [ "$(timeout 1s swaync-client --get-dnd --skip-wait 2>/dev/null)" = "true" ]; then
    printf '%s\n' '{"text":"","tooltip":"Notificações silenciadas","class":"dnd"}'
else
    printf '%s\n' '{"text":"","tooltip":"Notificações ativas","class":"enabled"}'
fi
