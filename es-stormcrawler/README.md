## Prerequisite:

- Elasticsearch 7.x
- Apache Storm (v1.2.3)
- Apache Storm added as a PATH variable
- Elasticsearch running on a local server

Replace all instances of "localhost" in the es-conf.yaml file and in ES_IndexInit.sh with the internal ip of the VM its running on.

Additional URLs to be crawled can be added by modifying:

```sh
seeds.txt
```

To inject urls in to Elasticsearch use:

```sh
storm jar target/es-stormcrawler-1.0-SNAPSHOT.jar  org.apache.storm.flux.Flux --local es-injector.flux --sleep 86400000
```

To crawl discovered urls, use:

```sh
storm jar target/es-stormcrawler-1.0-SNAPSHOT.jar  org.apache.storm.flux.Flux --local es-crawler.flux
```
