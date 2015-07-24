#!/bin/sh

###################################################################################
# Shell script for starting Madsonic.  See http://madsonic.org.
###################################################################################

## Copy over ffmpeg and other transcoders

mkdir -p /config/transcode
cp /var/madsonic/transcode/* /config/transcode/

chown -R nobody:users /config
chmod +x /config/transcode/*

## Start up Madsonic
HOME=/config
  if [ -z $HOST ]; then 
    HOST=0.0.0.0
  fi
  if [ -z $PORT ]; then
    PORT=4040
  fi
  if [ -z $CONTEXT_PATH ]; then
    CONTEXT_PATH=/
  fi
  if [ -z $MAX_MEMORY ]; then
    MAX_MEMORY=1024
  fi

MADSONIC_USER=nobody

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

/usr/bin/madsonic --home=$HOME \
                  --host=$HOST \
                  --port=$PORT \
                  --context-path=$CONTEXT_PATH \
                  --max-memory=$MAX_MEMORY
                  
sleep 5

tail -f /config/madsonic_sh.log
