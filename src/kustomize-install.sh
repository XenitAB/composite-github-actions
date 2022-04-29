#!/bin/bash

set -e

KUSTOMIZE_TAG=$1
KUSTOMIZE_SHA=$2

wget https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2F${KUSTOMIZE_TAG}/kustomize_${KUSTOMIZE_TAG}_linux_amd64.tar.gz
DOWNLOAD_KUSTOMIZE_SHA=$(openssl sha1 -sha256  kustomize_${KUSTOMIZE_TAG}_linux_amd64.tar.gz | awk '{print $2}')
tar -xvf kustomize_${KUSTOMIZE_TAG}_linux_amd64.tar.gz
if [[ "${KUSTOMIZE_SHA}" != "${DOWNLOAD_KUSTOMIZE_SHA}" ]]; then
    echo "Downloaded checksum (${DOWNLOAD_KUSTOMIZE_SHA}) for 'kustomize' does not match expected value: ${KUSTOMIZE_SHA}" 1>&2
    exit 1
fi
