#!/bin/bash

export DISPLAY=:0
export XAUTHORITY=/home/vlad/.Xauthority

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done


HDMIs=$(xrandr | grep HDMI | grep -w connected |wc -l)
VGAs=$(xrandr | grep VGA  | grep -w connected |wc -l)
let "dev = $HDMIs * 10 + $VGAs"

case $dev in
0)
    xrandr --output LVDS-1 --primary
    xrandr --output HDMI-1 --off
    xrandr --output VGA-1  --off
    bspc monitor LVDS-1 -d DEV WEB SYS MEDIA
;;
1)
    xrandr --output VGA-1 --auto --left-of LVDS-1 --primary
    bspc monitor LVDS-1 -d SYS MEDIA
    bspc monitor VGA-1  -d DEV WEB
;;
10)
    xrandr --output HDMI-1 --auto --left-of LVDS-1 --primary
    bspc monitor LVDS-1 -d SYS MEDIA
    bspc monitor HDMI-1  -d DEV WEB
;;
11)
    xrandr --output VGA-1 --auto --left of LVDS-1
    xrandr --output HDMI-1 --auto --left-of VGA-1 --primary
    bspc monitor LVDS-1 -d SYS MEDIA
    bspc monitor VGA-1  -d WEB
    bspc monitor HDMI-1 -d DEV
;;
esac

# launch bars for each monitor
if type "xrandr" >> /dev/null; then
    for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
        MONITOR=$m polybar example &
    done
else
    polybar example &
fi

~/.fehbg &
