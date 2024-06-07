#!/bin/bash
# Forked from @JCGAMESCLASSICOS
# Delete all containers in the first line

#docker stop $(docker ps -aq) && docker rm $(docker ps -aq)
# Installing Docker and Firefox Nightly
curl -L docker.batocera.pro | bash
curl -L ffnightly.batocera.pro | bash

# Create directory for the files to be called
mkdir -p /userdata/roms/microsoft
mkdir -p /userdata/roms/microsoft/windows10

# Set file ID
curl -L -o /userdata/roms/microsoft/windows10/docker-compose.yml https://github.com/garbagescow/Windows/main/roms/microsoft/Windows10/docker-compose.yml
curl -o /userdata/roms/microsoft/windows10/Windows10.sh https://github.com/garbagescow/Windows/main/roms/microsoft/Windows10/Windows10.sh
chmod +x /userdata/roms/microsoft/windows10/Windows10.sh

# Check if docker-compose is installed
if ! command -v docker-compose &> /dev/null
then
    echo "docker-compose is not installed. Please install docker-compose and try again."
    exit 1
fi

# Download and move ES to the folder
curl -o /userdata/system/configs/emulationstation/es_systems_microsoft.cfg https://github.com/garbagescow/Windows/main/es_systems_microsoft.cfg

cd /userdata/roms/microsoft/windows10 && docker-compose up
pkill xterm

# Open Firefox with the localhost address
/userdata/system/pro/ffnightly/Launcher http://localhost:8006
