#!/usr/bin/env bash

case $(setxkbmap -query | grep layout | awk '{ print $2 }') in
            us) setxkbmap cz && notify-send "Langueg set to: CZ";;
            cz) setxkbmap us && notify-send "Language set to: US";;
            *) setxkbmap us && notify-send "Language set to: English-US";;
esac