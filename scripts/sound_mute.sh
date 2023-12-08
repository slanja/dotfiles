#!/bin/bash

if [[ $(pactl get-sink-mute @DEFAULT_SINK@) == *'Mute: yes'* ]]; then
	pactl set-sink-mute `pactl get-default-sink` 0
else
	pactl set-sink-mute `pactl get-default-sink` 1
fi