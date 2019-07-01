#!/bin/bash

apt-get install net-tools
laip=$(ifconfig|awk 'NR == 2'|awk '{print $2}'|cut -d ':' -f2)

clear

echo "Su IP es $laip. ¿Es correcta?. Puede modificarla despues en /etc/network/interfaces "
echo "1. Si. No cambiar nada y salir."
echo "2. No. No es mi ip o quiero hacerlo manualmente."
echo -n "Seleccione una opcion [1 - 2]"
read respuesta

if [ $respuesta = 1 ]
then
  echo "Saliendo"
else
  nano /etc/network/interfaces
  /etc/init.d/networking restart
fi
