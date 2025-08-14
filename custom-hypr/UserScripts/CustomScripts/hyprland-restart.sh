#!/bin/bash
# Sauvegarder la session (optionnel)
hyprctl dispatch exit
sleep 2
# Relancer Hyprland automatiquement
exec Hyprland
