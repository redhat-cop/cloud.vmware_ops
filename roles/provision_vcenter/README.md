# provision_vcenter

Provision a vCenter appliance on an ESXi host, using a vCenter ISO locally or VMX file on a datastore

## Dependencies

The vCenter Server Appliance ISO should be accessible from the host running these tasks, not necessarily the host onto which the appliance will be deployed. No customization of the ISO is required.

## Role Variables

### Auth

- **provision_vcenter_hostname** (str, required)
    - The hostname or IP address of the vSphere vCenter or ESXi host.
    - If this variable is not set, the collection level variable `vmware_ops_hostname` will be used. If that variable is not set, the environment variable `VMWARE_HOST` will be used. At least one of these variables must be set to use this role.
    - See the [authentication documentation](https://github.com/redhat-cop/cloud.vmware_ops/blob/main/docs/authentication.md) for examples.

- **provision_vcenter_username** (str, required)
    - The vSphere vCenter or ESXi host username.
    - If this variable is not set, the collection level variable `vmware_ops_username` will be used. If that variable is not set, the environment variable `VMWARE_USER` will be used. At least one of these variables must be set to use this role.
    - See the [authentication documentation](https://github.com/redhat-cop/cloud.vmware_ops/blob/main/docs/authentication.md) for examples.

- **provision_vcenter_password** (str, required)
    - The vSphere vCenter or ESXi host password.
    - If this variable is not set, the collection level variable `vmware_ops_password` will be used. If that variable is not set, the environment variable `VMWARE_PASSWORD` will be used. At least one of these variables must be set to use this role.
    - See the [authentication documentation](https://github.com/redhat-cop/cloud.vmware_ops/blob/main/docs/authentication.md) for examples.

- **provision_vcenter_validate_certs** (bool)
    - Allows connection when SSL certificates are not valid. Set to false when certificates are not trusted.
    - If this variable is not set, the collection level variable `vmware_ops_validate_certs` will be used. If that variable is not set, the environment variable `VMWARE_VALIDATE_CERTS` will be used.
    - See the [authentication documentation](https://github.com/redhat-cop/cloud.vmware_ops/blob/main/docs/authentication.md) for examples.

- **provision_vcenter_port** (int or str)
    - The port used to authenticate to the vSphere vCenter or ESXi host.
    - If this variable is not set, the collection level variable `vmware_ops_port` will be used. If that variable is not set, the environment variable `VMWARE_PORT` will be used.
    - See the [authentication documentation](https://github.com/redhat-cop/cloud.vmware_ops/blob/main/docs/authentication.md) for examples.

### Replication Options

- **provision_vcenter_replication_partner_hostname** (str)
    - The hostname of the already existing replication partner for sso. If set, replication will be configured during setup.

### Existing vCenter Target Options

- **provision_vcenter_vc_target_datacenter** (str)
    - The datacenter in which you want to deploy the appliance.
    - Only required when VM does not exist and you are deploying into an existing vCenter server.

- **provision_vcenter_vc_target_esxi_path** (str)
    - The path/name of the ESXi server on which you want to deploy the appliance.
    - Only required when VM does not exist and you are deploying into an existing vCenter server.
    - This value should be the name (or path) found in vCenter, which is not necessarily the same as the hostname

### Install Source

- **provision_vcenter_iso_path** (str)
    - The local path to the vCenter ISO.
    - Required if the VM does not already exist.

- **provision_vcenter_iso_mount_point** (str)
    - The local path that should be used as a mount point for the vCenter ISO. It will be created if it doesn't exist.
    - Default is `/tmp/vcenter_iso`

### VCSA VM

- **provision_vcenter_vm_name** (str, required)
    - The name for the vCenter vm, as seen in the web GUI.

- **provision_vcenter_vm_uuid** (str)
    - Specify the full VM UUID if multiple VMs in your cluster have the same name as `provision_vcenter_vm_name`.

- **provision_vcenter_vm_password** (str)
    - Specify the password used to access this appliance once it's deployed.
    - Required if the VM does not already exist.
    - This password is used for SSH access (username: root) if its enabled, as well as web GUI access (username: administrator@vsphere.local)

- **provision_vcenter_vm_datastore** (str)
    - The name of the datastore that the appliance should use to house its disks.
    - Required if the VM does not already exist.
    - The amount of required space varies by the appliance size (provision_vcenter_vm_deployment_option) and is always thin provisioned.

- **provision_vcenter_vm_network_name** (str)
    - The name of the network or portgroup to which this appliance should be connected.
    - Required if the VM does not already exist.

- **provision_vcenter_vm_network_hostname** (str, required)
    - The network hostname (https://your_hostname) for vCenter. DNS should already resolve on the localhost. Required.

- **provision_vcenter_vm_network_mode** (str)
    - The type of network mode the vCenter vm should use. Default is 'static'.
    - Choices: [`static`, `dhcp`]

- **provision_vcenter_vm_network_address** (str)
    - The private IP address the vCenter vm should use.
    - Required if network mode is set to 'static'.

- **provision_vcenter_vm_network_prefix** (str or int)
    - The digit netmask the vCenter vm should use. For example '24'.
    - Required if network mode is set to 'static'.

- **provision_vcenter_vm_network_gateway** (str)
    - The gateway IP the vCenter vm should use
    - Required if network mode is set to 'static'.

- **provision_vcenter_vm_network_dns** (list(str))
    - A list of DNS servers the vCenter vm should use.
    - Required if network mode is set to 'static'.

- **provision_vcenter_vm_ntp_server** (str)
    - Server to use for NTP source.

- **provision_vcenter_vm_network_ip_family** (str)
    - The IP family that the VM should use for its network.
    - Default is ipv4
    - Choices: [`ipv4`, `ipv6`]

- **provision_vcenter_vm_deployment_option** (str)
    - The deployment "size" for the vCenter appliance. See the VMware documentation for the accepted values and their requirements.
    - Default is tiny.

- **provision_vcenter_vm_enable_ssh** (bool)
    - Set to true to enable ssh on the vCenter appliance.
    - Default is true.

- **provision_vcenter_vm_enable_ceip** (bool)
    - Set to true to opt into VMwares Customer Experience Improvement Program.
    - Default is false.

## Examples

```yaml
---
- hosts: localhost
  roles:
    - role: cloud.vmware_ops.provision_vcenter
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

## License

GNU General Public License v3.0 or later

See [LICENSE](https://github.com/ansible-collections/cloud.aws_troubleshooting/blob/main/LICENSE) to see the full text.

## Author Information

- Ansible Cloud Content Team
