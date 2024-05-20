QUAY_USER ?= vmware_ops
QUAY_TAG ?= latest

.PHONY: install-python-packages
install-python-packages:
	pip3 install -r tests/integration/requirements.txt

.PHONY: install-ansible-collections
install-ansible-collections:
	ansible-galaxy collection install --upgrade -r tests/integration/requirements.yml

# workaround pyvmomy issue till latest version
# is available to use in requirements.txt
.PHONY: install-pyvmomy-latest
install-pyvmomy-latest:
	pip3 install pyVmomi --force

.PHONY: integration
integration: install-python-packages install-ansible-collections
	ansible-test integration --no-temp-workdir

.PHONY: eco-vcenter-ci
eco-vcenter-ci: install-python-packages install-ansible-collections install-pyvmomy-latest
	ansible-test integration --no-temp-workdir info_test

.PHONY: ee-clean
ee-clean:
	rm -rf context/

.PHONY: ee-build
ee-build: ee-clean
	ansible-builder build -f execution-environment/execution-environment.yml -t quay.io/${QUAY_USER}/vmware:${QUAY_TAG} -v3
