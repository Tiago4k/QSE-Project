Stormcrawler to use with Elasticsearch. 

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
