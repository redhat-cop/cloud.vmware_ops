# cloud.vmware_ops roles/playbooks for VMware

This repository hosts the `cloud.vmware_ops` Ansible Collection.

The collection includes a variety of Ansible roles and playbooks to help automate the management of VMware.

<!--start requires_ansible-->
## Ansible version compatibility

This collection has been tested against following Ansible versions: **>=2.14.0**.

## Python version compatibility

This collection requires Python 3.9 or greater.

## Included content

Click on the name of a role to view that content's documentation:

<!--start collection content-->
### Roles
Name | Description
--- | ---
[cloud.vmware_ops.provision_vcenter](https://github.com/redhat-cop/cloud.vmware_ops/blob/main/roles/provision_vcenter/README.md)|A role to provison Vcenter on ESXi host.
[cloud.vmware_ops.provision_vm](https://github.com/redhat-cop/cloud.vmware_ops/blob/main/roles/provision_vm/README.md)|A role to create/manage virtual machines on VMware.
[cloud.vmware_ops.system_settings](https://github.com/redhat-cop/cloud.vmware_ops/blob/main/roles/system_settings/README.md)|A role to manage system settings on VMware.

### Playbooks
Name | Description
--- | ---
[cloud.vmware_ops.provision_vcenter](https://github.com/redhat-cop/cloud.vmware_ops/blob/main/playbooks/provision_vcenter/provision_vcsa_on_esxi.yml)|A playbook to provison Vcenter on ESXi host.
[cloud.vmware_ops.provision_vm](https://github.com/redhat-cop/cloud.vmware_ops/blob/main/playbooks/provision_vm/manage_vm.yml)|A playbook to create/manage virtual machines on VMware.
[cloud.vmware_ops.system_settings](https://github.com/redhat-cop/cloud.vmware_ops/blob/main/playbooks/system_settings.yml)|A playbook to manage system settings on VMware.
<!--end collection content-->

## Installation and Usage

### Requirements

The [community.vmware](https://github.com/ansible-collections/community.vmware) (>=4.4.0), 
[vmware.vmware_rest](https://github.com/ansible-collections/vmware.vmware_rest), 
[vmware.vmware](https://github.com/ansible-collections/vmware.vmware),
[community.general](https://github.com/ansible-collections/community.general) and
[ansible.posix](https://github.com/ansible-collections/ansible.posix)
collections MUST be installed in order for this collection to work.

### Installation

To consume this Validated Content from Automation Hub, please ensure that you add the following lines to your ansible.cfg file.

```
[galaxy]
server_list = automation_hub

[galaxy_server.automation_hub]
url=https://cloud.redhat.com/api/automation-hub/
auth_url=https://sso.redhat.com/auth/realms/redhat-external/protocol/openid-connect/token
token=<SuperSecretToken>
```
The token can be obtained from the [Automation Hub Web UI](https://console.redhat.com/ansible/automation-hub/token).

Once the above steps are done, you can run the following command to install the collection.

```
ansible-galaxy collection install cloud.vmware_ops
```

### Using this collection

Once installed, you can reference the cloud.vmware_ops collection content by its fully qualified collection name (FQCN), for example:

```yaml
  - hosts: localhost
    roles:
      - role: cloud.vmware_ops.system_settings
```

### See Also

* [Ansible Using collections](https://docs.ansible.com/ansible/latest/user_guide/collections_using.html) for more details.


## Contributing to this collection

We welcome community contributions to this collection. If you find problems, please open an issue or create a PR against this collection repository.

### Testing and Development

The project uses `ansible-lint` and `black`.
Assuming this repository is checked out in the proper structure,
e.g. `collections_root/ansible_collections/cloud/vmware_ops/`, run:

```shell
  tox -e linters
```

Sanity and unit tests are run as normal:

```shell
  ansible-test sanity
```

#### Integration Tests

Currently integration tests are using vcsim, which is VMware SOAP API simulator. So no external infrastructure is needed.
Vcsim is executed in a podman container before the integration test is executed.

In order to run the integration tests, please follow:

```bash
make integration
```

## License

GNU General Public License v3.0 or later

See [LICENSE](https://github.com/ansible-collections/cloud.vmware_ops/blob/main/LICENSE) to see the full text.
