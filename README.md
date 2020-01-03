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
$ . ./packages-install.sh
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
