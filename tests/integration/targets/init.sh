#!/usr/bin/env bash
# shellcheck disable=SC2155,SC2086

# Export the collections path
export ANSIBLE_COLLECTIONS_PATH="$ANSIBLE_COLLECTIONS_PATH/ansible_collections"

echo "ANSIBLE_COLLECTIONS_PATH: $ANSIBLE_COLLECTIONS_PATH"
BASE_DIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
export ANSIBLE_ROLES_PATH=${BASE_DIR}
