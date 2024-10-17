# export_vm_as_ovf

A role to export a VM from vCenter or ESXi as an OVF. The VM is exported to the local filesystem of the host running the tasks (ansible_host).

## Dependencies

N/A

## Role Variables

### Auth

- **export_vm_as_ovf_hostname** (str, required)
    - The hostname or IP address of the vSphere vCenter or ESXi host.
    - If this variable is not set, the collection level variable `vmware_ops_hostname` will be used. If that variable is not set, the environment variable `VMWARE_HOST` will be used. At least one of these variables must be set to use this role.
    - See the [authentication documentation](https://github.com/redhat-cop/cloud.vmware_ops/blob/main/docs/authentication.md) for examples.

- **export_vm_as_ovf_username** (str, required)
    - The vSphere vCenter or ESXi host username.
    - If this variable is not set, the collection level variable `vmware_ops_username` will be used. If that variable is not set, the environment variable `VMWARE_USER` will be used. At least one of these variables must be set to use this role.
    - See the [authentication documentation](https://github.com/redhat-cop/cloud.vmware_ops/blob/main/docs/authentication.md) for examples.

- **export_vm_as_ovf_password** (str, required)
    - The vSphere vCenter or ESXi host password.
    - If this variable is not set, the collection level variable `vmware_ops_password` will be used. If that variable is not set, the environment variable `VMWARE_PASSWORD` will be used. At least one of these variables must be set to use this role.
    - See the [authentication documentation](https://github.com/redhat-cop/cloud.vmware_ops/blob/main/docs/authentication.md) for examples.

- **export_vm_as_ovf_validate_certs** (bool)
    - Allows connection when SSL certificates are not valid. Set to false when certificates are not trusted.
    - If this variable is not set, the collection level variable `vmware_ops_validate_certs` will be used. If that variable is not set, the environment variable `VMWARE_VALIDATE_CERTS` will be used.
    - See the [authentication documentation](https://github.com/redhat-cop/cloud.vmware_ops/blob/main/docs/authentication.md) for examples.

- **export_vm_as_ovf_port** (int or str)
    - The port used to authenticate to the vSphere vCenter or ESXi host.
    - If this variable is not set, the collection level variable `vmware_ops_port` will be used. If that variable is not set, the environment variable `VMWARE_PORT` will be used.
    - See the [authentication documentation](https://github.com/redhat-cop/cloud.vmware_ops/blob/main/docs/authentication.md) for examples.

### Proxy

- **export_vm_as_ovf_proxy_host** (str)
    - The hostname of a proxy host that should be used for all HTTPs communication by the role.
    - The format is a hostname or an IP.
    - If this variable is not set, the collection level variable `vmware_ops_proxy_host` will be used. If that variable is not set, the environment variable `VMWARE_PROXY_HOST` will be used.
    - See the [authentication documentation](https://github.com/redhat-cop/cloud.vmware_ops/blob/main/docs/authentication.md) for examples.

- **export_vm_as_ovf_proxy_port** (str or int)
    - The port of a proxy host that should be used for all HTTPs communication by the role
    - If this variable is not set, the collection level variable `vmware_ops_proxy_host` will be used. If that variable is not set, the environment variable `VMWARE_PROXY_PORT` will be used.
    - See the [authentication documentation](https://github.com/redhat-cop/cloud.vmware_ops/blob/main/docs/authentication.md) for examples.

### VM Options

- **export_vm_as_ovf_datacenter** (str)
    - The name of the datacenter in vSphere vCenter which contains the VM.
    - Aliases: [export_vm_as_ovf_datacenter_name]

- **export_vm_as_ovf_vm_folder** (str)
    - The vCenter folder that contains the VM that should be exported. This should be the full folder path

- **export_vm_as_ovf_vm_moid** (str)
    - The MOID of the VM that should be exported.
    - One of `export_vm_as_ovf_vm_uuid`, `export_vm_as_ovf_vm_name`, or `export_vm_as_ovf_vm_moid` needs to be defined.

- **export_vm_as_ovf_vm_name** (str)
    - The name of the VM that should be exported.
    - One of `export_vm_as_ovf_vm_uuid`, `export_vm_as_ovf_vm_name`, or `export_vm_as_ovf_vm_moid` needs to be defined.

- **export_vm_as_ovf_vm_uuid** (str)
    - The UUID of the VM that should be exported.
    - One of `export_vm_as_ovf_vm_uuid`, `export_vm_as_ovf_vm_name`, or `export_vm_as_ovf_vm_moid` needs to be defined.

### Export Options

- **export_vm_as_ovf_download_timeout** (int)
    - The maximum number of seconds that the OVF export process can take before a timeout error is thrown.

- **export_vm_as_ovf_export_dir** (str, required)
    - The local path to the directory where the OVF file should be created.
    - If the path does not exist, it will be created

- **export_vm_as_ovf_export_with_extra_config** (bool)
    - If true any extra configuration settings applied to the VM will be included in the exported OVF

- **export_vm_as_ovf_export_with_images** (bool)
    - If true any ISO files attached to the VM will be included in the exported OVF

## Examples

```yaml
---
- name: Export VM To Localhost
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

See [LICENSE](https://github.com/ansible-collections/cloud.aws_troubleshooting/blob/main/LICENSE) to see the full text.

## Author Information

- Ansible Cloud Content Team
