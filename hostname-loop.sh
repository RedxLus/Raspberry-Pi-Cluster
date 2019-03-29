#!/bin/bash

local=/etc/hosts

for x in 1 2 3 4 5 6 7 8 9 10
do
curl "$base_url/$x" > "$fname-$x"
sleep 2
done
