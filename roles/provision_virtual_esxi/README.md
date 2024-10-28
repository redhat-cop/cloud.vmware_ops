# provision_virtual_esxi

Provision one or more virtual ESXi hosts

## Dependencies

When deploying a new VM:
  You should have an ESXi ISO that the VM can access in order to boot and install the ESXi OS. A common storage place would be a datastore that is accessible to the host running the new VM. The ISO should be pre-configured for an unattended install, or you should be prepared to manually complete the install process via console. The role will know when the install is complete when the new VM is powered off or has an IP address.

  This role will import the cloud.vmware_ops.provision_vm role automatically.

## Role Variables


### Auth

- **provision_virtual_esxi_hostname** (str, required)
    - The hostname or IP address of the vSphere vCenter or ESXi host.
    - If this variable is not set, the collection level variable `vmware_ops_hostname` will be used. If that variable is not set, the environment variable `VMWARE_HOST` will be used. At least one of these variables must be set to use this role.
    - See the [authentication documentation](https://github.com/redhat-cop/cloud.vmware_ops/blob/main/docs/authentication.md) for examples.

- **provision_virtual_esxi_username** (str, required)
    - The vSphere vCenter or ESXi host username.
    - If this variable is not set, the collection level variable `vmware_ops_username` will be used. If that variable is not set, the environment variable `VMWARE_USER` will be used. At least one of these variables must be set to use this role.
    - See the [authentication documentation](https://github.com/redhat-cop/cloud.vmware_ops/blob/main/docs/authentication.md) for examples.

- **provision_virtual_esxi_password** (str, required)
    - The vSphere vCenter or ESXi host password.
    - If this variable is not set, the collection level variable `vmware_ops_password` will be used. If that variable is not set, the environment variable `VMWARE_PASSWORD` will be used. At least one of these variables must be set to use this role.
    - See the [authentication documentation](https://github.com/redhat-cop/cloud.vmware_ops/blob/main/docs/authentication.md) for examples.

- **provision_virtual_esxi_validate_certs** (bool)
    - Allows connection when SSL certificates are not valid. Set to false when certificates are not trusted.
    - If this variable is not set, the collection level variable `vmware_ops_validate_certs` will be used. If that variable is not set, the environment variable `VMWARE_VALIDATE_CERTS` will be used.
    - See the [authentication documentation](https://github.com/redhat-cop/cloud.vmware_ops/blob/main/docs/authentication.md) for examples.

- **provision_virtual_esxi_port** (int or str)
    - The port used to authenticate to the vSphere vCenter or ESXi host.
    - If this variable is not set, the collection level variable `vmware_ops_port` will be used. If that variable is not set, the environment variable `VMWARE_PORT` will be used.
    - See the [authentication documentation](https://github.com/redhat-cop/cloud.vmware_ops/blob/main/docs/authentication.md) for examples.

### Placement

- **provision_virtual_esxi_cluster** (str)
    - The name of the cluster in which you want to deploy the new VMs.

- **provision_virtual_esxi_datacenter** (str)
    - The name of the datacenter in which you want to deploy the new VMs.

- **provision_virtual_esxi_resource_pool** (str)
    - The name of the resource pool in which to place the VMs. It's recommended to use a resource pool and limit the amount of resources these ESXi hosts can use

- **provision_virtual_esxi_folder** (str)
    - The name of the folder in which to place the VMs

### VM Options

- **provision_virtual_esxi_vms** (list(dict))
    - A list of dictionaries describing the ESXi hosts you want to manage. If no VM exists with the name, a new VM will be created. VMs are created in parallel to save time.
    - **Elements**:
        - `name`: str, The name of the VM that you want to manage. Required
        - `networks`: list(dict), The network definition specific to this VM. If undefined, the value from `provision_virtual_esxi_networks` is used.
        - `disks`: list(dict), The disk definition specific to this VM. If undefined, the value from `provision_virtual_esxi_disks` is used.
        - `memory_mb`: int, The memory definition specific to this VM. If undefined, the value from `provision_virtual_esxi_memory_mb` is used.
        - `cpus`: int, The cpu definition specific to this VM. If undefined, the value from `provision_virtual_esxi_cpus` is used.

- **provision_virtual_esxi_datastore_iso_path** (str)
    - The datastore path to the ESXi ISO file that new VMs should use to boot. For example, a file in the folder ISO on datastore1 might have the path `[datastore1] ISO\my_esxi_8.iso`

- **provision_virtual_esxi_networks** (list(dict), required)
    - A list of dictionaries describing the network device configs for this VM. You may need to enable promiscuous mode and allow forged transmits on the upstream port group/vSwitch to have a working network downstream. See https://docs.ansible.com/ansible/latest/collections/community/vmware/vmware_guest_module.html#parameter-networks
    - Default is a DHCP vmxnet3 NIC on 'VM Network'

- **provision_virtual_esxi_disks** (list(dict))
    - A list of dictionaries describing the disk device configs for this VM. See https://docs.ansible.com/ansible/latest/collections/community/vmware/vmware_guest_module.html#parameter-disk
    - Default is a thin provisioned 100 GB disk

- **provision_virtual_esxi_memory_mb** (int)
    - The amount of memory to assign to this VM.
    - Default is 18000

- **provision_virtual_esxi_cpus** (int)
    - The number of vCPUs to assign to this VM.
    - Default is 4

- **provision_virtual_esxi_boot_firmware** (str)
    - The type of boot firmware that the VM should be configured to use.
    - Default value is 'bios'
    - Choices: [`bios`, `uefi`]

## Examples

```yaml
---
# In the playbook below, 3 ESXi hosts are created
# The first uses the role defaults for hardware
# The second has extra disks assigned to it
# The third has extra memory and CPUs
- name: Provision ESXi Hosts
  hosts: localhost
  roles:
    - role: cloud.vmware_ops.provision_virtual_esxi
      vars:
        provision_virtual_esxi_hostname: "{{ vcenter_hostname }}"
        provision_virtual_esxi_username: "{{ vcenter_username }}"
        provision_virtual_esxi_password: "{{ vcenter_password }}"
        provision_virtual_esxi_folder: ""
        provision_virtual_esxi_vms:
          - name: esxi-1
          - name: esxi-2
            disks:
              - size_gb: 300
                type: thin
                autoselect_datastore: true
              - size_gb: 300
                type: thin
                autoselect_datastore: true
          - name: esxi-3
            memory_mb: 24000
            cpus: 12
        provision_virtual_esxi_datastore_iso_path: "[nfs-datastore-iso] esxi_8.iso"
```

## License

GNU General Public License v3.0 or later

See [LICENSE](https://github.com/ansible-collections/cloud.aws_troubleshooting/blob/main/LICENSE) to see the full text.

## Author Information

- Ansible Cloud Content Team
