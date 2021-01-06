#!/bin/bash
# Original Minecraft Server Installation Script - James A. Chambers - https://www.jamesachambers.com.
# Changes and simplifications by Marc Tönsing
# Modified by Joey Reinhart

echo "Minecraft Server installation script by James Chambers and Marc Tönsing - V1.0"
echo "Latest version always at https://github.com/mtoensing/RaspberryPiMinecraft"

if [ -d "minecraft" ]; then
  echo "Directory minecraft already exists!  Exiting... "
  exit 1
fi

echo "Updating packages..."
sudo apt-get update

echo "Installing Java..."
sudo apt-get install openjdk-11-jre-headless -y

echo "Installing screen... "
sudo apt-get install screen -y

echo "Creating minecraft server directory..."
mkdir minecraft
cd minecraft

echo "Getting latest Spigot Minecraft server..."
wget -O server.jar https://cdn.getbukkit.org/spigot/spigot-1.16.4.jar

echo "Building the Minecraft server... "
java -jar -Xms800M -Xmx800M server.jar

echo "Accepting the EULA... "
echo eula=true > eula.txt

echo "Grabbing run.sh from repository... "
wget -O run.sh https://raw.githubusercontent.com/oofmaster69420/RaspberryPiMinecraft/master/run.sh
chmod +x run.sh

TotalMemory=$(awk '/MemTotal/ { printf "%.0f\n", $2/1024 }' /proc/meminfo)
if [ $TotalMemory -lt 6000 ]; then
  rm run.sh
  wget -O run.sh https://raw.githubusercontent.com/oofmaster69420/RaspberryPiMinecraft/master/run_lowspec.sh
  chmod +x run.sh
fi

if [ $TotalMemory -lt 2500 ]; then
  rm run.sh
  wget -O run.sh https://raw.githubusercontent.com/oofmaster69420/RaspberryPiMinecraft/master/run_superlowspec.sh
  chmod +x run.sh
fi

echo "Grabbing restart.sh from repository... "
wget -O restart.sh https://raw.githubusercontent.com/oofmaster69420/RaspberryPiMinecraft/master/restart.sh
chmod +x restart.sh

echo "Enter a name for your server "
read -p 'Server Name: ' servername
echo "server-name=$servername" >> server.properties
echo "motd=$servername" >> server.properties

echo "Setup is complete. To run the server go to the minecraft directory and type ./run.sh"
echo "Don't forget to set up port forwarding on your router. The default port is 25565"
