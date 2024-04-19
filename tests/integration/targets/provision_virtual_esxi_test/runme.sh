#!/usr/bin/env bash
source ../init.sh
ansible-playbook mock_side_effects.yml  &
PID="$!"

ansible-playbook run.yml
RESULT=$?
pkill -P "$PID"

exit $RESULT
