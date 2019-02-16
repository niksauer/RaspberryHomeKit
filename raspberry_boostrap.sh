#!/bin/bash

# HEADLESS SETUP
# https://www.raspberrypi.org/documentation/installation/installing-images/README.md
# https://raspberrypi.stackexchange.com/questions/10251/prepare-sd-card-for-wifi-on-headless-pi/57023#57023

# LOCALE
sudo nano /etc/locale.gen # uncomment en_US.UTF-8
sudo locale-gen en_US.UTF-8
sudo nano /etc/default/locale # set LANG=en_US.UTF-8
sudo update-locale en_US.UTF-8
exit

# WELCOME MESSAGE
sudo vi /etc/motd # remove content as desired

# UTILITIES
sudo apt-get update
sudo apt-get upgrade -y
sudo apt install git

# OH MY ZSH
# https://github.com/robbyrussell/oh-my-zsh
sudo apt install zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" 

# SSH Keys
mkdir -p .ssh
scp ~/.ssh/id_rsa.pub Raspberry:/home/pi # copy your public key to raspberry pi
cat ~/id_rsa.pub >> ~/.ssh/authorized_keys

# DOCKER
curl -sSL https://get.docker.com | sh
sudo usermod -aG docker pi
sudo systemctl enable docker
sudo systemctl start docker
sudo reboot

# DOCKER COMPOSE
sudo apt install python3-pip python3
sudo pip3 install docker-compose

# HOMEBRIDGE
# https://github.com/oznu/docker-homebridge/wiki/Homebridge-on-Raspberry-Pi
cd ~
git clone https://github.com/niksauer/RaspberryHomeKit.git
cd RaspberryHomeKit 
docker-compose up -d 
docker-compose logs -f # hostname -I > http://admin:admin:<ip>:8080 > change password, install plugins and update config as desired