#!/bin/bash

# getting battery capacity
capacity=$(cat "/sys/class/power_supply/BAT1/capacity")

# checking battery capacity
if ((capacity >= 50)); then
  color="#27ae60";
elif ((capacity >= 20)); then
  color="#f39c12";
else
  color="#c0392b";
fi

# replacing color of battery variable
sed -i "1s/.*/\$battery: $color;/g" "/home/slanja/.config/eww/bar/eww.scss"