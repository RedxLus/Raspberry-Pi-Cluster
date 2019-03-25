#!/bin/bash

echo"Inserte la IP1:"
read ip01
echo"Inserte el hostname1:"
read hostname01
echo "$ip01      $hostname01" >> /etc/hosts

echo"Inserte la IP2:"
read ip02
echo"Inserte el hostname2:"
read hostname02
echo "$ip02      $hostname02" >> /etc/hosts

echo"Inserte la IP3:"
read ip03
echo"Inserte el hostname3:"
read hostname03
echo "$ip03      $hostname03" >> /etc/hosts
