HOME=~
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cp $HOME/.xmonad/xmonad.hs $DIR/
cp $HOME/.Xresources $DIR/
cp $HOME/.conkyrc $DIR/ 
cp -r $HOME/.local/scripts/ $DIR/
cp /etc/udev/rules.d/95-myudev.rules $DIR/
