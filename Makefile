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
eco-vcenter-ci: install-python-packages install-ansible-collections prepare_symlinks install-pyvmomy-latest
	@for dir in $(shell ansible-test integration --list-target --no-temp-workdir | grep 'vmware_ops_'); do \
	  ansible-test integration --no-temp-workdir $$dir; \
	done

.PHONY: ee-clean
ee-clean:
	rm -rf context/

.PHONY: ee-build
ee-build: ee-clean
	ansible-builder build -f execution-environment/execution-environment.yml -t quay.io/${QUAY_USER}/vmware:${QUAY_TAG} -v3
