QUAY_USER ?= vmware_ops
QUAY_TAG ?= latest

.PHONY: install-python-packages
install-python-packages:
	pip3 install -r tests/integration/requirements.txt

.PHONY: install-ansible-collections
install-ansible-collections:
	ansible-galaxy collection install -r tests/integration/requirements.yml

.PHONY: integration
integration: install-python-packages install-ansible-collections
	ansible-test integration --no-temp-workdir

.PHONY: ee-clean
ee-clean:
	rm -rf context/

.PHONY: ee-build
ee-build: ee-clean
	ansible-builder build -f execution-environment/execution-environment.yml -t quay.io/${QUAY_USER}/vmware:${QUAY_TAG} -v3
