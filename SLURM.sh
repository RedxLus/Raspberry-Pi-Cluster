#! /bin/bash

apt install ntpdate -y

## CAMBIAR HOSTNAME ##
wget https://raw.githubusercontent.com/RedxLus/Raspberry-Pi-Cluster/master/Archivos/Nuevo-hostname-propio.sh --no-check-certificate
sh Nuevo-hostname-propio.sh

## ANADIR NUEVAS IPs + HostNames ##
echo "a. Añadir muchas IPs y Hostnames" 
echo "b. Añadir solo 1" 
echo -n "Seleccione una opcion [a - b]"
  read ip_y_hostname
  case $ip_y_hostname in
     a|A)
        wget https://raw.githubusercontent.com/RedxLus/Raspberry-Pi-Cluster/master/Archivos/IP-hostname-loop.sh --no-check-certificate
        chmod +x IP-hostname-loop.sh
        sh IP-hostname-loop.sh
     ;;
     b|B)
        wget https://raw.githubusercontent.com/RedxLus/Raspberry-Pi-Cluster/master/Archivos/ips-hosts.sh --no-check-certificate
        chmod +x ips-hosts.sh
        sh ips-hosts.sh
     ;;
     *)
        echo "Numero no reconocido."
     ;;
  esac

## INSTALAR SLURM ##
apt install slurm-wlm -y

## Configuracion por defecto ##
cd /etc/slurm-llnl
cp /usr/share/doc/slurm-client/examples/slurm.conf.simple.gz .
gzip -d slurm.conf.simple.gz
mv slurm.conf.simple slurm.conf

## SOLO NODO MAESTRO (CONTROLADOR) ##
apt-get install net-tools
la_ip=$(ifconfig|awk 'NR == 2'|awk '{print $2}'|cut -d ':' -f2)

clear
echo "SOLO LA IP DEL NODO MAESTRO (CONTROLADOR)"
echo ""
echo "Su IP es $la_ip. ¿Es el nodo maestro?. Puede modificarla despues en /etc/slurm-llnl/slurm.conf "
echo "1. Si. Quiero añadirla automaticamente para que funcione el Cluster (la IP se añadira al archivo de configuracion)."
echo "2. No. No es la ip del nodo maestro. Tengo que cambiarla despues en  /etc/slurm-llnl/slurm.conf."
echo -n "Seleccione una opcion [1 - 2]"
read respuesta

if [ $respuesta = 1 ]
then
sed -i "s/ControlMachine=laptop/ControlMachine=$HOSTNAME/g" /etc/slurm-llnl/slurm.conf
sed -i "s/#ControlAddr=/ControlAddr=/g" /etc/slurm-llnl/slurm.conf
sed -i "s/ControlAddr=/ControlAddr=$la_ip/g" /etc/slurm-llnl/slurm.conf
else
echo "Saliendo"
fi
