#!/bin/zsh
IMAGE_DIR="$HOME/d/imgs/.wallpapers/aesthetic-wallpapers/images/"
IMAGES=($(find "$IMAGE_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.bmp" -o -iname "*.gif" \)))
RANDOM_IMAGE="${IMAGES[$RANDOM % ${#IMAGES[@]}]}"
swww img "$RANDOM_IMAGE" --transition-type random


