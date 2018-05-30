#!/bin/bash

CURRENT_DIR="$(cd `dirname $0` && pwd)"

source $CURRENT_DIR/functions.sh

argcheck $@

LABELS="
metadata:
  labels:
    release: $RELEASE_NAME
"

if [[ ! $(kubectl get secret ca-mitm-token -n $RELEASE_NAMESPACE ) ]]; then
    echo "Creating ca-mitm-token..."
    kubectl create secret generic ca-mitm-token --from-literal=token=$(uuidgen) -n $RELEASE_NAMESPACE
    kubectl patch secret ca-mitm-token -p "$LABELS"
else
    echo "Secret ca-mitm-token is already created"
fi