sudo apt update
sudo apt install sxhkd entr

mkdir -p ~/.config/sxhkd/
mkdir -p ~/.config/autostart/

ln -s $(readlink -f ./sxhkdrc) ~/.config/sxhkd/
ln -s $(readlink -f ./sxhkd.desktop) ~/.config/autostart/

