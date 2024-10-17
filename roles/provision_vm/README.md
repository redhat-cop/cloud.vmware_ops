# provision_vm
A role to provision a virtual machine and create associated resources if they don't exist (subnets, vCPU, memory configuration, storage configuration, etc).
This includes cloning and building from VM templates.


## Dependencies

N/A


## Role Variables

### Auth

- **provision_vm_hostname** (str, required)
    - The hostname or IP address of the vSphere vCenter or ESXi host.
    - If this variable is not set, the collection level variable `vmware_ops_hostname` will be used. If that variable is not set, the environment variable `VMWARE_HOST` will be used. At least one of these variables must be set to use this role.
    - See the [authentication documentation](https://github.com/redhat-cop/cloud.vmware_ops/blob/main/docs/authentication.md) for examples.

- **provision_vm_username** (str, required)
    - The vSphere vCenter or ESXi host username.
    - If this variable is not set, the collection level variable `vmware_ops_username` will be used. If that variable is not set, the environment variable `VMWARE_USER` will be used. At least one of these variables must be set to use this role.
    - See the [authentication documentation](https://github.com/redhat-cop/cloud.vmware_ops/blob/main/docs/authentication.md) for examples.

- **provision_vm_password** (str, required)
    - The vSphere vCenter or ESXi host password.
    - If this variable is not set, the collection level variable `vmware_ops_password` will be used. If that variable is not set, the environment variable `VMWARE_PASSWORD` will be used. At least one of these variables must be set to use this role.
    - See the [authentication documentation](https://github.com/redhat-cop/cloud.vmware_ops/blob/main/docs/authentication.md) for examples.

- **provision_vm_validate_certs** (bool)
    - Allows connection when SSL certificates are not valid. Set to false when certificates are not trusted.
    - If this variable is not set, the collection level variable `vmware_ops_validate_certs` will be used. If that variable is not set, the environment variable `VMWARE_VALIDATE_CERTS` will be used.
    - See the [authentication documentation](https://github.com/redhat-cop/cloud.vmware_ops/blob/main/docs/authentication.md) for examples.

- **provision_vm_port** (int or str)
    - The port used to authenticate to the vSphere vCenter or ESXi host.
    - If this variable is not set, the collection level variable `vmware_ops_port` will be used. If that variable is not set, the environment variable `VMWARE_PORT` will be used.
    - See the [authentication documentation](https://github.com/redhat-cop/cloud.vmware_ops/blob/main/docs/authentication.md) for examples.

### Proxy

- **provision_vm_proxy_host** (str)
    - The hostname of a proxy host that should be used for all HTTPs communication by the role.
    - The format is a hostname or an IP.
    - If this variable is not set, the collection level variable `vmware_ops_proxy_host` will be used. If that variable is not set, the environment variable `VMWARE_PROXY_HOST` will be used.
    - See the [authentication documentation](https://github.com/redhat-cop/cloud.vmware_ops/blob/main/docs/authentication.md) for examples.

- **provision_vm_proxy_port** (str or int)
    - The port of a proxy host that should be used for all HTTPs communication by the role
    - If this variable is not set, the collection level variable `vmware_ops_proxy_host` will be used. If that variable is not set, the environment variable `VMWARE_PROXY_PORT` will be used.
    - See the [authentication documentation](https://github.com/redhat-cop/cloud.vmware_ops/blob/main/docs/authentication.md) for examples.

### Provisioning a VM

- **provision_vm_name** (str, required)
    - Name of the virtual machine to manage.
    - Virtual machine names in vCenter are not necessarily unique which may be problematic.
      If multiple virtual machines with the same name exist, then `provision_vm_folder` is required parameter to
      identify uniqueness of the virtual machine. You can also set `provision_vm_name_match` to control how multiple matching VM names are handled.
    - The parameter is required if the virtual machine does not already exist.
    - This parameter is case sensitive.

- **provision_vm_uuid** (str)
    - The instance UUID of the virtual machine to manage.
    - This is required if `provision_vm_name` is not supplied.
    - Note that a supplied UUID will be ignored on virtual machine creation, as VMware creates the UUID internally.
      If virtual machine does not exist, then this parameter is ignored.

- **provision_vm_cluster** (str)
    - The name of the cluster where the virtual machine will run.

- **provision_vm_esxi_hostname** (str)
    - The ESXi hostname where the virtual machine will run. This is a required parameter if `provision_vm_cluster` is not set.
    - `provision_vm_esxi_hostname` and `provision_vm_cluster` are mutually exclusive parameters.
    - This parameter is case sensitive.

- **provision_vm_datacenter** (str)
    - The name of the datacenter where the virtual machine will run.
    - This parameter is case sensitive.
    - Default is "ha-datacenter"

- **provision_vm_folder** (str)
    - Absolute path to the folder where the VM will exist.
    - The folder should include the datacenter. A single ESXi's datacenter is `ha-datacenter`.
    - This parameter is case sensitive.
    - If multiple machines are found with same name, this parameter is used to identify uniqueness of the virtual machine.

- **provision_vm_datastore** (str)
    - Specify datastore or datastore cluster to use for the virtual machine backend storage.
    - This parameter takes precedence over the `provision_vm_disk.datastore` parameter.
    - This parameter can be used to override datastore or datastore cluster setting of the virtual machine when deploying from a template.
    - Please see the examples for more usage.

- **provision_vm_resource_pool** (str)
    - The name of a resource pool in which the VM should exist.
    - This parameter is case sensitive.
    - The resource pool should be child of the selected ESXi host or cluster.

- **provision_vm_template** (str)
    - A template or existing virtual machine that should be used to create the new virtual machine.
    - If this value is not set, the virtual machine is created without using a template.
    - If the virtual machine already exists, this parameter will be ignored.
    - This parameter is case sensitive.
    - This can be the name of the template or the absolute folder path to the template

- **provision_vm_convert** (str)
    - Specify if the disk should be converted to a new type while cloning an existing template or virtual machine.
    - Choices: [`thin`, `thick`, `eagerzeroedthick`]

- **provision_vm_linked_clone** (bool)
    - Specify if the clone should be linked to the snapshot from which it was created.
    - If specified, then `provision_vm_snapshot_src` is required.
    - Choices: [`true`, `false`]

- **provision_vm_snapshot_src** (str)
    - Name of the existing snapshot to clone and use to create a new virtual machine.
    - This parameter is case sensitive.
    - This parameter is required when using the `provision_vm_linked_clone` parameter.

- **provision_vm_advanced_settings** (list)
    - Define a list of advanced settings to be added to the VMX config.
    - Each element in the advanced settings list should include `key` and `value` attributes.
    - Example: `[{key: foo, value: bar}]`

- **provision_vm_annotation** (str)
    - A note or annotation to include in the virtual machine metadata.

- **provision_vm_cdrom** (list(dict))
    - A list of CD-ROM configurations for the virtual machine.
    - For ide controllers, hot-adding or hot-removing CD-ROMs is not supported.
    - **Elements**
        - `type`: str, The type of CD-ROM. When `none` the CD-ROM will be disconnected but present. Choices: [`none`, `client`, `iso`]. Default is client
        - `iso_path`: str, The datastore path to the ISO file to use, in the form of `[datastore1] path/to/file.iso`. Required if type is set `iso`.
        - `controller_type`: str, When set to `sata`, please make sure `unit_number` is correct and not used by SATA disks. Choices: [ `ide`, `sata` ]. Default is ide
        - `controller_number`: int, If `controller_type` is `ide`, valid value is 0 or 1. If `controller_type` is `sata`, valid value is 0 to 3.
        - `unit_number`: int, If `controller_type` is `ide`, valid value is 0 or 1. If `controller_type` is `sata`, valid value is 0 to 29. `controller_number` and `unit_number` are mandatory attributes.
        - `state`: str, If set to `absent`, then the specified CD-ROM will be removed. Choices: [ `present`, `absent` ]. Default is present

- **provision_vm_customization** (dict)
    - Set parameters for OS customization when cloning from a template or a virtual machine, or apply customization to an existing virtual machine. Customization will be applied when the VM is powered on next.
    - Not all operating systems are supported for customization depending on the vCenter version, please check VMware documentation.
    - For the supported customization operating system matrix, see http://partnerweb.vmware.com/programs/guestOS/guest-os-customization-matrix.pdf
    - All parameters and VMware object names are case sensitive.
    - Linux OSes require the perl package to be installed for the `script_text` OS customization.
    - **Elements**
        - `existing_vm`: bool, If set to `true`, apply OS customization directly to the specified virtual machine.
        - `dns_servers`: list(str), List of DNS servers to configure.
        - `dns_suffix`: list(str), List of domain suffixes, also known as DNS search path. Default value is the `domain`
        - `domain`: str, DNS domain name to use.
        - `hostname`: str, Computer hostname. Default is shortened `provision_vm_name` parameter. Allowed characters are alphanumeric (uppercase and lowercase) and minus, rest of the characters are dropped as per RFC 952.
        - `timezone`: str, Timezone. See List of supported time zones for different vSphere versions in Linux/Unix. For Windows, see https://msdn.microsoft.com/en-us/library/ms912391.aspx
        - `hwclockUTC`: bool, Specifies whether the hardware clock is in UTC or local time. Specific to Linux customization.
        - `script_text`: str, Script to run with shebang. Needs to be enabled in vmware tools with `vmware-toolbox-cmd config set deployPkg enable-custom-scripts true`. See https://docs.vmware.com/en/VMware-vSphere/7.0/com.vmware.vsphere.vm_admin.doc/GUID-9A5093A5-C54F-4502-941B-3F9C0F573A39.html. Specific to Linux customization.
        - `autologon`: bool, Auto logon after virtual machine customization. Specific to Windows customization.
        - `autologoncount`: int, Number of autologon after reboot. Specific to Windows customization. Ignored if `autologon` is unset or set to `false`. If unset, 1 will be used.
        - `domainadmin`: str, User used to join the AD domain. Required if `joindomain` is specified. Specific to Windows customization.
        - `domainadminpassword`: str, Password used to join the AD domain. Required if `joindomain` is specified. Specific to Windows customization.
        - `fullname`: str, Server owner name. Specific to Windows customization. Default is "Administrator"
        - `joindomain`: str, AD domain to join. Not compatible with `joinworkgroup`. Specific to Windows customization.
        - `joinworkgroup`: str, Workgroup to join. Not compatible with `joindomain`. Specific to Windows customization. Default is "WORKGROUP"
        - `orgname`: str, Organization name. Specific to Windows customization. Default is "ACME"
        - `password`: str, Local administrator password. If not defined, the password will be set to blank (that is, no password). Specific to Windows customization.
        - `productid`: str, Product ID. Specific to Windows customization.
        - `runonce`: list(str), List of commands to run at first user logon. Specific to Windows customization.

- **provision_vm_customization_spec** (str)
    - Unique name identifying the requested customization specification.
    - This parameter is case sensitive.
    - If set, this overrides customization parameter values.

- **provision_vm_customvalues** (list)
    - Define a list of custom values to set on virtual machine.
    - Each element in the list should have a `key` and `value` attribute.
    - Incorrect key and values will be ignored.
    - Example `[{key: foo, value: bar}]`

- **provision_vm_delete_from_inventory** (bool)
    - If true the virtual machine's disks will not be deleted when `provision_vm_state` is `absent`, but the VM will still be removed from the vSphere inventory.

- **provision_vm_disk** (list)
    - A list of disks to add.
    - This parameter is case sensitive.
    - Shrinking disks is not supported.
    - Removing existing disks of the virtual machine is not supported.
    - Attributes `controller_type`, `controller_number`, and `unit_number` are used to configure multiple types of disk controllers and disks for creating or reconfiguring virtual machine.
    - `controller_type`, `controller_number` and `unit_number` are required when creating or reconfiguring VMs with multiple types of disk controllers and disks.
    - When creating new VM, the first configured disk in the `provision_vm_disk` list will be "Hard Disk 1".
    - **Elements**
        - `size`: str, Disk storage size. You should include the storage unit such as 100kb, 100mb, etc
        - `size_kb`:  int, Disk storage size in kb.
        - `size_mb`: int, Disk storage size in mb.
        - `size_gb`: int, Disk storage size in gb.
        - `size_tb`: int, Disk storage size in tb.
        - `type`: str, Type of disk. If not specified, disk type is inherited from the source VM or template when cloned and thick disk, no eagerzero otherwise. Choices: [ `thin`, `thick`, `eagerzeroedthick` ]
        - `datastore`: str, The name of datastore which will be used for the disk. If `autoselect_datastore` is set to True, will select the less used datastore whose name contains this `datastore` string.
        - `filename`: str, Existing disk image to be used. Filename must already exist on the datastore. Specify filename string in `[datastore_name] path/to/file.vmdk` format.
        - `autoselect_datastore`: bool, Select the less used datastore. `datastore` and `autoselect_datastore` will not be used if `provision_vm_datastore` is specified.
        - `disk_mode`: str, Choices: [`persistent`, `independent_persistent`, `independent_nonpersistent`]. Type of disk mode. If `persistent` is specified, changes are immediately and permanently written to the virtual disk. This is default. If `independent_persistent` is specified, same as persistent, but not affected by snapshots. If `independent_nonpersistent` is specified, changes to virtual disk are made to a redo log and discarded at power off, but not affected by snapshots.
        - `controller_type`: str, Choices: [`buslogic`, `lsilogic`, `lsilogicsas`, `paravirtual`, `sata`, `nvme`]. Type of disk controller. Setting this type on not supported ESXi or VM hardware version will lead to deployment failure. If set to `sata` type, please make sure `controller_number` and `unit_number` do not conflict with sata values in `provison_vm_cdrom`.
        - `controller_number`: int, Choices: [`0`, `1`, `2`, `3`], Disk controller bus number. The maximum number of same type controller is 4 per VM.
        - `unit_number`: int, Disk Unit Number. Valid value range from 0 to 15 for SCSI controller, except 7. Valid value range from 0 to 14 for NVME controller. Valid value range from 0 to 29 for SATA controller.

- **provision_vm_encryption** (dict)
    - Manage virtual machine encryption settings
    - All parameters case sensitive.
    - **Elements**
        - `encrypted_vmotion`: str, Controls encryption for live migrations with vmotion. Choices: [`disabled`, `opportunistic`, `required`]
        - `encrypted_ft`: str, Controls encryption for fault tolerance replication. Choices: [`disabled`, `opportunistic`, `required`]

- **provision_vm_force** (bool)
    - Ignore warnings and complete the actions.
    - This parameter is useful while removing a virtual machine that is the powered on state.

- **provision_vm_guest_id** (str)
    - Set the guest ID.
    - This parameter is case sensitive.
    - This field is required when creating a new virtual machine and not required when creating from the template.
    - Valid values are referenced [here](https://vdc-download.vmware.com/vmwb-repository/dcr-public/184bb3ba-6fa8-4574-a767-d0c96e2a38f4/ba9422ef-405c-47dd-8553-e11b619185b2/SDK/vsphere-ws/docs/ReferenceGuide/vim.vm.GuestOsDescriptor.GuestOsIdentifier.html).

- **provision_vm_hardware** (dict)
    - Manage virtual machine's hardware attributes.
    - All parameters case sensitive.
    - **Elements**
        - `hotadd_cpu`: bool, Allow virtual CPUs to be added while the virtual machine is running. Must be set when the VM is first created and is powered off.
        - `hotremove_cpu`: bool, Allow virtual CPUs to be removed while the virtual machine is running. Must be set when the VM is first created and is powered off.
        - `hotadd_memory`: bool, Allow memory to be added while the virtual machine is running. Must be set when the VM is first created and is powered off.
        - `memory_mb`: int, Amount of memory in MB.
        - `num_cpus`: int, Number of CPUs. Must be a multiple of `num_cpu_cores_per_socket` For example, to create a VM with 2 sockets of 4 cores, specify `num_cpus` as 8 and `num_cpu_cores_per_socket` as 4.
        - `num_cpu_cores_per_socket`: int, Number of Cores Per Socket.
        - `cpu_shares_level`: str, Choices: [`low`, `normal`, `high`, `custom`], The allocation level of CPU resources for the virtual machine.
        - `cpu_shares`: int, The number of shares of CPU allocated to this virtual machine. cpu_shares_level will automatically be set to 'custom'
        - `vpmc_enabled`: bool, Enable virtual CPU Performance Counters.
        - `scsi`: str, The type of scsi device to use. Default is paravirtual. Choices: [`buslogic`, `lsilogic`, `lsilogicsas`, `paravirtual`]
        - `secure_boot`: bool, Whether to enable or disable (U)EFI secure boot.
        - `memory_reservation_lock`: bool, If set true, memory resource reservation for the virtual machine.
        - `max_connections`: int, Maximum number of active remote display connections for the virtual machines.
        - `mem_limit`: int, The memory utilization of a virtual machine will not exceed this limit. Units are in MB.
        - `mem_reservation`: int, The amount of memory resource that is guaranteed available to the virtual machine. Aliases: [`memory_reservation`]
        - `mem_shares_level`: str, The allocation level of memory resources for the virtual machine. Choices: [`low`, `normal`, `high`, `custom`]
        - `mem_shares`: int, The number of shares of memory allocated to this virtual machine. `mem_shares_level` will automatically be set to 'custom'
        - `cpu_limit`: int, The CPU utilization of a virtual machine will not exceed this limit. Units are in MHz.
        - `cpu_reservation`: int, The amount of CPU resource that is guaranteed available to the virtual machine.
        - `version`: str, The Virtual machine hardware versions. Default is 10 (ESXi 5.5 and onwards). If set to latest, the specified virtual machine will be upgraded to the most current hardware version supported on the host.  Please check VMware documentation for correct virtual machine hardware version. Incorrect hardware version may lead to failure in deployment. If hardware version is already equal to the given.
        - `boot_firmware`: str, Choose which firmware should be used to boot the virtual machine. Choices: [`bios`, `efi`]
        - `nested_virt`: bool, Enable nested virtualization capabilities.
        - `virt_based_security`: bool, Enable Virtualization Based Security feature for Windows on ESXi 6.7 and later, from hardware version 14. Supported Guest OS are Windows 10 64 bit, Windows Server 2016, Windows Server 2019 and later. The firmware of virtual machine must be EFI and secure boot must be enabled. Virtualization Based Security depends on nested virtualization and Intel Virtualization Technology for Directed I/O. Deploying on unsupported ESXi, hardware version or firmware may lead to failure or deployed VM with unexpected configurations.
        - `iommu`: bool, Flag to specify if I/O MMU is enabled for this virtual machine.

- **provision_vm_state** (str)
    - Specify the state the virtual machine should be in.
    - If set to `present` and the virtual machine exists, ensure the virtual machine configurations conform to task arguments.
    - If set to `absent` and the virtual machine exists, then the specified virtual machine is removed with its associated components.
    - If set to one of `poweredon`, `powered-on`, `poweredoff`, `powered-off`, `present`, `restarted` or `suspended` and virtual machine does not exist, the virtual machine is deployed with the given parameters.
    - If set to `poweredon` or `powered-on` and the virtual machine exists with powerstate other than powered on, then the specified virtual machine is powered on.
    - If set to `poweredoff` or `powered-off` and virtual machine exists with powerstate other than powered off, then the specified virtual machine is powered off.
    - If set to `restarted` and the virtual machine exists, then the virtual machine is restarted.
    - If set to `suspended` and the virtual machine exists, then the virtual machine is set to suspended mode.
    - If set to `shutdownguest` or `shutdown-guest` and the virtual machine exists, then the virtual machine is shutdown.
    - If set to `rebootguest` or `reboot-guest` and the virtual machine exists, then the virtual machine is rebooted.
    - Choices: [`absent`, `poweredon`, `powered-on`, `poweredoff`, `powered-off`, `present`, `rebootguest`, `reboot-guest`, `restarted`, `suspended`, `shutdownguest`, `shutdown-guest`]

- **provision_vm_state_change_timeout** (int)
    - If `provision_vm_state` is `shutdownguest`, the module will return immediately after sending the shutdown signal.
    - If this argument is set to a positive integer, the module will wait for the virtual machine to reach the poweredoff state.
    - Default is 0

- **provision_vm_vapp_properties** (list)
    - A list of vApp properties.
    - For full list of attributes and types refer to [vApp Properties info](https://vdc-download.vmware.com/vmwb-repository/dcr-public/184bb3ba-6fa8-4574-a767-d0c96e2a38f4/ba9422ef-405c-47dd-8553-e11b619185b2/SDK/vsphere-ws/docs/ReferenceGuide/vim.vApp.PropertyInfo.html)
    - **Elements**
        - `id`: str, Property ID. Required per entry.
        - `value`: str, Property value.
        - `type`: str, Value type, string type by default.
        - `operation`: str, Set to `remove` when removing properties.

- **provision_vm_wait_for_customization** (bool)
    - Wait until vCenter detects all guest customizations completed successfully.
    - When enabled, the VM will automatically be powered on.
    - If vCenter does not detect guest customization or failed events after time `provision_vm_wait_for_customization_timeout` parameter specified, warning message will be printed and the role will fail.
    - Choices: [`true`, `false`]

- **provision_vm_wait_for_customization_timeout** (int)
    - Define a timeout (in seconds) for the `provision_vm_wait_for_customization` parameter.
    - Be careful when setting this value since the guest customization time may differ among guest OSes.
    - Default is 3600

- **provision_vm_wait_for_ip_address** (bool)
    - Wait until vCenter detects an IP address for the virtual machine.
    - This requires vmware-tools (vmtoolsd) on the virtual machine.
    - Choices: [`true`, `false`]

- **provision_vm_wait_for_ip_address_timeout** (int)
    - Define a timeout (in seconds) for the `provision_vm_wait_for_ip_address` parameter.
    - Default is 300


- **provision_vm_networks** (list)
    - A list of network cards to attach (in the order of the NICs).
    - Removing NICs is not allowed while reconfiguring the virtual machine.
    - All parameters and VMware object names are case sensitive.
    - The `type`, `ip`, `netmask`, `gateway`, `domain`, and `dns_servers` options are not directly applied to the virtual machine. They are used when customization is run via vmware-tools. See `provision_vm_customization`.
    - **Elements**
        - `name`: str, Name of the portgroup or distributed virtual portgroup for this interface. Required per entry. When specifying distributed virtual portgroup make sure the given `provision_vm_esxi_hostname` or `provision_vm_cluster` is associated with it.
        - `vlan`: int, VLAN number for this interface. Required per entry.
        - `device_type`: str, Virtual network device type. Default is vmxnet3. Choices: [`e1000`, `e1000e`, `pcnet32`, `vmxnet2`, `vmxnet3`, `sriov`]
        - `mac`: str, Customize MAC address.
        - `dvswitch_name`: str, Name of the distributed vSwitch.
        - `type`: str, Type of IP assignment. Default is dhcp. Choices: [`dhcp`, `static`]
        - `ip`: str, Static IP address. Only used if `type` is `static`.
        - `netmask`: str, Static netmask required if `ip` is set.
        - `gateway`: str, Static gateway.
        - `typev6`: str, Type of IPv6 assignment. Default is dhcp. Choices: [`static`, `dhcp`]
        - `ipv6`: str, Static IP address. Only used if `type` is `static`
        - `netmaskv6`: str, Static netmask required if `ipv6` is set.
        - `gatewayv6`: str, Static gateway
        - `dns_servers`: str, DNS servers for this network interface (Windows).
        - `domain`: str, Domain name for this network interface (Windows).
        - `connected`: bool, Indicates whether the NIC is currently connected.
        - `start_connected`: bool, Specifies whether or not to connect the device when the virtual machine starts.

- **provision_vm_nvdimm** (dict)
    - Add or remove a virtual NVDIMM device to the virtual machine.
    - VM virtual hardware version must be 14 or higher on vSphere 6.7 or later.
    - Verify that guest OS of the virtual machine supports PMem before adding virtual NVDIMM device.
    - Verify that you have the Datastore.Allocate space privilege on the virtual machine.
    - Make sure that the host or the cluster on which the virtual machine resides has available PMem resources.
    - To add or remove virtual NVDIMM device to the existing virtual machine, it must be in power off state.
    - **Elements**
        - `state`: str, `present` or `absent`. If set to `absent`, then the NVDIMM device with specified `label` will be removed.
        - `size_mb`: int, Virtual NVDIMM device size in MB. Default is 1024.
        - `label`: str, The label of the virtual NVDIMM device to be removed or configured, e.g., "NVDIMM 1". This parameter is required when `provision_vm_nvdimm.state` is `absent` or `present` to reconfigure NVDIMM device size. When adding a new device, please do not set.

- **provision_vm_use_instance_uuid** (bool)
    - Whether to use the VMware instance UUID instead of the BIOS UUID.

- **provision_vm_name_match** (str)
    - If multiple virtual machines matching the name, use the first or last found.
    - Choices: [`first`, `last`]

- **provision_vm_is_template** (bool)
    - If true, the VM will be created as a template instead of a regular VM.
    - Default is false

## Examples

All the variables defined in section [Role Variables](#role-variables) can be defined inside the ``vars.yml`` file.

Create a ``playbook.yml`` file like this:

```yaml
---
- hosts: localhost
  gather_facts: true

  tasks:
    - name: Provision a VM
      ansible.builtin.import_role:
        name: cloud.vmware_ops.provision_vm
      vars:
        provision_vm_hostname: "test"
        provision_vm_username: "test"
        provision_vm_password: "test"
        provision_vm_validate_certs: false
        provision_vm_cluster: "DC0_C0"
        provision_vm_folder: "/DC0/vm"
        provision_vm_datacenter: "DC0"
        provision_vm_name: "vm-test"
        provision_vm_port: "8989"
        provision_vm_disk:
        - size_gb: 10
          type: thin
          datastore: "LocalDS_0"
        provision_vm_hardware:
          memory_mb: 512
          num_cpus: 4
        provision_vm_guest_id: "rhel9_64Guest"
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
