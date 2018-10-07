# Elastic stack (ELK) - Prometheus - Graphana - Kafka on Docker for developer box usage

(Just for development purpose on my own)
Run the latest version of the [Elastic stack](https://www.elastic.co/elk-stack) with Docker and Docker Compose.

Based on the official Docker images from Elastic:

* [elasticsearch](https://github.com/elastic/elasticsearch-docker)
* [logstash](https://github.com/elastic/logstash-docker)
* [kibana](https://github.com/elastic/kibana-docker)

## Usage

Start the stack using `docker-compose`:

```console
$ docker-compose up
```

By default, the dev box exposes the following ports:

* 5000: Logstash TCP input
* 9200: Elasticsearch HTTP
* 9300: Elasticsearch TCP transport
* 5601: Kibana
* 9090: Prometheus UI
* 3000: Grafana UI (admin:admin)
* 8080: Kafka metrics - <http://localhost:8080/metrics>
