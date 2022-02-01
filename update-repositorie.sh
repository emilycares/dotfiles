#!/bin/bash

echo Updating the configuration
rm -rf .config/*
mkdir -p .config/i3
mkdir -p .config/awesome
mkdir -p .config/polybar
mkdir -p .config/termite
mkdir -p .config/alacritty
mkdir -p .config/kitty
mkdir -p .config/wezterm
mkdir -p .config/rofi
mkdir -p .config/dunst
mkdir -p .config/glava
mkdir -p .config/nvim/lua
mkdir -p .config/zathura
mkdir -p .config/coc/extensions/node_modules/redhat.java

# desktop
cp ~/.config/i3/config .config/i3/config
cp ~/.config/awesome/rc.lua .config/awesome
cp ~/.config/polybar/launch.sh .config/polybar/launch.sh
cp ~/.config/polybar/config.ini .config/polybar/config.ini
cp ~/.config/polybar/module.ini .config/polybar/module.ini
cp ~/.config/rofi/config.rasi .config/rofi/config.rasi
cp ~/.config/dunst/reload_dunst.sh .config/dunst/

# terminals
cp ~/.config/termite/config .config/termite/config
cp ~/.config/alacritty/alacritty.yml .config/alacritty/alacritty.yml
cp ~/.config/kitty/kitty.conf .config/kitty/kitty.conf
cp ~/.config/wezterm/wezterm.lua .config/wezterm/wezterm.lua

# compton
cp ~/.config/compton.conf .config/
cp ~/.config/glava/change_glava.sh .config/glava/

# nvim
cp ~/.config/nvim/init.vim .config/nvim/
cp -r ~/.config/nvim/lua .config/nvim/

# other apps
cp ~/.config/zathura/zathurarc .config/zathura/zathurarc
cp ~/.ideavimrc .ideavimrc
cp ~/.tmux.conf .tmux.conf
