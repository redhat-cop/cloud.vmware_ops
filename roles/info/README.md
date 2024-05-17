# Gather information from vcenter 

A role that gather information from vcenter.

## Requirements

N/A

## Role Variables
### Auth
- **info_username**:
  - The vSphere vCenter username.

- **info_password**:
  - The vSphere vCenter password.

- **info_hostname**:
  - The hostname or IP address of the vSphere vCenter.

- **info_validate_certs**
  - Allows connection when SSL certificates are not valid. Set to false when certificates are not trusted.

### Appliance
- **info_appliance**
  - Define whether appliance information should be gathered. Default is `false`.

- **info_appliance_gather**
  - Define the sections of the appliance to gather. By default we gather all appliance information.

- **info_appliance_file**
  - File where to store the gathered data. Default is `/tmp/appliance-{random}`

### License
- **info_license**
  - Define whether license information should be gathered. Default is `false`.

- **info_license_file**
  - File where to store the gathered data. Default is `/tmp/license-{random}`

### Cluster
- **info_cluster**
  - Define whether cluster information should be gathered. Default is `false`.

- **info_cluster_file**
  - File where to store the gathered data. Default is `/tmp/cluster-{random}`

### Storage
- **info_storage**
  - Define whether storage information should be gathered. Default is `false`.

- **info_storage_file**
  - File where to store the gathered data. Default is `/tmp/storage-{random}`

### Guest
- **info_guest**
  - Define whether guest information should be gathered. Default is `false`.

- **info_guest_file**
  - File where to store the gathered data. Default is `/tmp/guest-{random}`

## Dependencies

- community.vmware
- vmware.vmware
- vmware.vmware_rest

## Example Playbook
```yaml
---
- name: Manage vmware operation visibility
  hosts: all
  gather_facts: false

  vars:
    info_hostname: "vcenterhostname"
    info_username: "username"
    info_password: "password"

    info_license: true
    info_storage: true
    info_appliance: true

  roles:
    - role: cloud.vmware_ops.info
```
## License

GNU General Public License v3.0 or later

See [LICENCE](https://github.com/ansible-collections/cloud.aws_troubleshooting/blob/main/LICENSE) to see the full text.

## Author Information

- Ansible Cloud Content Team
