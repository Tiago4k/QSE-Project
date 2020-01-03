## Stormcrawler to use with Elasticsearch on a Virtual Machine.

Step 1: Start by cloning this repo into the VM.

``` sh
$ git clone https://github.com/Tiago4k/QSE-Project.git
```

Step 2:
``` sh
$ cd QSE-Project/scripts
```

Step 3:
``` sh
$ sh elk-packages.sh
```

Step 4:
``` sh
$ cd ~
$ cd /opt
$ sh ~/QSE-Project/scripts/storm-package.sh
$ source ~/.bash_profile
```

Step 5:
Add the following to each of the .yml files:
``` sh
$ sudo vim /etc/elasticsearch/elasticsearch.yml

# Add Elasticsearch config
node.name: es-vm
network.host: 0.0.0.0
discovery.seed_hosts: ["127.0.0.1", "[::1]"]
cluster.initial_master_nodes: ["es-vm"]

$ sudo vim /etc/kibana/kibana.yml

# Add Kibana config
server.port: 5601
server.host: "0.0.0.0"
elasticsearch.hosts: ["http://127.0.0.1:9200"]
```

Step 6:
``` sh
$ sh ~/QSE-Project/scripts/process.sh
```

### Elasticsearch and Kibana are now live.
> Elasticsearch: http://"vm-ip-address":9200

> Kibana: http://"vm-ip-address":5601


For information on how to crawl URLs with stormcralwer visit:
https://github.com/Tiago4k/QSE-Project/tree/master/es-stormcrawler
