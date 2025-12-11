# Define ANSI escape codes for colors
GREEN=\033[0;32m
RED=\033[0;31m
NC=\033[0m  # No Color

QUAY_USER ?= vmware_ops
QUAY_TAG ?= latest

.PHONY: upgrade-collections
upgrade-collections:
	ansible-galaxy collection install --upgrade -p ~/.ansible/collections .

.PHONY: install-collection-python-reqs
install-collection-python-reqs:
	pip install -r requirements.txt

.PHONY: install-integration-reqs
install-integration-reqs: install-collection-python-reqs
	pip install -r tests/integration/requirements.txt; \
	ansible-galaxy collection install --upgrade -p ~/.ansible/collections -r tests/integration/requirements.yml

tests/integration/integration_config.yml:
	chmod +x ./tests/integration/generate_integration_config.sh; \
	./tests/integration/generate_integration_config.sh

.PHONY: sanity
sanity: upgrade-collections
	cd ~/.ansible/collections/ansible_collections/vmware/vmware; \
	ansible-test sanity -v --color --coverage --junit --docker default

.PHONY: integration
integration: install-integration-reqs upgrade-collections
	cd ~/.ansible/collections/ansible_collections/cloud/vmware_ops; \
	ansible --version; \
	ansible-test --version; \
	ANSIBLE_COLLECTIONS_PATH=~/.ansible/collections/ansible_collections ansible-galaxy collection list; \
	ANSIBLE_ROLES_PATH=~/.ansible/collections/ansible_collections/cloud/vmware_ops/tests/integration/targets \
		ANSIBLE_COLLECTIONS_PATH=~/.ansible/collections/ansible_collections \
		ansible-test integration $(CLI_ARGS);


.PHONY: eco-vcenter-ci
eco-vcenter-ci: tests/integration/integration_config.yml install-integration-reqs upgrade-collections
	cd ~/.ansible/collections/ansible_collections/cloud/vmware_ops; \
	ansible --version; \
	ansible-test --version; \
	ANSIBLE_COLLECTIONS_PATH=~/.ansible/collections/ansible_collections ansible-galaxy collection list; \
	chmod +x tests/integration/run_eco_vcenter_ci.sh; \
	ANSIBLE_ROLES_PATH=~/.ansible/collections/ansible_collections/cloud/vmware_ops/tests/integration/targets \
		ANSIBLE_COLLECTIONS_PATH=~/.ansible/collections/ansible_collections \
		./tests/integration/run_eco_vcenter_ci.sh


.PHONY: ee-clean
ee-clean:
	rm -rf context/

.PHONY: ee-build
ee-build: ee-clean
	ansible-builder build -f execution-environment/execution-environment.yml -t quay.io/${QUAY_USER}/vmware:${QUAY_TAG} -v3
