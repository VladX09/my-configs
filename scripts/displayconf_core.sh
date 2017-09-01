#!/bin/bash

HDMIs=$(xrandr | grep HDMI | grep -w connected |wc -l)
VGAs=$(xrandr | grep VGA  | grep -w connected |wc -l)
let "dev = $HDMIs * 10 + $VGAs"

case $dev in
0)
        xrandr --output LVDS-1 --primary
        xrandr --output HDMI-1 --off
        xrandr --output VGA-1  --off
;;
1)
        xrandr --output VGA-1 --auto --left-of LVDS-1 --primary
;;
10)
        xrandr --output HDMI-1 --auto --left-of LVDS-1 --primary
;;
11)
        xrandr --output VGA-1 --auto --left of LVDS-1
        xrandr --output HDMI-1 --auto --left-of VGA-1 --primary
;;
esac

