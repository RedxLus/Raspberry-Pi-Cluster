#!/bin/bash

echo "¿Cuantas Ips y Hostnames tiene el cluster?"
echo "Escribe el numero por ejemplo 3"
echo ""
read FINAL

for x in $(seq 1 $FINAL)
do
echo "Inserte la IP$x:"
read ip
echo "Inserte el hostname$x:"
read hostname
echo "NodeName=$hostname NodeAddr=$ip State=UNKNOWN" >> /etc/slurm-llnl/slurm.conf

sleep 1
done
