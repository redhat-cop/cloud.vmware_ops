# snapshot_management
A role to manage virtual machines snapshots in vCenter.
This role can be used to create, delete and update snapshot(s) of the given virtual machine.


## Dependencies

N/A


## Role Variables

### Auth

- **snapshot_management_hostname** (str, required)
    - The hostname or IP address of the vSphere vCenter.
    - If this variable is not set, the collection level variable `vmware_ops_hostname` will be used. If that variable is not set, the environment variable `VMWARE_HOST` will be used. At least one of these variables must be set to use this role.
    - See the [authentication documentation](https://github.com/redhat-cop/cloud.vmware_ops/blob/main/docs/authentication.md) for examples.

- **snapshot_management_username** (str, required)
    - The vSphere vCenter username.
    - If this variable is not set, the collection level variable `vmware_ops_username` will be used. If that variable is not set, the environment variable `VMWARE_USER` will be used. At least one of these variables must be set to use this role.
    - See the [authentication documentation](https://github.com/redhat-cop/cloud.vmware_ops/blob/main/docs/authentication.md) for examples.

- **snapshot_management_password** (str, required)
    - The vSphere vCenter password.
    - If this variable is not set, the collection level variable `vmware_ops_password` will be used. If that variable is not set, the environment variable `VMWARE_PASSWORD` will be used. At least one of these variables must be set to use this role.
    - See the [authentication documentation](https://github.com/redhat-cop/cloud.vmware_ops/blob/main/docs/authentication.md) for examples.

- **snapshot_management_validate_certs** (bool)
    - Allows connection when SSL certificates are not valid. Set to false when certificates are not trusted.
    - If this variable is not set, the collection level variable `vmware_ops_validate_certs` will be used. If that variable is not set, the environment variable `VMWARE_VALIDATE_CERTS` will be used.
    - See the [authentication documentation](https://github.com/redhat-cop/cloud.vmware_ops/blob/main/docs/authentication.md) for examples.

- **snapshot_management_port** (int or str)
    - The port used to authenticate to the vSphere vCenter that contains the cluster to configure.
    - If this variable is not set, the collection level variable `vmware_ops_port` will be used. If that variable is not set, the environment variable `VMWARE_PORT` will be used.
    - See the [authentication documentation](https://github.com/redhat-cop/cloud.vmware_ops/blob/main/docs/authentication.md) for examples.

### Proxy

- **snapshot_management_proxy_host** (str)
    - The hostname of a proxy host that should be used for all HTTPs communication by the role.
    - The format is a hostname or an IP.
    - If this variable is not set, the collection level variable `vmware_ops_proxy_host` will be used. If that variable is not set, the environment variable `VMWARE_PROXY_HOST` will be used.
    - See the [authentication documentation](https://github.com/redhat-cop/cloud.vmware_ops/blob/main/docs/authentication.md) for examples.

- **snapshot_management_proxy_port** (str or int)
    - The port of a proxy host that should be used for all HTTPs communication by the role
    - If this variable is not set, the collection level variable `vmware_ops_proxy_host` will be used. If that variable is not set, the environment variable `VMWARE_PROXY_PORT` will be used.
    - See the [authentication documentation](https://github.com/redhat-cop/cloud.vmware_ops/blob/main/docs/authentication.md) for examples.

### Manage a VM snapshot

- **snapshot_management_state** (str)
    - Manage snapshot(s) attached to a specific virtual machine.
    - If set to `present` and the snapshot is absent, then a new snapshot will be created with the given name.
    - If set to `present` and the snapshot is present, then no changes are made.
    - If set to `absent` and the snapshot is present, then the snapshot with the given name is removed.
    - If set to `absent` and the snapshot is absent, then no changes are made.
    - If set to `revert` and the snapshot is present, then virtual machine state is reverted to the given snapshot.
    - If set to `revert` and the snapshot is absent, then no changes are made.
    - If set to `remove_all` and the snapshot(s) are present, then all snapshot(s) will be removed.
    - If set to `remove_all` and the snapshot(s) are absent, then no changes are made.
    - Default is 'present'
    - Choices: [`present`, `absent`, `revert`, `remove_all`]

- **snapshot_management_vm_name** (str)
    - Name of the virtual machine to work with.
    - This is required parameter, if `snapshot_management_uuid` or `snapshot_management_moid` are not supplied.
    - This parameter is required together with `snapshot_management_folder`.

- **snapshot_management_vm_name_match** (str)
    - If multiple VMs have the same name, use the first or last found.
    - Default is 'first'
    - Choices: [`first`, `last`]

- **snapshot_management_uuid** (str)
    - UUID of the instance to manage if known. This is VMware's BIOS UUID by default.
    - This is required if neither `snapshot_management_vm_name` nor `snapshot_management_moid` are supplied.

- **snapshot_management_moid** (str)
    - Managed Object ID of the instance to manage if known. This is a unique identifier within a single vCenter instance.
    - This is required if neither `snapshot_management_vm_name` nor `snapshot_management_uuid` are supplied.

- **snapshot_management_use_instance_uuid** (bool)
    - Whether to use the VMware instance UUID rather than the BIOS UUID.
    - Default is false

- **snapshot_management_folder** (str)
    - Destination folder. The absolute or relative path to find an existing guest.
    - This parameter is required together with `snapshot_management_vm_name`.
    - The folder should include the datacenter. ESXi's default datacenter is ha-datacenter.
    - Examples:
        - /ha-datacenter/vm
        - ha-datacenter/vm
        - /datacenter1/vm
        - datacenter1/vm
        - datacenter1/vm/folder1
        - datacenter1/vm/folder1
        - /folder1/datacenter1/vm
        - /folder1/datacenter1/vm
        - /folder1/datacenter1/vm/folder2

- **snapshot_management_datacenter** (str, required)
    - Destination datacenter for the deploy operation.

- **snapshot_management_snapshot_name** (str)
    - Sets the snapshot name to manage.
    - This param or `snapshot_management_snapshot_id` are required only if state is not `remove_all`

- **snapshot_management_snapshot_id** (str)
    - Sets the snapshot ID to manage.
    - This param is used when state is `absent`.

- **snapshot_management_description** (str)
    - Define an arbitrary description to attach to the snapshot.
    - Default is ''

- **snapshot_management_quiesce** (bool)
    - If set to `true` and the virtual machine is powered on, it will quiesce the file system in the virtual machine.
    - Note that VMware Tools are required for this flag.
    - If the virtual machine is powered off or VMware Tools are not available, then this flag is ignored.
    - If the virtual machine does not provide capability to take quiesce snapshot, then this flag is ignored.
    - Default is false

- **snapshot_management_memory_dump** (bool)
    - If set to `true`, a memory dump of the virtual machine is also included in snapshot.
    - Note that memory snapshots take time and resources. This will take longer time to create.
    - If virtual machine does not provide capability to take memory snapshot, then this flag is ignored.
    - Default is false

- **snapshot_management_remove_children** (bool)
    - If set to `true` and state is set to `absent`, then the entire snapshot subtree is set for removal.
    - Default is false

- **snapshot_management_new_snapshot_name** (str)
    - Rename the existing snapshot to this value.

- **snapshot_management_new_description** (str)
    - Change the description of the existing snapshot to this value.

## Examples

All the variables defined in section [Role Variables](#role-variables) can be defined inside the ``vars.yml`` file.

Create a ``playbook.yml`` file like this:

```yaml
---
- name: Create a VM snapshot
  hosts: all
  gather_facts: false

  roles:
    - role: cloud.vmware_ops.snapshot_management
      vars:
        snapshot_management_state: present
        snapshot_management_hostname: "test"
        snapshot_management_username: "test"
        snapshot_management_password: "test"
        snapshot_management_validate_certs: false
        snapshot_management_port: "8989"
        snapshot_management_folder: "/DC0/vm"
        snapshot_management_datacenter: "DC0"
        snapshot_management_name: "vm-test"
        snapshot_management_snapshot_name: "snap1"
        snapshot_management_snapshot_description: "snap1_description"
```
```yaml
---
- name: Remove a VM snapshot and snapshot subtree
  hosts: all
  gather_facts: false

  roles:
    - role: cloud.vmware_ops.snapshot_management
      vars:
        snapshot_management_state: absent
        snapshot_management_hostname: "test"
        snapshot_management_username: "test"
        snapshot_management_password: "test"
        snapshot_management_validate_certs: false
        snapshot_management_port: "8989"
        snapshot_management_folder: "/DC0/vm"
        snapshot_management_datacenter: "DC0"
        snapshot_management_name: "vm-test"
        snapshot_management_snapshot_name: "snap1"
        snapshot_management_snapshot_remove_children: true
```
```yaml
---
- name: Revert VM to a snapshot
  hosts: all
  gather_facts: false

  roles:
    - role: cloud.vmware_ops.snapshot_management
      vars:
        snapshot_management_state: revert
        snapshot_management_hostname: "test"
        snapshot_management_username: "test"
        snapshot_management_password: "test"
        snapshot_management_validate_certs: false
        snapshot_management_port: "8989"
        snapshot_management_folder: "/DC0/vm"
        snapshot_management_datacenter: "DC0"
        snapshot_management_name: "vm-test"
        snapshot_management_snapshot_name: "snap1"
```
```yaml
---
- name: Remove all snapshots of a VM
  hosts: all
  gather_facts: false

  roles:
    - role: cloud.vmware_ops.snapshot_management
      vars:
        snapshot_management_state: remove_all
        snapshot_management_hostname: "test"
        snapshot_management_username: "test"
        snapshot_management_password: "test"
        snapshot_management_validate_certs: false
        snapshot_management_port: "8989"
        snapshot_management_folder: "/DC0/vm"
        snapshot_management_datacenter: "DC0"
        snapshot_management_name: "vm-test"
```
Run the playbook:

```shell
ansible-playbook playbook.yml -e "@vars.yml"
```

## License

GNU General Public License v3.0 or later

See [LICENSE](https://github.com/ansible-collections/cloud.vmware_ops/blob/main/LICENSE) to see the full text.

## Author Information

- Ansible Cloud Content Team
