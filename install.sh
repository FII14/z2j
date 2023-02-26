#!/bin/bash
# File to install z2j

read -p "Do you want to install z2j [Y/n]: " ask

if [[ "${ask}" == "y" || "${ask}" == "Y" ]]; then
  cp src/z2j /usr/bin
  chmod +x /usr/bin/z2j
  echo "z2j installed successfully."
  exit

elif [[ "${ask}" == "n" || "${ask}" == "N" ]]; then
  exit

else
  echo "Wrong input."
  exit
fi  
