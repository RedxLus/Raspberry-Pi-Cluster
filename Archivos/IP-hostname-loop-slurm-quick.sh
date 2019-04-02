#!/bin/bash

archivohosts=/etc/hosts
echo "¿Cuantas Ips y Hostnames quieres añadir al cluster?"
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

echo "NodeName=$hostname00 NodeAddr=$ip00 State=UNKNOWN" >> /etc/slurm-llnl/slurm.conf

sleep 1
done
