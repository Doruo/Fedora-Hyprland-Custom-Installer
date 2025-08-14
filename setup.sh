#!/bin/bash
# https://github.com/doruo
# Some ideas and codes are taken from https://github.com/JaKooLit

clear

# Set some colors for output messages
OK="$(tput setaf 2)[OK]$(tput sgr0)"
ERROR="$(tput setaf 1)[ERROR]$(tput sgr0)"
NOTE="$(tput setaf 3)[NOTE]$(tput sgr0)"
INFO="$(tput setaf 4)[INFO]$(tput sgr0)"
WARN="$(tput setaf 1)[WARN]$(tput sgr0)"
CAT="$(tput setaf 6)[ACTION]$(tput sgr0)"
MAGENTA="$(tput setaf 5)"
ORANGE="$(tput setaf 214)"
WARNING="$(tput setaf 1)"
YELLOW="$(tput setaf 3)"
GREEN="$(tput setaf 2)"
BLUE="$(tput setaf 4)"
SKY_BLUE="$(tput setaf 6)"
RESET="$(tput sgr0)"

# Script attributs
DELAY_BEFORE_REBOOT=5

# Path vars
RELATIVE_PATH=$(pwd)
CUSTOM_CONF_PATH="$RELATIVE_PATH/custom-hypr"
CONF_PATH="~/.config/hypr"

# Jakoolit urls
$AUTO_INSTALL_URL="https://raw.githubusercontent.com/JaKooLit/Fedora-Hyprland/main/auto-install.sh"

cd ~

# Bash aliases copy

if [ -f .bashrc ]; then
    truncate -s 0 .bashrc
fi

cat $RELATIVE_PATH/aliases > .bashrc
source .bashrc

# update system
echo "${INFO} Updating Fedora..."
sudo dnf update

# Instal utilities
sudo dnf install whiptail
sudo dnf install curl

whiptail --title "Doruo custom Fedora-Hyprland (2025) Install Script" \
    --msgbox "Welcome to Doruo Fedora-Hyprland (2025) Install Script!\n\n\
Mostly taken from Jakoolit incredible setup: https://github.com/JaKooLit/Fedora-Hyprland"\
    15 80

# Install jakoolit fedora hyprland
cd ~/Fedora-Hyprland
sh <(curl -L $AUTO_INSTALL_URL)

# Ask if the user wants to proceed
if ! whiptail --title "Proceed with custom setup?" \
    --yesno "Would you like to proceed additionnal custom setup?" 7 50; then
    echo -e "\n"
    echo "${INFO} You chose ${YELLOW}NOT${RESET} to proceed. ${YELLOW}Exiting...${RESET}"
    echo -e "\n"
    exit 1
fi

# Ask if the user wants to delete older config
if whiptail --title "Custom Hyprland config." \
    --yesno "Would you like to use custom Hyrpland config ?" 7 50; then
        echo -e "\n"
        echo "${INFO} You chose to use custom Hyrpland config."
        echo -e "\n"

        # Custom scripts
        cp -r $CUSTOM_CONF_PATH/UserScripts $CONF_PATH/UserScripts

        # Custom configs
        cp -r $CUSTOM_CONF_PATH/configs $CONF_PATH/configs

        # Custom rofi themes
        cp -r $CUSTOM_CONF_PATH/configs $CONF_PATH/configs

        # Custom wallpapers
        cp -r $RELATIVE_PATH/wallpapers ~/Pictures/wallpapers
fi        

if whiptail --title "Dev softwares" \
    --yesno "Would you like to install dev softwares ?" 7 50; then
        echo -e "\n"
        echo "${INFO} You chose to install softwares. ${YELLOW}Installing...${RESET}"

        # Git
        sudo dnf install git       
        # Vscode
        sudo dnf install code    
        # Pgadmin4
        sudo dnf install pgadmin4
        # Postman
        sudo dnf install snap
        sudo snap install postman
fi  

if whiptail --title "Dev langages" \
    --yesno "Would you like to install go, python ?" 7 50; then
        echo -e "\n"
        echo "${INFO} You chose to install dev langages (go, python). ${YELLOW}Installing...${RESET}"
        sudo dnf install go    
        sudo dnf install python3
fi    

if whiptail --title "Discord" \
    --yesno "Would you like to install discord ?" 7 50; then
        echo -e "\n"
        echo "${INFO} You chose to install discord. ${YELLOW}Installing...${RESET}"
        sudo dnf install discord 
fi  

# Ask if the user wants to reboot
if whiptail --title "End of Hyprland setup" \
    --yesno "Would you like to reboot?" 7 50; then
    echo -e "\n"
    echo "${INFO} You chose to reboot."
    echo -e "\n"
    echo -e "${INFO} ${YELLOW}Rebooting your computer in $DELAY_BEFORE_REBOOT seconds...${RESET}"
    sleep $DELAY_BEFORE_REBOOT
    reboot
fi

echo -e "\n ${OK} ${GREEN}End of script...${RESET}"
