#!/bin/bash

local=/etc/hosts

for x in 1 2 3 4 5 6 7 8 9 10
do
echo "Inserte la IP$x:"
read ip0$x
echo "Inserte el hostname$x:"
read hostname0$x
echo "$ip0$x      $hostname0$x" >> $local
sleep 2
done
