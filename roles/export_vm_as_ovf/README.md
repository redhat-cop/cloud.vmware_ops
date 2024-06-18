# Export VM As OVF Role

A role to export a VM from VCenter or ESXi as an OVF. The VM is exported to the local filesystem of the host running the tasks (anisble_host).

## Requirements

N/A

## Role Variables
### Auth
- **export_vm_as_ovf_username**:
  - The vSphere vCenter username.

- **export_vm_as_ovf_password**:
  - The vSphere vCenter password.

- **export_vm_as_ovf_hostname**:
  - The hostname or IP address of the vSphere vCenter.

- **export_vm_as_ovf_validate_certs**
  - Allows connection when SSL certificates are not valid. Set to false when certificates are not trusted.

- **export_vm_as_ovf_cluster_name**:
  - The name of the cluster in vSphere vCenter that contains the VM.

- **export_vm_as_ovf_datacenter_name**:
  - The name of the datacenter in vSphere vCenter which contains the VM.

- **export_vm_as_ovf_port**:
  - str or int, The port to use to authenticate to the vSphere vCenter which contains the VM.

### VM Options
- **export_vm_as_ovf_vm_datacenter**:
  - str, The name of the datacenter that contains the VM that should be exported.

- **export_vm_as_ovf_vm_folder**:
  - str, The VCenter folder that contains the VM that should be exported. This should be the full folder path

- **export_vm_as_ovf_vm_moid**:
  - str, The MOID of the VM that should be exported.
  - One of `export_vm_as_ovf_vm_uuid`, `export_vm_as_ovf_vm_name`, or `export_vm_as_ovf_vm_moid` needs to be defined.

- **export_vm_as_ovf_vm_name**:
  - str, The name of the VM that should be exported.
  - One of `export_vm_as_ovf_vm_uuid`, `export_vm_as_ovf_vm_name`, or `export_vm_as_ovf_vm_moid` needs to be defined.

- **export_vm_as_ovf_vm_uuid**:
  - str, The UUID of the VM that should be exported.
  - One of `export_vm_as_ovf_vm_uuid`, `export_vm_as_ovf_vm_name`, or `export_vm_as_ovf_vm_moid` needs to be defined.

### Export Options
- **export_vm_as_ovf_download_timeout**:
  - int, The maximum number of seconds that the OVF export process can take before a timeout error is thrown.

- **export_vm_as_ovf_export_dir**:
  - str, Required. The local path to the directory where the OVF file should be created.
  - If the path does not exist, it will be created

- **export_vm_as_ovf_export_with_extra_config**:
  - bool, If true any extra configuration settings applied to the VM will be included in the exported OVF

- **export_vm_as_ovf_export_with_images**:
  - bool, If true any ISO files attached to the VM will be included in the exported OVF

### Other
- **export_vm_as_ovf_proxy_host**:
  - str, The hostname of a proxy host that should be used for all HTTPs communication by the role. Optional

- **export_vm_as_ovf_proxy_port**:
  - str, The port of a proxy host that should be used for all HTTPs communication by the role. Optional


## Dependencies

- community.vmware

## Example Playbook
```yaml
---
- name: Export VM To Lolcahost
  hosts: localhost
  gather_facts: false

  roles:
    - role: cloud.vmware_ops.export_vm_as_ovf
      export_vm_as_ovf_vm_name: my-test-vm
      export_vm_as_ovf_export_dir: /tmp/my-test-vm-ovf
      export_vm_as_ovf_datacenter: DC1
      export_vm_as_ovf_hostname: <>
      export_vm_as_ovf_password: <>
      export_vm_as_ovf_username: <>

```
## License

GNU General Public License v3.0 or later

See [LICENCE](https://github.com/ansible-collections/cloud.aws_troubleshooting/blob/main/LICENSE) to see the full text.

## Author Information

- Ansible Cloud Content Team
