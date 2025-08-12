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

SCRIPT_PATH=$(pwd)

cd ~
# Bash aliases copy
if [ -f .bashrc ]; then
    truncate -s 0 .bashrc
fi

cat $SCRIPTH_PATH/aliases > .bashrc
source .bashrc

# update system & softwares
echo "${INFO} Updating Fedora... ${RESET}"

u
i whiptail
i curl

whiptail --title "Doruo custom Fedora-Hyprland (2025) Install Script" \
    --msgbox "Welcome to Doruo Fedora-Hyprland (2025) Install Script!\n\n\
Mostly taken from Jakoolit incredible setup: https://github.com/JaKooLit/Fedora-Hyprland"\
    15 80

# Ask if the user wants to proceed
if ! whiptail --title "Proceed with Installation?" \
    --yesno "Would you like to proceed?" 7 50; then
    echo -e "\n"
    echo "${INFO} You chose ${YELLOW}NOT${RESET} to proceed. ${YELLOW}Exiting...${RESET}"
    echo -e "\n"
    exit 1
fi

if whiptail --title "Dev softwares setup." \
    --yesno "Would you like to install git, pgadmin, postman ?"\n\n\
    "Mostly taken from Jakoolit incredible setup: https://github.com/JaKooLit/Fedora-Hyprland"\
7 50; then
        echo -e "\n"
        echo "${INFO} You chose to install softwares. ${YELLOW}Installing...${RESET}"
        isoftwares        
fi  

if whiptail --title "Dev langages setup." \
    --yesno "Would you like to install go, python ?" 7 50; then
        echo -e "\n"
        echo "${INFO} You chose to install dev langages (go, python). ${YELLOW}Installing...${RESET}"
        ilangages     
fi    

if whiptail --title "Discord install." \
    --yesno "Would you like to install discord ?" 7 50; then
        echo -e "\n"
        echo "${INFO} You chose to install discord. ${YELLOW}Installing...${RESET}"
        i discord 
fi  
  
if [ -d "~/Fedora-Hyprland" ]; then
    # Ask if the user wants to delete older config
    if whiptail --title "Fedora-Hyprland already exists." \
        --yesno "Would you like to delete older config ?" 7 50; then
        echo -e "\n"
        echo "${INFO} You chose to delete. ${YELLOW}Exiting...${RESET}"
        echo -e "\n"
        echo -e "\n ${INFO} Deleting older folder..."
        rm -rf ~/Fedora-Hyprland
    fi
fi

# Install jakoolit fedora hyprland
cd ~/Fedora-Hyprland
sh <(curl -L https://raw.githubusercontent.com/JaKooLit/Fedora-Hyprland/main/auto-install.sh)

# Ask if the user wants to reboot
if whiptail --title "End of Hyprland setup" \
    --yesno "Would you like to reboot?" 7 50; then
    echo -e "\n"
    echo "${INFO} You chose to reboot. ${YELLOW}Exiting...${RESET}"
    echo -e "\n"
    echo -e "${INFO} ${YELLOW}Rebooting your computer...${RESET}"
    sleep 6
    reboot
fi

echo -e "\n ${OK} ${GREEN}End of script...${RESET}"
