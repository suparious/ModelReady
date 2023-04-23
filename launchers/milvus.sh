#!/bin/bash
RELEASE_NAME="${RELEASE_NAME:-solidrust-ai-assistant}"
LISTEN_PORT="${LISTEN_PORT:-19530}"

# Get the Running milvus-proxy pod name and service port
MILVUS_PROXY="$(kubectl get pod | grep milvus-proxy | grep Running | awk {' print $1 '})"
MILVUS_PROXY_PORT="$(kubectl get pod ${MILVUS_PROXY} --template='{{(index (index .spec.containers 0).ports 0).containerPort}}{{"\n"}}')"
DEPLOYMENT_CHECK="$(kubectl get svc | grep ${RELEASE_NAME} | grep ${MILVUS_PROXY_PORT})"

if [ -z "${MILVUS_PROXY}" ]; then
  echo "Milvus Proxy not Running"
else
  echo "Milvus Proxy Running"
  if [ -z "${DEPLOYMENT_CHECK}" ]; then
    echo "${RELEASE_NAME} not found"
  else
    echo "${RELEASE_NAME} appears deployed"
    kubectl port-forward --address 0.0.0.0 service/${RELEASE_NAME}-milvus ${LISTEN_PORT}:${MILVUS_PROXY_PORT}
  fi
fi
