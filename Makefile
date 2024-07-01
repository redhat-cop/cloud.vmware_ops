# Define ANSI escape codes for colors
GREEN=\033[0;32m
RED=\033[0;31m
NC=\033[0m  # No Color

QUAY_USER ?= vmware_ops
QUAY_TAG ?= latest

.PHONY: install-python-packages
install-python-packages:
	pip3 install -r tests/integration/requirements.txt

.PHONY: install-ansible-collections
install-ansible-collections:
	ansible-galaxy collection install --upgrade -r tests/integration/requirements.yml

# this playbook aims to create a symlink for the runme.sh script
# for each integration target so that ansible-test will recognize it for the target
# and the script will run the test
.PHONY: prepare_symlinks
prepare_symlinks:
	ansible-playbook tools/prepare_symlinks.yml

# workaround pyvmomy issue till latest version
# is available to use in requirements.txt
.PHONY: install-pyvmomy-latest
install-pyvmomy-latest:
	pip3 install pyVmomi --force

.PHONY: integration
integration: install-python-packages install-ansible-collections prepare_symlinks
	ansible-test integration --no-temp-workdir

.PHONY: eco-vcenter-ci
eco-vcenter-ci: prepare_symlinks
	@[ -f /tmp/vmware_ops_tests_report.txt ] && rm /tmp/vmware_ops_tests_report.txt || true; \
	@failed=0; \
	total=0; \
	echo "===============" >> /tmp/vmware_ops_tests_report.txt; \
	echo "Tests Summary" >> /tmp/vmware_ops_tests_report.txt; \
	echo "===============" >> /tmp/vmware_ops_tests_report.txt; \
	for dir in $(shell ansible-test integration --list-target --no-temp-workdir | grep 'vmware_ops_'); do \
	  echo "Running integration test for $$dir"; \
	  total=$$((total + 1)); \
	  if ansible-test integration --no-temp-workdir $$dir; then \
	    echo -e "Test: $$dir ${GREEN}Passed${NC}" | tee -a /tmp/vmware_ops_tests_report.txt; \
	  else \
	    echo -e "Test: $$dir ${RED}Failed${NC}" | tee -a /tmp/vmware_ops_tests_report.txt; \
	    failed=$$((failed + 1)); \
	  fi; \
	done; \
	echo "$$failed test(s) failed out of $$total." >> /tmp/vmware_ops_tests_report.txt; \
	cat /tmp/vmware_ops_tests_report.txt; \
	if [ $$failed -gt 0 ]; then \
	  exit 1; \
	fi

.PHONY: ee-clean
ee-clean:
	rm -rf context/

.PHONY: ee-build
ee-build: ee-clean
	ansible-builder build -f execution-environment/execution-environment.yml -t quay.io/${QUAY_USER}/vmware:${QUAY_TAG} -v3
