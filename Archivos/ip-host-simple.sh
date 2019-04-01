#!/bin/bash

echo "Inserte la IP:"
read ip
echo "Inserte el hostname:"
read hostname
echo "$ip      $hostname" >> /etc/hosts
