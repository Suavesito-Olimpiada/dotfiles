#!/usr/bin/env bash

DMENU="$HOME/.config/scripts/lib/dmenu.sh"
Operacion=$(echo | $DMENU -p "Calcular: ")

[[ -n "$Operacion" ]] || exit

Resultado=$(genius --nomixed --maxdigits=0 --precision=2048 --fullexp -e "$Operacion")
Resultado=${Resultado#*] }
Accion=$(printf "%s\n%s" "$Resultado" "Copiar" | $DMENU -i -l 2)
if [ "$Accion" == "Copiar" ]; then
    echo -n "$Resultado" | xclip -i
fi
