mkdir -p $HOME/.icons/

ln -srf ./applications/Alacritty.desktop $HOME/.local/share/applications/Alacritty.desktop
ln -srf ./applications/Alacritty.png $HOME/.icons/Alacritty.png

ln -srf ./configs/alacritty.toml $HOME/.config/alacritty/alacritty.toml
ln -srf ./configs/.zshrc $HOME/.zshrc
ln -srf ./configs/nvim $HOME/.config/nvim
