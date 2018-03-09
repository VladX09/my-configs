DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
XRESOURCES=~/.Xresources
SCRIPTS=~/.local/scripts
LIGHTDM=/etc/lightdm
GTK3_CONFIG=~/.config/gtk-3.0/settings.ini
GTK2_CONFIG=~/.gtkrc-2.0
BSPWM=~/.config/bspwm
SXHKD=~/.config/sxhkd
POLYBAR=~/.config/polybar
AWESOME=/usr/share/fonts/opentype/awesome
COMPTON=~/.config/compton.conf
MPD=~/.config/mpd

ln -s $DIR/.Xresources $XRESOURCES
ln -s $DIR/scripts $SCRIPTS
sudo ln -s $DIR/lightdm $LIGHTDM
ln -s $DIR/settings.ini $GTK3_CONFIG
ln -s $DIR/.gtkrc-2.0 $GTK2_CONFIG
ln -s $DIR/bspwm $BSPWM
ln -s $DIR/sxhkd $SXHKD
ln -s $DIR/polybar $POLYBAR
sudo ln -s $DIR/awesome $AWESOME
ln -s $DIR/compton.conf $COMPTON
ln -s $DIR/mpd $MPD
