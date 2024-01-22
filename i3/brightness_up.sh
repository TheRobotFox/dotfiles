#!/usr/bin/env sh
step=20
divider=1.5
file=~/.config/i3/brightness
nightmode=$(( $(cat file) +1))
nightmode=$(echo "($nightmode>$step)*$step+($nightmode<=$step)*$nightmode" | bc)

red=$(echo "1+($nightmode)/$step/$divider" | bc -l)
brightness=$(echo "1-($nightmode)/$step" | bc -l)

echo $nightmode $red $brightness
xrandr --output DP-2 --brightness $brightness  --gamma $red:1:1 --output DP-1-4 --brightness $brightness --gamma $red:1:1
echo $nightmode > file
