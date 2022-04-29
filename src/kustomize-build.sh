#!/bin/bash

set -e

KUSTOMIZE_OPTIONS=$1

# Run kustomize build for all folders containing a kustomization.yaml file
while read -r -d '' file; do
    dir=$(dirname "$file")
    echo -e "\n======================================================================================" 1>&2
    echo "Running  'kustomize build ${KUSTOMIZE_OPTIONS} '$dir'" 1>&2
    echo "======================================================================================" 1>&2
    ./kustomize build ${KUSTOMIZE_OPTIONS} "$dir"
done < <(find . -type f -name 'kustomization.yaml' -print0)
