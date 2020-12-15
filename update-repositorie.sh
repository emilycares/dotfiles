#!/bin/bash

echo Updating the configuration
rm -rf .config/*
mkdir -p .config/i3
mkdir -p .config/polybar
mkdir -p .config/termite
mkdir -p .config/alacritty
mkdir -p .config/rofi
mkdir -p .config/dunst
mkdir -p .config/glava
mkdir -p .config/nvim
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

# compton
cp ~/.config/compton.conf .config/
cp ~/.config/glava/change_glava.sh .config/glava/

# nvim
cp ~/.config/nvim/init.vim .config/nvim/
cp ~/.config/nvim/coc-settings.json .config/nvim/
cp ~/.config/coc/extensions/node_modules/redhat.java/eclipse-formatter.xml .config/coc/extensions/node_modules/redhat.java/eclipse-formatter.xml
cp -r ~/.config/nvim/ftplugin .config/nvim

# tmux
cp ~/.tmux.conf .tmux.conf

# zathura
cp ~/.config/zathura/zathurarc .config/zathura/zathurarc
