#! /bin/bash
sudo apt update -qq
sudo apt upgrade -qq
sudo apt install -yy python2.7 python-pip
git clone https://github.com/Tiago4k/QSE-Project.git
cd QSE-Project/scripts
sh elk-packages.sh
cd /opt
sudo sh /QSE-Project/scripts/storm-package.sh
