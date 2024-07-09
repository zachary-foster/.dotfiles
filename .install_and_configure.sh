#! /usr/bin/bash

# Automount personal data drive
PERSONAL_UUID=$(sudo blkid $(sudo blkid --label personal) --output export | grep UUID= | sed 's/UUID=//')
mkdir ~/personal
printf "UUID=${PERSONAL_UUID}\t${HOME}/personal\text4\tdefaults\t0\t2" | sudo tee -a /etc/fstab >/dev/null
sudo mount -a

# Customize bash
printf '\n# Custom .bashrc settings\nsource .bashrc_additions\n' >>~/.bashrc
source ~/.bashrc_additions

# Update base system
sudo apt update
sudo apt upgrade -y

# Install vim
sudo apt install -y vim

# Install stow
sudo apt install -y stow

# Install tmux
sudo apt install -y tmux

# Install git
sudo apt install -y git-all
git config --global init.defaultBranch

# Install neovim
sudo apt-get install -y neovim

# Install wezterm
#curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /usr/share/keyrings/wezterm-fury.gpg
#echo 'deb [signed-by=/usr/share/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list
#sudo apt update
#sudo apt install -y wezterm

# Install lazyvim
sudo apt-get install -y ripgrep fd-find
git clone https://github.com/LazyVim/starter ~/.config/nvim
rm -rf ~/.config/nvim/.git

# Install R
sudo apt update -qq
sudo apt install --no-install-recommends software-properties-common dirmngr
wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | sudo tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc
sudo add-apt-repository --yes "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/"4
sudo apt update
sudo apt install -y --no-install-recommends r-base

# Install RStudio
sudo apt install -y ~/personal/tools/setup/installers/rstudio-2024.04.2-764-amd64.deb
