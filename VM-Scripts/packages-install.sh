#!/bin/bash

# Install Script for Elasticsearch, Kibana, Apache Storm, and Apache Maven
cd ~
sudo apt-get update -qq
sudo apt-get install -yy default-jre
sudo apt-get install -yy unzip

# Download and install Elasticsearch
wget -qO - https://packages.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
sudo apt-get install -yy apt-transport-https
echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-7.x.list
sudo apt-get update && sudo apt-get install -yy elasticsearch
echo "deb https://artifacts.elastic.co/packages/oss-7.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-7.x.list

# Download and install Kibana
sudo apt-get install -yy kibana

# Download and install Storm
sudo wget http://mirrors.ukfast.co.uk/sites/ftp.apache.org/storm/apache-storm-1.2.3/apache-storm-1.2.3.zip
sudo unzip apache-storm-1.2.3.zip

sudo echo "export STORM_HOME=/opt/apache-storm-1.2.3" >> ~/.bash_profile
sudo echo "export PATH=$PATH:${STORM_HOME}/bin" >> ~/.bash_profile

sudo rm apache-storm-1.2.3.zip 
source ~/.bash_profile
cd ~
