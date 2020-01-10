## Stormcrawler to use with Elasticsearch on a Virtual Machine.

Option 1 and 2 show how to setup up a single node cluster. For a multi-node cluster follow Option 3.

**If using Terraform to provision a VM, follow the steps in Option 2**

---
### Option 1:
Step 1: 
Start by cloning this repo into the VM.

``` sh
git clone https://github.com/Tiago4k/QSE-Project.git
```

Step 2:
``` sh
cd QSE-Project/scripts
```

Step 3:
``` sh
sh elk-packages.sh
```

Step 4:
``` sh
cd /opt
sh ~/QSE-Project/scripts/storm-package.sh
source ~/.bash_profile
```

Step 5:
Add the following to each of the .yml files:
``` sh
sudo vim /etc/elasticsearch/elasticsearch.yml

# Add Elasticsearch config
node.name: es-vm
network.host: 0.0.0.0
discovery.seed_hosts: ["127.0.0.1", "[::1]"]
cluster.initial_master_nodes: ["es-vm"]

sudo vim /etc/kibana/kibana.yml

# Add Kibana config
server.port: 5601
server.host: "0.0.0.0"
elasticsearch.hosts: ["http://127.0.0.1:9200"]
```

Step 6:
``` sh
sh ~/QSE-Project/scripts/process.sh
```

---

### Option 2:
Step 1:
``` sh
cd /opt
sh /QSE-Project/scripts/storm-package.sh
source ~/.bash_profile
```

Step 2:
Add the following to each of the .yml files:
``` sh
sudo vim /etc/elasticsearch/elasticsearch.yml

# Add Elasticsearch config
node.name: es-vm
network.host: 0.0.0.0
discovery.seed_hosts: ["127.0.0.1", "[::1]"]
cluster.initial_master_nodes: ["es-vm"]

sudo vim /etc/kibana/kibana.yml

# Add Kibana config
server.port: 5601
server.host: "0.0.0.0"
elasticsearch.hosts: ["http://127.0.0.1:9200"]
```

Step 3:
``` sh
sh /QSE-Project/scripts/process.sh
```

---

### Option 3 - Multi-node Cluster

**Note, each step needs to be completed for each of the nodes.**

Step 1:
``` sh
cd /opt
sh /QSE-Project/scripts/storm-package.sh
source ~/.bash_profile
```

Step 2:
For each of the nodes in your cluster add the following:
``` sh
sudo vim /etc/elasticsearch/elasticsearch.yml

cluster.name: ES-Stormcrawler

# Give each node a unique name. E.g. es-node-1, es-node-2, etc..
node.name: <node_name>
node.data: true

# Replace <node-#_internal_ip> with the internal ip of the current node.
network.host: <node-#_internal_ip>

# Add the internal ip of each of the nodes in your cluster. E.g. "10.10.0.1", "10.10.0.2", etc...
discovery.seed_hosts: ["<node-1_internal_ip>", "<node-2_internal_ip>", "<node-3_internal_ip>", "<node-4_internal_ip>",
"<node-5_internal_ip>"]

# Add the internal ip of the nodes that can be master nodes when the cluster starts up. 
cluster.initial_master_nodes: [<node-1_internal_ip>", "<node-2_internal_ip>", "<node-3_internal_ip>"]

bootstrap.memory_lock: true
```

Step 3: 
Configure memory requirements for Elasticsearch. Allocate approximately half of the avaliable memory to Elasticsearch.

``` sh
sudo vim /etc/elasticsearch/jvm.options

-Xms6g
-Xmx6g
```

Step 4:
``` sh
sudo vim /etc/default/elasticsearch 

# Uncomment this line
MAX_LOCKED_MEMORY=unlimited
```

Step 5:
``` sh
sudo vim /etc/security/limits.conf

# Add at the end of the file

#allow user 'elasticsearch' bootstrap.memory_lock
elasticsearch soft memlock unlimited
elasticsearch hard memlock unlimited
```

Step 7:
```sh
mkdir -p /etc/systemd/system/elasticsearch.service.d
touch /etc/systemd/system/elasticsearch.service.d/override.conf
```

Step 8:
``` sh
sudo vim /etc/systemd/system/elasticsearch.service.d/override.conf

# Add the following to the file

[Service]
LimitMEMLOCK=infinity
```

Step 9:
```sh
sudo /bin/systemctl daemon-reload
sudo /bin/systemctl enable elasticsearch.service && sudo /bin/systemctl start elasticsearch.service
```

#### To add Kibana support, create a new VM that will only be running Kibana with the following configuration:

Step 1: <br/>
Download and install Kibana: <br/>
https://www.elastic.co/guide/en/kibana/current/deb.html 

Step 2:
```sh
sudo vim /etc/kibana/kibana.yml

server.port: 5601
server.host: "0.0.0.0"

# Add the internal_ip of the nodes to the elasticsearch.host list
elasticsearch.hosts: ["http://<node1_internal_ip>:9200", "http://<node2_internal_ip>:9200"]
```

Step 3:
```sh
sudo /bin/systemctl daemon-reload
sudo /bin/systemctl enable kibana.service && sudo /bin/systemctl start kibana.service
```


### Elasticsearch and Kibana are now live.
> Elasticsearch: http://"vm-ip-address":9200 <br />
> Kibana: http://"vm-ip-address":5601


For information on how to crawl URLs with stormcralwer visit: <br />
https://github.com/Tiago4k/QSE-Project/tree/master/es-stormcrawler

Resources: <br />
https://medium.com/@tplmaps/minimal-installation-of-elasticsearch-cluster-in-production-251fc4e5fac1 <br />
https://tecadmin.net/setup-elasticsearch-on-ubuntu/ <br />
