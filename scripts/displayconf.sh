#!/bin/bash

export DISPLAY=:0
export XAUTHORITY=/home/vlad/.Xauthority
/home/vlad/.local/scripts/displayconf_core.sh
pkill dzen2
xmonad --restart
