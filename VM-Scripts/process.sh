#!/bin/bash

# Script to enable services at VM start up, and start them.

sudo /bin/systemctl daemon-reload
sudo /bin/systemctl enable elasticsearch.service
sudo /bin/systemctl start elasticsearch.service
sudo /bin/systemctl enable kibana.service
sudo /bin/systemctl start kibana.service
