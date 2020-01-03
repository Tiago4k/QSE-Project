export node_name="es-vm"
export network_host="0.0.0.0"
export seed_host="127.0.0.1"
export master_node="es-vm"
export server_port="5601"
export server_host="0.0.0.0"
export elastic_host="http://127.0.0.1:9200"

sudo rm -f /etc/elasticsearch/elasticsearch.yml temp.yml
( echo "cat &lt;&lt;EOF &gt;elasticsearch.yml";
  cat temp-elastic.yml;
  echo "EOF";
) >temp.yml
. temp.yml
sudo cat /etc/elasticsearch/elasticsearch.yml

sudo rm -f /etc/kibana/kibana.yml temp.yml
( echo "cat &lt;&lt;EOF &gt;kibana.yml";
  cat temp-kibana.yml;
  echo "EOF";
) >temp.yml
. temp.yml
sudo cat /etc/kibana/kibana.yml
