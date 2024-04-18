# Provision virtual machine
A role to manages virtual machines snapshots in vCenter.
This role can be used to create, delete and update snapshot(s) of the given virtual machine.


## Requirements 
N/A


## Role Variables
### Auth
- **snapshot_management_username**: (string, Required)
  - The vSphere vCenter username.

- **snapshot_management_password**: (string, Required)
  - The vSphere vCenter password.

- **snapshot_management_hostname**: (string, Required)
  - The hostname or IP address of the vSphere vCenter.

- **snapshot_management_validate_certs** (boolean)
  - Allows connection when SSL certificates are not valid. Set to false when certificates are not trusted.

- **snapshot_management_port** (integer):
    The port number of the vSphere vCenter or ESXi server.
    If the value is not specified in the task, the value of environment variable VMWARE_PORT will be used instead.
    Default: 443

- **snapshot_management_proxy_host** (string):
    Address of a proxy that will receive all HTTPS requests and relay them.
    The format is a hostname or a IP.
    If the value is not specified in the task, the value of environment variable VMWARE_PROXY_HOST will be used instead.

- **snapshot_management_proxy_port** (integer):
    Port of the HTTP proxy that will receive all HTTPS requests and relay them.
    If the value is not specified in the task, the value of environment variable VMWARE_PROXY_PORT will be used instead.

### Manage a VM snapshot
- **snapshot_management_state**: 
  - Manage snapshot(s) attached to a specific virtual machine.
  - If set to C(present) and snapshot absent, then will create a new snapshot with the given name.
     - If set to C(present) and snapshot present, then no changes are made.
     - If set to C(absent) and snapshot present, then snapshot with the given name is removed.
     - If set to C(absent) and snapshot absent, then no changes are made.
     - If set to C(revert) and snapshot present, then virtual machine state is reverted to the given snapshot.
     - If set to C(revert) and snapshot absent, then no changes are made.
     - If set to C(remove_all) and snapshot(s) present, then all snapshot(s) will be removed.
     - If set to C(remove_all) and snapshot(s) absent, then no changes are made.
  - choices: ['present', 'absent', 'revert', 'remove_all']
  - default: 'present'
  
- **snapshot_management_vm_name**:
  - Name of the virtual machine to work with.
  - This is required parameter, if C(uuid) or C(moid) is not supplied.

- **snapshot_management_vm_name_match**: 
  - If multiple VMs matching the name, use the first or last found.
  - default: 'first'
  - choices: ['first', 'last']

- **snapshot_management_uuid**: 
  - UUID of the instance to manage if known, this is VMware's BIOS UUID by default.
  - This is required if C(name) or C(moid) parameter is not supplied.

- **snapshot_management_moid**: 
  - Managed Object ID of the instance to manage if known, this is a unique identifier only within a single vCenter instance.
  - This is required if C(name) or C(uuid) is not supplied.

- **snapshot_management_use_instance_uuid**: 
  - Whether to use the VMware instance UUID rather than the BIOS UUID.
  - default: false

- **snapshot_management_folder**: 
  - Destination folder, absolute or relative path to find an existing guest.
  - This is required parameter, if C(name) is supplied.
  - The folder should include the datacenter. ESX's datacenter is ha-datacenter.
  - 'Examples:'
    - '   folder: /ha-datacenter/vm'
    - '   folder: ha-datacenter/vm'
    - '   folder: /datacenter1/vm'
    - '   folder: datacenter1/vm'
    - '   folder: /datacenter1/vm/folder1'
    - '   folder: datacenter1/vm/folder1'
    - '   folder: /folder1/datacenter1/vm'
    - '   folder: folder1/datacenter1/vm'
    - '   folder: /folder1/datacenter1/vm/folder2'

- **snapshot_management_datacenter**: 
  - Destination datacenter for the deploy operation.
  - required: true

- **snapshot_management_snapshot_name**: 
  - Sets the snapshot name to manage.
  - This param or C(snapshot_id) is required only if state is not C(remove_all)

- **snapshot_management_snapshot_id**: 
  - Sets the snapshot ID to manage.
  - This param is available when state is C(absent).

- **snapshot_management_description**: 
  - Define an arbitrary description to attach to snapshot.
  - default: ''

- **snapshot_management_quiesce**: 
  - If set to C(true) and virtual machine is powered on, it will quiesce the file system in the virtual machine.
  - Note that VMware Tools are required for this flag.
  - If virtual machine is powered off or VMware Tools are not available, then this flag is set to C(false).
  - If virtual machine does not provide capability to take quiesce snapshot, then this flag is set to C(false).
  - default: false

- **snapshot_management_memory_dump**: 
  - If set to C(true), memory dump of virtual machine is also included in snapshot.
  - Note that memory snapshots take time and resources, this will take longer time to create.
  - If virtual machine does not provide capability to take memory snapshot, then this flag is set to C(false).
  - default: false

- **snapshot_management_remove_children**: 
  - If set to C(true) and state is set to C(absent), then the entire snapshot subtree is set for removal.
  - default: false

- **snapshot_management_new_snapshot_name**: 
  - Value to rename the existing snapshot to.

- **snapshot_management_new_description**: 
  - Value to change the description of an existing snapshot to.


## Dependencies

N/A

## Example Playbooks

All the variables defined in section [Role Variables](#role-variables) can be defined inside the ``vars.yml`` file.

Create a ``playbook.yml`` file like this:

```
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
```
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
```
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
```
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

See [LICENCE](https://github.com/ansible-collections/cloud.vmware_ops/blob/main/LICENSE) to see the full text.

## Author Information

- Ansible Cloud Content Team