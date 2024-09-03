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
[cloud.vmware_ops.provision_vcenter](https://github.com/redhat-cop/cloud.vmware_ops/blob/main/roles/provision_vcenter/README.md)|A role to provision vCenter on ESXi host.
[cloud.vmware_ops.provision_vm](https://github.com/redhat-cop/cloud.vmware_ops/blob/main/roles/provision_vm/README.md)|A role to create/manage virtual machines on VMware.
[cloud.vmware_ops.system_settings](https://github.com/redhat-cop/cloud.vmware_ops/blob/main/roles/system_settings/README.md)|A role to manage system settings on VMware.
[cloud.vmware_ops.cluster_settings](https://github.com/redhat-cop/cloud.vmware_ops/tree/main/roles/cluster_settings/README.md)|A role to define cluster settings in vCenter.
[cloud.vmware_ops.content_library](https://github.com/redhat-cop/cloud.vmware_ops/tree/main/roles/content_library/README.md)|A role to manage VMware content libraries.
[cloud.vmware_ops.deploy_ovf](https://github.com/redhat-cop/cloud.vmware_ops/tree/main/roles/deploy_ovf/README.md)|A role to deploy a VM from an OVF file.
[cloud.vmware_ops.esxi_maintenance_mode](https://github.com/redhat-cop/cloud.vmware_ops/tree/main/roles/esxi_maintenance_mode/README.md)|Either put an ESXi host in maintenance mode or take the host out of maintenance mode.
[cloud.vmware_ops.export_vm_as_ovf](https://github.com/redhat-cop/cloud.vmware_ops/tree/main/roles/export_vm_as_ovf/README.md)|A role to export a VM from vCenter or ESXi as an OVF.
[cloud.vmware_ops.info](https://github.com/redhat-cop/cloud.vmware_ops/tree/main/roles/info/README.md)|A role that gather information from vCenter.
[cloud.vmware_ops.manage_folder](https://github.com/redhat-cop/cloud.vmware_ops/tree/main/roles/manage_folder/README.md)|A role to create, delete, or update a folder or folder tree in vCenter.
[cloud.vmware_ops.provision_virtual_esxi](https://github.com/redhat-cop/cloud.vmware_ops/tree/main/roles/provision_virtual_esxi/README.md)|A role to provision one or more virtual ESXi hosts.
[cloud.vmware_ops.snapshot_management](https://github.com/redhat-cop/cloud.vmware_ops/tree/main/roles/snapshot_management/README.md)|A role to manages virtual machines snapshots in vCenter.
[cloud.vmware_ops.vcenter_host_connection](https://github.com/redhat-cop/cloud.vmware_ops/tree/main/roles/vcenter_host_connection/README.md)|A role to add, remove, connect, disconnect, or reconnect an ESXi host from a vCenter.

### Playbooks
Name | Description
--- | ---
[cloud.vmware_ops.provision_vcenter](https://github.com/redhat-cop/cloud.vmware_ops/blob/main/playbooks/provision_vcenter/provision_vcsa_on_esxi.yml)|A playbook to provision vCenter on ESXi host.
[cloud.vmware_ops.system_settings](https://github.com/redhat-cop/cloud.vmware_ops/blob/main/playbooks/system_settings.yml)|A playbook to manage system settings on VMware.
[cloud.vmware_ops.cluster_settings](https://github.com/redhat-cop/cloud.vmware_ops/blob/main/playbooks/cluster_settings)|A set of playbooks to manage cluster settings.
[cloud.vmware_ops.esxi_management](https://github.com/redhat-cop/cloud.vmware_ops/blob/main/playbooks/esxi_management)|A set of playbooks to manage ESXi host in a cluster.
[cloud.vmware_ops.provision_vm](https://github.com/redhat-cop/cloud.vmware_ops/blob/main/playbooks/provision_vm)|A set of playbooks to manage provisioning VM.
[cloud.vmware_ops.snapshot_management](https://github.com/redhat-cop/cloud.vmware_ops/blob/main/playbooks/snapshot_management)|A set of playbooks to manage VM snapshots on vCenter.
[cloud.vmware_ops.export_vm_as_ovf](https://github.com/redhat-cop/cloud.vmware_ops/blob/main/playbooks/export_vm_as_ovf.yml)|A playbook to export VM as OVF file.
[cloud.vmware_ops.info](https://github.com/redhat-cop/cloud.vmware_ops/blob/main/playbooks/info.yml)|A playbook to gather information from vCenter.
[cloud.vmware_ops.manage_content_library](https://github.com/redhat-cop/cloud.vmware_ops/blob/main/playbooks/manage_content_library.yml)|A playbook to manage content libraries in vCenter.
[cloud.vmware_ops.manage_folder](https://github.com/redhat-cop/cloud.vmware_ops/blob/main/playbooks/manage_folder.yml)|A playbook to manage folders in vCenter.
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
