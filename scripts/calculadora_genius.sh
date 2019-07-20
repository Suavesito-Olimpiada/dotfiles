#!/bin/bash
Operacion=`echo|dmenu -p Calcular: `
Resultado=`genius --nomixed --maxdigits=0 --precision=2048 --fullexp -e "$Operacion"`
Resultado=${Resultado#*] }
Accion=`printf "$Resultado \nCopiar" |dmenu -i -l 2`
if [ "$Accion" == "Copiar" ]; then
    echo -n "$Resultado" | xsel -b
fi
