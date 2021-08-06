#!/usr/bin/bash

# Use command-line tools to change brightness when Nvidia drivers break Fn + Keyboard shortcuts

CURRBRIGHT=$(xrandr --current --verbose | grep Brightness | awk '{print $2}')
NEWBRIGHT=$CURRBRIGHT

if [ "$1" = "inc" ]; then
   if [ "$(echo "$CURRBRIGHT < 1.0" | bc)" -eq 1  ]; then
      NEWBRIGHT="$(echo "$CURRBRIGHT + 0.1" | bc)"
   fi
elif [ "$1" = "dec" ]; then
   if [ "$(echo "$CURRBRIGHT > 0.0" | bc)" -eq 1 ]; then
      NEWBRIGHT="$(echo "$CURRBRIGHT - 0.1" | bc)"
   fi
fi

xrandr --output DP-2 --brightness "$NEWBRIGHT"
