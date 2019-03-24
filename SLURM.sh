#! /bin/bash

clear
echo "ESTE ES SU NOMBRE DE EQUIPO ACTUAL:"
hostname
echo "¿QUIERE CAMBIARLO?"
echo "1. Si"
echo "2. No"
echo -n "Seleccione una opcion [1 - 2]"
  read seleccion
  case $seleccion in
     1)
        echo "Escriba el nuevo nombre del equipo:"
        read nuevohostname
        hostname
     ;;
     2)
        echo "No cambiado, se mantiene:"
        hostname
     ;;
     *)
        echo "Numero no reconocido."
     ;;
esac
