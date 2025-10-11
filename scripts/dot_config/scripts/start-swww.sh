#!/bin/bash

swww-daemon --namespace $1 &
sleep 0.5
swww img --namespace $1 --transition-type center --transition-pos 0,0 --transition-step 90 $2
