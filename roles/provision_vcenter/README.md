# provision_vcenter

Provision a vCenter appliance on an ESXi host, using a vCenter ISO locally or VMX file on a datastore

## Requirements

pyvomi

## Role Variables

### Auth
- **provision_vcenter_username**:
  - str, The username to use to authenticate to the esxi or vcenter on which you want to deploy the application. Required.

- **provision_vcenter_password**:
  - str, The password to use to authenticate to the esxi or vcenter on which you want to deploy the application. Required.

- **provision_vcenter_port**:
  - str or int, The port to use to authenticate to the esxi or vcenter on which you want to deploy the application. Required.

- **provision_vcenter_validate_certs**:
  - bool, If true then certificates will be validated when connecting to the esxi or vcenter for auth. Optional.

### Replication Options

- **provision_vcenter_replication_partner_hostname**:
  - str, The hostname of the already existing replication partner for sso. If set, replication will be configured during setup

### Existing vCenter Target Options

- **provision_vcenter_vc_target_datacenter**:
  - str, The datacenter you want to deploy the appliance into. Only required when deploying into an existing vCenter server.

- **provision_vcenter_vc_target_esxi_path**:
  - str, The path/name of the ESXi server you want to deploy the appliance into. Only required when deploying into an existing vCenter server.

### Install Source
- **provision_vcenter_iso_path**:
  - str, The local path to the vCenter ISO. Required.

- **provision_vcenter_iso_mount_point**:
  - str, The local path that should be used as a mount point for the vCenter ISO. It will be created if it doesn't exist. Default is `/mnt/vcenter_iso`

### VCSA VM
- **provision_vcenter_vm_name**:
  - str, The name for the vcenter vm, as seen in the web gui. Required.

- **provision_vcenter_vm_network_hostname**:
  - str, The network hostname (https://your_hostname) for vCenter. DNS should already resolve on the localhost. Required.

- **provision_vcenter_vm_network_mode**:
  - str, The type of network mode the vcenter vm should use. Can be 'static' or 'dhcp'. Default is 'static'.

- **provision_vcenter_vm_network_address**:
  - str, The private IP address the vcenter vm should use. Required if network mode is set to 'static'.

- **provision_vcenter_vm_network_prefix**:
  - str or int, The digit netmask the vcenter vm should use. For example '24'.  Required if network mode is set to 'static'.

- **provision_vcenter_vm_network_gateway**:
  - str or int, The gateway IP the vcenter vm should use. Required if network mode is set to 'static'.

- **provision_vcenter_vm_network_dns**:
  - list(str), A list of DNS servers the vcenter vm should use. Required if network mode is set to 'static'.

- **provision_vcenter_vm_network_ip_family**:
  - str, The IP family that the VM should use for its network. ipv4 or ipv6. Default is ipv4

- **provision_vcenter_vm_deployment_option**:
  - str, The deployment "size" for the vcenter appliance. See the VMWare documentation for the accepted values and their requirements. Default is tiny.

- **provision_vcenter_vm_enable_ssh**:
  - bool, Set to true to enable ssh on the vcenter appliance. Default is true.

- **provision_vcenter_vm_enable_ceip**:
  - bool, Set to true to opt into VMWares Customer Experience Improvement Program. Default is false.

## Dependencies

- NA

## Example Playbook
```yaml
---
- hosts: localhost
  roles:
    - role: provision_vcenter
      vars:
        provision_vcenter_validate_certs: false
        provision_vcenter_hostname: my-esxi-host.example  # or IP like 192.168.123.5
        provision_vcenter_username: root
        provision_vcenter_password: 'password'

        provision_vcenter_iso_path: /local/path/to/vcenter.iso

        provision_vcenter_vm_network_hostname: new-vcenter.example   # DNS must resolve on localhost
        provision_vcenter_vm_name: new-vcenter
        provision_vcenter_vm_password: 'SuperSecret1!'

        provision_vcenter_vm_datastore: ds1

        provision_vcenter_vm_network_name: VM Network
        provision_vcenter_vm_network_mode: static   # if set to dhcp, exclude the following variables
        provision_vcenter_vm_network_address: 192.168.123.90
        provision_vcenter_vm_network_prefix: 24
        provision_vcenter_vm_network_gateway: 192.168.123.1
        provision_vcenter_vm_network_dns:
          - 192.168.123.1
```

License
-------

GNU General Public License v3.0 or later

See [LICENCE](https://github.com/ansible-collections/cloud.aws_troubleshooting/blob/main/LICENSE) to see the full text.

Author Information
------------------

- Ansible Cloud Content Team
