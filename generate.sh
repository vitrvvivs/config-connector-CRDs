#!/bin/bash
set -euo pipefail

# requires yq
# It could just use sed, but I'm lazy.

for file in k8s-config-connector/crds/*; do
    group="$(yq -r .spec.group <"$file")"
    echo "$group" "$file"
    mkdir -p "$group"
    pushd "$group"
    ../kubeconform/scripts/openapi2jsonschema.py "../$file"
    popd
done
