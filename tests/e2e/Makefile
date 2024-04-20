VENV_DIR := .venv

.PHONY: install-python-packages
install-python-packages: $(VENV_DIR)
	$(VENV_DIR)/bin/pip install -r ../integration/requirements.txt

.PHONY: install-ansible-collections
install-ansible-collections: $(VENV_DIR)
	$(VENV_DIR)/bin/ansible-galaxy collection install -r ../integration/requirements.yml

.PHONY: install-molecule
install-molecule: $(VENV_DIR)
	$(VENV_DIR)/bin/pip install molecule

$(VENV_DIR):
	python3 -m venv $(VENV_DIR)

.PHONY: e2e-molecule
e2e-molecule: install-python-packages install-ansible-collections install-molecule
	@echo "Running Molecule tests with the scenario: $(scenario)"
	$(VENV_DIR)/bin/molecule test -s $(scenario)
