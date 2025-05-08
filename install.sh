#!/bin/zsh
thdir=$(pwd)

for dir in wlogout waybar vesktop fastfetch fuzzel hypr kitty nvim obsidian ; do

    rsync -rp "$thdir/$dir" "$HOME/.config/"
done
for scr in scripts ; do 
    rsync -rp "$thdir/$scr" "$HOME/d/scripts/"
done
