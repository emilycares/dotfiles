#!/bin/bash

echo Updating the configuration
rm -rf .config/*
mkdir -p .config/i3
mkdir -p .config/polybar
mkdir -p .config/termite
mkdir -p .config/alacritty
mkdir -p .config/kitty
mkdir -p .config/rofi
mkdir -p .config/dunst
mkdir -p .config/glava
mkdir -p .config/nvim/lua
mkdir -p .config/zathura
mkdir -p .config/coc/extensions/node_modules/redhat.java

# i3-gaps
cp ~/.config/i3/config .config/i3/config

# polybar
cp ~/.config/polybar/launch.sh .config/polybar/launch.sh
cp ~/.config/polybar/config.ini .config/polybar/config.ini
cp ~/.config/polybar/module.ini .config/polybar/module.ini

# rofi
cp ~/.config/rofi/config.rasi .config/rofi/config.rasi

# dunst
cp ~/.config/dunst/reload_dunst.sh .config/dunst/

# termite
cp ~/.config/termite/config .config/termite/config

# alacritty
cp ~/.config/alacritty/alacritty.yml .config/alacritty/alacritty.yml

# kitty
cp ~/.config/kitty/kitty.conf .config/kitty/kitty.conf

# compton
cp ~/.config/compton.conf .config/
cp ~/.config/glava/change_glava.sh .config/glava/

# nvim
cp ~/.config/nvim/init.vim .config/nvim/
cp ~/.config/nvim/lua/lsp.lua .config/nvim/lua/
cp ~/.config/nvim/lua/syntax.lua .config/nvim/lua/
cp ~/.config/nvim/lua/movement.lua .config/nvim/lua/
cp ~/.config/nvim/lua/statusline.lua .config/nvim/lua/

# zathura
cp ~/.config/zathura/zathurarc .config/zathura/zathurarc

# tmux
cp ~/.tmux.conf .tmux.conf

# ideavim
cp ~/.ideavimrc .ideavimrc
