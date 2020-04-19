#!/bin/bash

echo Updating the configuration
rm -rf .config/*
rm -rf Wallpapers
mkdir -p .config/i3
mkdir -p .config/polybar
mkdir -p .config/termite
mkdir -p .config/rofi
mkdir -p .config/dunst
mkdir -p .config/glava
mkdir -p .config/nvim
mkdir -p .config/coc/extensions/node_modules/redhat.java
mkdir -p Wallpapers

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

# Wallpapers
cp ~/Wallpapers/* Wallpapers/

# compton
cp ~/.config/compton.conf .config/
cp ~/.config/glava/change_glava.sh .config/glava/

# nvim
cp ~/.config/nvim/init.vim .config/nvim/
cp ~/.config/nvim/coc-settings.json .config/nvim/
cp ~/.config/coc/extensions/node_modules/redhat.java/eclipse-formatter.xml .config/coc/extensions/node_modules/redhat.java/eclipse-formatter.xml

# tmux
cp ~/.tmux.conf .config/.tmux.conf
