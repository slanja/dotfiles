#!/usr/bin/env bash

case $(setxkbmap -query | grep layout | awk '{ print $2 }') in
           cz) setxkbmap us && notify-send "Language set to: US";;
           us) setxkbmap cz && notify-send "Langueg set to: CZ";;
            *) setxkbmap us && notify-send "Language set to: English-US";;
esac
