#!/bin/sh
# Marc Tönsing - V1.1 - 25.08.2020
# Modified by Joey Reinhart
# Minecraft Server restart & update and pi reboot.
screen -Rd minecraft -X stuff "say Server is restarting in 5 seconds! $(printf '\r')"
sleep 1s
screen -Rd minecraft -X stuff "say Server is restarting in 4 seconds! $(printf '\r')"
sleep 1s
screen -Rd minecraft -X stuff "say Server is restarting in 3 seconds! $(printf '\r')"
sleep 1s
screen -Rd minecraft -X stuff "say Server is restarting in 2 seconds! $(printf '\r')"
sleep 1s
screen -Rd minecraft -X stuff "say Server is restarting in 1 second! $(printf '\r')"
sleep 1s
screen -Rd minecraft -X stuff "say Closing server...$(printf '\r')"
screen -Rd minecraft -X stuff "stop $(printf '\r')"
sleep 15s
echo "Updating to most recent Spigot version."
wget -q -O /home/pi/minecraft/server.jar https://cdn.getbukkit.org/spigot/spigot-1.16.4.jar
echo "Restarting now."
sudo /sbin/reboot
