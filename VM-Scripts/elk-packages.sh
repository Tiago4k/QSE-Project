#!/bin/bash

# Install Script for Elasticsearch, Kibana, Apache Storm
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
