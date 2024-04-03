#!/bin/bash

mkdir -p "$HOME/.icons/"
mkdir -p "$HOME/personal"
mkdir -p "$HOME/work"

ln -srf ./applications/Alacritty.desktop "$HOME/.local/share/applications/Alacritty.desktop"
ln -srf ./applications/Alacritty.png "$HOME/.icons/Alacritty.png"

ln -srf ./configs/alacritty.toml "$HOME/.config/alacritty/alacritty.toml"
ln -srf ./configs/.zshrc "$HOME/.zshrc"
ln -srf ./configs/nvim "$HOME/.config/nvim"
ln -srf ./configs/i3 "$HOME/.config/i3"
ln -srf ./configs/tmux.conf "$HOME/tmux.conf"
ln -srf ./bin "$HOME/.local/bin/scripts"
