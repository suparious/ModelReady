#!/bin/bash
REDIS_DIR="${REDIS_DIR:-/usr/local/bin}"
REDIS_CONFIG="${REDIS_CONFIG:-/tmp/redis-server.conf}"
LISTEN_PORT="${LISTEN_PORT:-6379}"

if [ -f ${REDIS_DIR}/redis-server ]; then
  touch ${REDIS_CONFIG}
  redis-server ${REDIS_CONFIG} --port ${LISTEN_PORT}
else
  echo "Redis is not found in ${REDIS_DIR}, please install it first or set REDIS_DIR to where the binaries are located."
fi

# Usage: ./redis-server [/path/to/redis.conf] [options] [-]
#        ./redis-server - (read config from stdin)
#        ./redis-server -v or --version
#        ./redis-server -h or --help
#        ./redis-server --test-memory <megabytes>
#        ./redis-server --check-system
# 
# Examples:
#        ./redis-server (run the server with default conf)
#        echo 'maxmemory 128mb' | ./redis-server -
#        ./redis-server /etc/redis/6379.conf
#        ./redis-server --port 7777
#        ./redis-server --port 7777 --replicaof 127.0.0.1 8888
#        ./redis-server /etc/myredis.conf --loglevel verbose -
#        ./redis-server /etc/myredis.conf --loglevel verbose
# 
# Sentinel mode:
#        ./redis-server /etc/sentinel.conf --sentinel
