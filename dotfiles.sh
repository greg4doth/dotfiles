#!/bin/zsh
conf=$HOME/.config
for dir in wlogout waybar  fastfetch fuzzel hypr kitty nvim  ; do
    rsync -rp "$conf/$dir" /home/nekochem/d/github/dotfiles
done
rsync -rp "$HOME/scripts/" /$HOME/d/github/dotfiles
