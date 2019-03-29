#!/bin/bash

base_url=http://en.wikipedia.org/wiki
fname='wiki-number'

for x in 1 2 3 4 5 6 7 8 9 10
do
curl "$base_url/$x" > "$fname-$x"
sleep 2
done
