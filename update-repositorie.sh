#!/bin/bash

echo Updating the configuration
rm -rf .config/*
mkdir -p .config/i3
mkdir -p .config/polybar
mkdir -p .config/termite
mkdir -p .config/rofi
mkdir -p Wallpapers

# i3-gaps
cp ~/.config/i3/config .config/i3/config

# polybar
cp ~/.config/polybar/launch.sh .config/polybar/launch.sh
cp ~/.config/polybar/config.ini .config/polybar/config.ini
cp ~/.config/polybar/module.ini .config/polybar/module.ini

# rofi
cp ~/.config/rofi/config.rasi .config/rofi/config.rasi

# termite
cp ~/.config/termite/config .config/termite/config

# Wallpapers
cp ~/Wallpapers/* Wallpapers/

# compton
cp ~/.config/compton.conf .config/

# See waths charging
git diff
