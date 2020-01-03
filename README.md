Stormcrawler to use with Elasticsearch on a Virtual Machine.

Step 1: Start by cloning this repo into the VM.

``` sh
$ git clone https://github.com/Tiago4k/QSE-Project.git
```

Step 2:
``` sh
$ cd QSE-Project/VM-Scripts
```

Step 3:
``` sh
$ sh elk-packages.sh
```

Step 4:
``` sh
$ cd ~
$ cd /opt
$ sh ~/QSE-Project/VM-Scripts/storm-package.sh
$ source ~/.bash_profile
```

Step 5:
Copy the contents of elk-config to their respective yml files:
``` sh
# Add Elasticsearch config
  node.name: es-vm
  network.host: "0.0.0.0"
  discovery.seed_hosts: ["127.0.0.1"]
  cluster.initial_master_nodes: ["es-vm"]

$ sudo vim /etc/elasticsearch/elasticsearch.yml

# Add Kibana config
  server_port: "5601"
  server_host: "0.0.0.0"
  elasticsearch.hosts: ["http://127.0.0.1:9200"]

$ sudo vim /etc/kibana/kibana.yml
```

Step 6:
``` sh
$ cd ~/QSE-Project/VM-Scripts
$ sh process.sh
```





## Prerequisite:
 * Elasticsearch 7.x
 * Apache Storm (v1.2.3)
 * Apache Storm added as a PATH variable
 * Elasticsearch running on a local server

Additional URLs to be crawled can be added by modifying:
``` sh
seeds.txt
```

To inject urls in to Elasticsearch use:
``` sh
storm jar target/es-stormcrawler-1.0-SNAPSHOT.jar  org.apache.storm.flux.Flux --local es-injector.flux --sleep 86400000
```
To crawl discovered urls, use:
``` sh
storm jar target/es-stormcrawler-1.0-SNAPSHOT.jar  org.apache.storm.flux.Flux --local es-crawler.flux
```