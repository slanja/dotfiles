#!/bin/bash

saturation_info=$(vibrant-cli eDP-1)

if [[ "$saturation_info" == *"Saturation of eDP-1 is 0.000000"* ]]; then
    vibrant-cli eDP-1 1
    echo "Switched to vibrant-cli eDP-1 1"
else
    vibrant-cli eDP-1 0
    echo "Switched to vibrant-cli eDP-1 0"
fi