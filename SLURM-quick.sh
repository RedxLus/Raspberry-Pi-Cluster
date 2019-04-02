#! /bin/bash

apt install ntpdate -y

## INSTALAR SLURM ##
  apt install slurm-wlm -y

## Configuracion por defecto ##
  cd /etc/slurm-llnl
  cp /usr/share/doc/slurm-client/examples/slurm.conf.simple.gz .
  gzip -d slurm.conf.simple.gz
  mv slurm.conf.simple slurm.conf

## CAMBIAR HOSTNAME ##
wget https://raw.githubusercontent.com/RedxLus/Raspberry-Pi-Cluster/master/Archivos/Nuevo-hostname-propio.sh --no-check-certificate
sh Nuevo-hostname-propio.sh
clear

## ANADIR NUEVAS IPs + HostNames ##
echo "a. Añadir muchas IPs y Hostnames" 
echo "b. Añadir solo 1" 
echo -n "Seleccione una opcion [a - b]"
  read ip_y_hostname
  case $ip_y_hostname in
     a|A)
        wget https://raw.githubusercontent.com/RedxLus/Raspberry-Pi-Cluster/master/Archivos/IP-hostname-loop-slurm-quick.sh --no-check-certificate
        chmod +x IP-hostname-loop-slurm-quick.sh
        sh IP-hostname-loop-slurm-quick.sh
     ;;
     b|B)
        wget https://raw.githubusercontent.com/RedxLus/Raspberry-Pi-Cluster/master/Archivos/ip-host-simple.sh --no-check-certificate
        chmod +x ip-host-simple.sh
        sh ip-host-simple.sh
     ;;
     *)
        echo "Numero no reconocido."
     ;;
  esac

## ¿NODO MAESTRO (CONTROLADOR) O NODO SIMPLE? ##
echo ""
echo "¿Es el nodo MAESTRO o un nodo SIMPLE?"
echo "1. Nodo MAESTRO (Controlador)" 
echo "2. Nodo Simple" 
echo -n "Seleccione una opcion [1 - 2]"
  read maestro_simple_nodos
  case $maestro_simple_nodos in
     1)
     ## SOLO NODO MAESTRO (CONTROLADOR) ##
      apt-get install net-tools
      la_ip=$(ifconfig|awk 'NR == 2'|awk '{print $2}'|cut -d ':' -f2)

      echo "Su IP es $la_ip. ¿Es el nodo maestro?. Puede modificarla despues en /etc/slurm-llnl/slurm.conf "
      echo "1. Si. Quiero añadirla automaticamente para que funcione el Cluster (la IP se añadira al archivo de configuracion)."
      echo "2. No. No es la ip del nodo maestro. Tengo que cambiarla despues en  /etc/slurm-llnl/slurm.conf."
      echo -n "Seleccione una opcion [1 - 2]"
      read respuesta

      if [ $respuesta = 1 ]
      then
      hostname_maestro_este=$(hostname)
      sed -i "s/ControlMachine=laptop/ControlMachine=$hostname_maestro_este/g" /etc/slurm-llnl/slurm.conf
      sed -i "s/#ControlAddr=/ControlAddr=/g" /etc/slurm-llnl/slurm.conf
      sed -i "s/ControlAddr=/ControlAddr=$la_ip/g" /etc/slurm-llnl/slurm.conf
      else
      echo "Saliendo"
      fi
     ;;
     2)
     ## SOLO NODOS SIMPLES ##
     echo ""
     echo "¿cual es la IP del nodo MAESTRO?"
     echo "Inserte:"
     read IP_Nodo_Maestro
     
     echo ""
     echo "¿cual es el hostname del nodo MAESTRO?"
     echo "Inserte:"
     read HOST_Nodo_Maestro

      sed -i "s/ControlMachine=laptop/ControlMachine=$HOST_Nodo_Maestro/g" /etc/slurm-llnl/slurm.conf
      sed -i "s/#ControlAddr=/ControlAddr=/g" /etc/slurm-llnl/slurm.conf
      sed -i "s/ControlAddr=/ControlAddr=$IP_Nodo_Maestro/g" /etc/slurm-llnl/slurm.conf

     ;;
     *)
        echo "Numero no reconocido."
     ;;
  esac

## ÚLTIMO ##
## Borrar ejemplos por defecto ##
sed -i "s/NodeName=server Procs=1 State=UNKNOWN//g" /etc/slurm-llnl/slurm.conf
sed -i "s/PartitionName=debug Nodes=server Default=YES MaxTime=INFINITE State=UP//g" /etc/slurm-llnl/slurm.conf
## Añadir los nuestros ##
echo "Palabra (nombre) para identificar el cluster"
read nombre_cluster
echo "hostname general sin numero"
read hostname
echo "inicio numero"
read INICIO
echo "final numero"
read FINAL
echo "PartitionName=$nombre_cluster Nodes=$hostname[$INICIO-$FINAL] Default=YES MaxTime=INFINITE State=UP" >> /etc/slurm-llnl/slurm.conf
