#! /bin/bash

apt install ntpdate -y

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

apt install slurm-wlm -y
cd /etc/slurm-llnl
cp /usr/share/doc/slurm-client/examples/slurm.conf.simple.gz .
gzip -d slurm.conf.simple.gz
mv slurm.conf.simple slurm.conf
