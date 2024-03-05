.PHONY: install-python-packages
install-python-packages:
	pip3 install -r tests/integration/requirements.txt

.PHONY: install-ansible-collections
install-ansible-collections:
	ansible-galaxy collection install -r tests/integration/requirements.yml

.PHONY: integration
integration: install-python-packages install-ansible-collections
	ansible-test integration --no-temp-workdir
