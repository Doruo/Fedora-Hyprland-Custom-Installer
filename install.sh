#!/bin/bash
# https://github.com/doruo
# Some ideas and codes are taken from https://github.com/JaKooLit

# /--------------------/ VARIABLES /--------------------/

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
RELATIVE_PATH=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
CUSTOM_CONF_PATH="$RELATIVE_PATH/custom-hypr"
CONF_PATH="~/.config/hypr"

# Jakoolit urls
JAKOOLIT_REPO="https://github.com/JaKooLit/Fedora-Hyprland"
AUTO_INSTALL="https://raw.githubusercontent.com/JaKooLit/Fedora-Hyprland/main/auto-install.sh"


# /--------------------/ INIT /--------------------/

clear
cd ~

# Update operating system
echo "${INFO} Updating Fedora..."
sudo dnf update

# Instal utilities
sudo dnf install whiptail

whiptail --title "Doruo custom Fedora-Hyprland (2025) Install Script" \
    --msgbox "Welcome to Doruo Fedora-Hyprland (2025) Install Script!\n\n\
Mostly taken from Jakoolit incredible setup: $JAKOOLIT_REPO"\
    15 80

# /--------------------/ Install jakoolit fedora hyprland /--------------------/

git clone --depth=1 $JAKOOLIT_REPO.git ~/Fedora-Hyprland
cd ~/Fedora-Hyprland
chmod +x install.sh
./install.sh

# Ask if the user wants to proceed custom setup
if ! whiptail --title "Proceed with custom setup?" \
    --yesno "Would you like to proceed additionnal custom setup?" 7 50; then
    echo -e "\n"
    echo "${INFO} You chose ${YELLOW}NOT${RESET} to proceed. ${YELLOW}Exiting...${RESET}"
    echo -e "\n"
    exit 1
fi

# /--------------------/ CUSTOM SETUP INTERFACE /--------------------/

# Custom Hyprland config
# Ask if the user wants to delete older config
if whiptail --title "Custom Hyprland config" \
    --yesno "Would you like to use custom Hyprland config ?" 7 50; then

        CHOICE_CUSTOM_CONFIG=true
fi        

# Dev softwares
if whiptail --title "Dev softwares" \
    --yesno "Would you like to install dev softwares ?" 7 50; then

        CHOICE_INSTALL_DEV_SOFT=true
fi  

# Dev langages
if whiptail --title "Dev langages" \
    --yesno "Would you like to install go, python ?" 7 50; then

        CHOICE_INSTALL_DEV_LANG=true
fi    

# Discord
if whiptail --title "Discord" \
    --yesno "Would you like to install discord ?" 7 50; then
    
    CHOICE_INSTALL_DISCORD=true
fi  

# Reboot
# Ask if the user wants to reboot
if whiptail --title "End of Hyprland setup" \
    --yesno "Would you like to reboot when finished?" 7 50; then
    CHOICE_REBOOT_AFTER_INSTALL=true
fi

# /--------------------/ CUSTOM SETUP PROCESS /--------------------/

# Custom Hyprland config

if $CHOICE_CUSTOM_CONFIG; then
    echo -e "\n"echo "${INFO} You chose to use custom Hyprland config."
    echo -e "\n"

    # Custom scripts
    
    cp -r $CUSTOM_CONF_PATH/UserScripts $CONF_PATH/UserScripts

    # Custom configs

    cp -r $CUSTOM_CONF_PATH/configs $CONF_PATH/configs

    # Custom rofi themes

    cp -r $CUSTOM_CONF_PATH/configs $CONF_PATH/configs

    # Custom wallpapers

    cp -r $CUSTOM_CONF_PATH/wallpapers ~/Pictures/wallpapers    

    # Custom bash aliases

    if [ -f .bashrc ]; then
        truncate -s 0 .bashrc
    fi
    cat $CUSTOM_CONF_PATH/aliases > .bashrc
    source .bashrc
 
else
    echo -e "\n"
    echo "${INFO} You chose ${YELLOW}NOT${RESET} to use custom Hyprland config."
    echo -e "\n"
fi


# Dev softwares

if $CHOICE_INSTALL_DEV_SOFT; then
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
else
    echo -e "\n"
    echo "${INFO} You chose ${YELLOW}NOT${RESET} to install softwares."
    echo -e "\n"
fii

# Dev langages

if $CHOICE_INSTALL_DEV_LANG; then
    echo -e "\n"
    echo "${INFO} You chose to install dev langages (go, python). ${YELLOW}Installing...${RESET}"
    sudo dnf install go    
    sudo dnf install python3
else
    echo -e "\n"
    echo "${INFO} You chose ${YELLOW}NOT${RESET} to install dev langages (go, python)."
    echo -e "\n"
fi

# Discord

if $CHOICE_INSTALL_DISCORD; then
    echo -e "\n"
    echo "${INFO} You chose to install Discord. ${YELLOW}Installing...${RESET}"
    sudo dnf install discord 
else
    echo -e "\n"
    echo "${INFO} You chose ${YELLOW}NOT${RESET} to install Discord."
    echo -e "\n"
fi

# Reboot

if $CHOICE_REBOOT_AFTER_INSTALL; then
    echo -e "\n"
    echo "${INFO} You chose to reboot when finished."
    echo -e "\n"
    echo -e "${INFO} ${YELLOW}Rebooting your computer in $DELAY_BEFORE_REBOOT seconds...${RESET}"
    sleep $DELAY_BEFORE_REBOOT
    reboot
else
    echo -e "\n"
    echo "${INFO} You chose ${YELLOW}NOT${RESET} to reboot when finished."
    echo -e "\n"
fi

echo -e "\n ${OK} ${GREEN}End of script...${RESET}"
