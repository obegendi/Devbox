#!/usr/bin/env ash

if [ $HOST_ELASTICSEARCH ]; then
  if [ -z $DRY_RUN ]; then
    # wait for elasticsearch to start up
    ELASTIC_PATH=${HOST_ELASTICSEARCH:-elasticsearch:9200}
    echo "Configure ${ELASTIC_PATH}"

    counter=0
    while [ ! "$(curl $ELASTIC_PATH 2> /dev/null)" -a $counter -lt 30  ]; do
      sleep 1
      let counter++
      echo "waiting for Elasticsearch to be up ($counter/30)"
    done

    curl -XPUT "http://$ELASTIC_PATH/_template/metricbeat" -d@/metricbeat/metricbeat.template-es2x.json
  fi
fi



if [ -z $DRY_RUN ]; then

  if [ -z $SKIP_CHOWN_CONFIG ]; then  
      # Change owner of config file if necessary
      USER=$(whoami)
      FILE_USER=$(stat -c '%U' /metricbeat/metricbeat.yml)
      echo "Metricbeat.yml file owner is $FILE_USER"
      if [ "$FILE_USER" != "root" ] && [ "$FILE_USER" != "$USER" ]; then
          echo "Change metricbeat.yml file owner to $USER"
          chown $USER /metricbeat/metricbeat.yml
      fi
  fi

  # Change permissions of the config file
  chmod go-w /metricbeat/metricbeat.yml

  metricbeat -e -v -c /metricbeat/metricbeat.yml $@
fi