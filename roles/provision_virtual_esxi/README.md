# provision_virtual_esxi

Provision one or more virtual ESXi hosts

## Requirements

pyvomi

## Role Variables

### Auth
- **provision_virtual_esxi_username**:
  - str, The username to use to authenticate to the esxi or vcenter on which you want to deploy the vm. Required.

- **provision_virtual_esxi_password**:
  - str, The password to use to authenticate to the esxi or vcenter on which you want to deploy the vm. Required.

- **provision_virtual_esxi_validate_certs**:
  - bool, If true then certificates will be validated when connecting to the esxi or vcenter for auth. Optional.

- **provision_virtual_esxi_port**:
  - int, The port to use when connecting to the esxi or vcenter for auth. Optional.

### Placement
- **provision_virtual_esxi_cluster**:
  - str, The name of the cluster in which you want to deploy the new vms.

- **provision_virtual_esxi_datacenter**:
  - str, The name of the datacenter in which you want to deploy the new vms.

- **provision_virtual_esxi_resource_pool**:
  - str, The name of the resource pool in which to place the VMs. Its recommended to use a resource pool and limit the amount of resources these ESXi hosts can use

- **provision_virtual_esxi_folder**:
  - str, The name of the folder in which to place the VMs


### VM Options
- **provision_virtual_esxi_vms**:
  - list(dict), A list of dictionaries describing the esxi hosts you want to manage. If no VM exists with the name, a new VM will be created. VMs are created in booted to save time.
  - **Members**
    - name - str, The name of the VM that you want to manage. Required
    - networks - list(dict), The network definition specific to this VM. If undefined, the value from `provision_virtual_esxi_networks` is used.
    - disks - list(dict), The disk definition specific to this VM. If undefined, the value from `provision_virtual_esxi_disks` is used.
    - memory_mb - int, The memory definition specific to this VM. If undefined, the value from `provision_virtual_esxi_memory_mb` is used.
    - cpus - int, The cpu definition specific to this VM. If undefined, the value from `provision_virtual_esxi_cpus` is used.

- **provision_virtual_esxi_datastore_iso_path**:
  - str, The datastore path to the ESXi ISO file that new VMs should use to boot. For example, a file in the folder ISO on datastore1 might have the path `[datastore1] ISO\my_esxi_8.iso`

- **provision_virtual_esxi_networks**:
  - list(dict), A list of dictionaries describing the network device configs for this VM. Required. You may need to enable promiscuous mode and allow forged transmits on the upstream port group/vSwitch to have a working network downstream. See https://docs.ansible.com/ansible/latest/collections/community/vmware/vmware_guest_module.html#parameter-networks
  - Default is a DHCP vmxnet3 NIC on 'VM Network'

- **provision_virtual_esxi_disks**:
  - list(dict), A list of dictionaries describing the disk device configs for this VM. See https://docs.ansible.com/ansible/latest/collections/community/vmware/vmware_guest_module.html#parameter-disk
  - Default is a thin provisioned 100 GB disk

- **provision_virtual_esxi_memory_mb**:
  - int, The amount of memory to assign to this VM.
  - Default is 18000

- **provision_virtual_esxi_cpus**:
  - int, The number of vCPUs to assign to this VM.
  - Default is 4

## Dependencies

- NA

## Example Playbook
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
        provision_virtual_esxi_iso_path: "[nfs-datastore-iso] esxi_8.iso"
```

License
-------

GNU General Public License v3.0 or later

See [LICENCE](https://github.com/ansible-collections/cloud.aws_troubleshooting/blob/main/LICENSE) to see the full text.

Author Information
------------------

- Ansible Cloud Content Team
