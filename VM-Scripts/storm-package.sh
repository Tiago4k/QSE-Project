#!/bin/bash

# Download and install Storm
sudo wget http://mirrors.ukfast.co.uk/sites/ftp.apache.org/storm/apache-storm-1.2.3/apache-storm-1.2.3.zip
sudo unzip apache-storm-1.2.3.zip

sudo echo "export STORM_HOME=/opt/apache-storm-1.2.3" >> ~/.bash_profile
sudo echo "export PATH=\$PATH:\${STORM_HOME}/bin" >> ~/.bash_profile

sudo rm apache-storm-1.2.3.zip 
