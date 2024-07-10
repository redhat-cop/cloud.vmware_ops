#!/usr/bin/env bash
source ../init.sh

# Extract the ansible_tags from integration_config.yml
ANSIBLE_TAGS=$(awk '/ansible_tags/ {print $2}' ../../integration_config.yml)

# Check if the ANSIBLE_TAGS variable is set
if [[ -n "$ANSIBLE_TAGS" ]]; then
  echo "ANSIBLE_TAGS is set to: $ANSIBLE_TAGS"
  ansible-playbook run.yml --tags "$ANSIBLE_TAGS"
else
  echo "ANSIBLE_TAGS is not set for Eco vCenter. Running on simulator."
  ansible-playbook mock_side_effects.yml & ansible-playbook run.yml --tags integration-ci
fi
