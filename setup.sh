#!/bin/bash
# Original Minecraft Server Installation Script - James A. Chambers - https://www.jamesachambers.com.
# Changes and simplifications by Marc Tönsing
# Modified by Joey Reinhart on Jan 5th 2021

echo "Minecraft Server installation script by James Chambers and Marc Tönsing - V1.0"
echo "Modified by Joey Reinhart"
echo "Latest version always at https://github.com/oofmaster69420/RaspberryPiMinecraftServer"
echo "This script automaticly agrees to the Minecraft EULA for you"
echo "If you don't want to agree to the EULA press Ctrl+C now or wait 5 secconds for the script to start"
echo "You can read the EULA at https://www.minecraft.net/en-us/eula"

sleep 5

if [ -d "minecraft" ]; then
  echo "Directory minecraft already exists!  Exiting... "
  exit 1
fi

echo "Updating packages..."
sudo apt-get update

echo "Installing Java..."
sudo apt-get install openjdk-16-jre-headless -y

echo "Installing screen... "
sudo apt-get install screen -y

echo "Creating minecraft server directory..."
mkdir minecraft
cd minecraft

echo "Getting latest Paper Minecraft server..."
wget -O server.jar https://papermc.io/api/v2/projects/paper/versions/1.17.1/builds/276/downloads/paper-1.17.1-276.jar

echo "Building the Minecraft server... "
java -jar server.jar

echo "Accepting the EULA... "
echo eula=true > eula.txt

echo "Grabbing run.sh from repository... "
wget -O run.sh https://raw.githubusercontent.com/oofmaster69420/RaspberryPiMinecraftServer/master/run-8GB.sh

TotalMemory=$(awk '/MemTotal/ { printf "%.0f\n", $2/1024 }' /proc/meminfo)
if [ $TotalMemory -lt 6000 ]; then
  rm run.sh
  wget -O run.sh https://raw.githubusercontent.com/oofmaster69420/RaspberryPiMinecraftServer/master/run-4GB.sh
fi

if [ $TotalMemory -lt 2500 ]; then
  rm run.sh
  wget -O run.sh https://raw.githubusercontent.com/oofmaster69420/RaspberryPiMinecraftServer/master/run-2GB.sh
fi

chmod +x run.sh

echo "Setup is complete. To run the server go to the minecraft directory and type ./run.sh"
echo "Don't forget to set up port forwarding on your router. The default port is 25565"
echo "Don't forget to set up the server.properties file to your liking."
echo "You can add plugins by placing the plugin files in the plugins folder inside the minecraft server directory"
