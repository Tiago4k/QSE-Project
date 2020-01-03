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

# Configure elasticsearch.yml with:

###### some process.sh file #######

# sudo echo "node.name: es-vm" >> /etc/elasticsearch/elasticsearch.yml
# sudo echo "network.host: "0.0.0.0""  >> /etc/elasticsearch/elasticsearch.yml
# sudo echo	"discovery.seed_hosts: ["127.0.0.1"]"  >> /etc/elasticsearch/elasticsearch.yml
# sudo echo	"cluster.initial_master_nodes: ["es-vm"]" >> /etc/elasticsearch/elasticsearch.yml


sudo /bin/systemctl daemon-reload
sudo /bin/systemctl enable elasticsearch.service
sudo /bin/systemctl start elasticsearch.service


# Download and install Kibana

sudo apt-get install -yy kibana
sudo vi /etc/kibana/kibana.yml

# Configure kibana.yml with:

###### some process.sh file #######

# sudo echo	"server.port: "5601"" >> /etc/kibana/kibana.yml
# sudo echo	"server.host: “0.0.0.0”" >> /etc/kibana/kibana.yml
# sudo echo	"elasticsearch.hosts: ["http://127.0.0.1:9200"]" >> /etc/kibana/kibana.yml

sudo /bin/systemctl daemon-reload
sudo /bin/systemctl enable kibana.service
sudo /bin/systemctl start kibana.service
