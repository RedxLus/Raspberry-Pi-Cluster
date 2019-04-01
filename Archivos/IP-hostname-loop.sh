#!/bin/bash

archivohosts=/etc/hosts
echo "¿Cuantas Ips y Hostnames quieres añadir?"
echo "Escribe el numero por ejemplo 3"
echo ""
read FINAL

for x in $(seq 1 $FINAL)
do
echo "Inserte la IP$x:"
read ip00
echo "Inserte el hostname$x:"
read hostname00
echo "$ip00      $hostname00" >> $archivohosts
sleep 2
done

cat $archivohosts
