#!/usr/bin/env sh
step=20
divider=1.5
file=~/.config/i3/brightness
nightmode=$(( $(cat file) -1))
nightmode=$(echo "$nightmode*($nightmode>=0)" | bc)

red=$(echo "1+($nightmode)/$step/$divider" | bc -l)
brightness=$(echo "1-($nightmode)/$step" | bc -l)

echo $nightmode $red $brightness
xrandr --output DP-0 --brightness $brightness  --gamma $red:1:1 --output DP-1-1 --brightness $brightness --gamma $red:1:1
echo $nightmode > file
