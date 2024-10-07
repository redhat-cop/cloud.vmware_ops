# provision_vm
A role to provision a virtual machine and create associated resources if they don't exist (subnets, vCPU, memory configuration, storage configuration, etc).
This includes cloning and building from VM templates.


## Dependencies

N/A


## Role Variables
### Auth
- **provision_vm_username**: (string, Required)
  - The vSphere vCenter username.

- **provision_vm_password**: (string, Required)
  - The vSphere vCenter password.

- **provision_vm_hostname**: (string, Required)
  - The hostname or IP address of the vSphere vCenter.

- **provision_vm_validate_certs** (boolean)
  - Allows connection when SSL certificates are not valid. Set to false when certificates are not trusted.
    Default: true

- **provision_vm_port** (integer):
    The port number of the vSphere vCenter or ESXi server.
    If the value is not specified in the task, the value of environment variable VMWARE_PORT will be used instead.
    Default: 443

- **provision_vm_proxy_host** (string):
    Address of a proxy that will receive all HTTPS requests and relay them.
    The format is a hostname or a IP.
    If the value is not specified in the task, the value of environment variable VMWARE_PROXY_HOST will be used instead.

- **provision_vm_proxy_port** (integer):
    Port of the HTTP proxy that will receive all HTTPS requests and relay them.
    If the value is not specified in the task, the value of environment variable VMWARE_PROXY_PORT will be used instead.

### Provisioning a VM
- **provision_vm_name**  (string, Required):
    - Name of the virtual machine to manage.
    - Virtual machine names in vCenter are not necessarily unique which may be problematic.
      If multiple virtual machines with the same name exist, then `provision_vm_folder` is required parameter to
      identify uniqueness of the virtual machine. You can also set `provision_vm_name_match` to control how multiple matching VM names are handled.
    - The parameter is required if the virtual machine does not already exist.
    - This parameter is case sensitive.

- **provision_vm_uuid**  (string):
    - The instance UUID of the virtual machine to manage.
    - This is required if `provision_vm_name` is not supplied.
    - Note that a supplied UUID will be ignored on virtual machine creation, as VMware creates the UUID internally.
      If virtual machine does not exist, then this parameter is ignored.

- **provision_vm_cluster** (String):
    - The name of the cluster where the virtual machine will run.

- **provision_vm_esxi_hostname** (string):
    - The ESXi hostname where the virtual machine will run. This is a required parameter if `provision_vm_cluster` is not set.
    - `provision_vm_esxi_hostname` and `provision_vm_cluster` are mutually exclusive parameters.
    - This parameter is case sensitive.

- **provision_vm_datacenter** (string):
    - The name of the datacenter where the virtual machine will run.
    - This parameter is case sensitive.
    - Default: "ha-datacenter"

- **provision_vm_folder** (string):
    - Absolute path to the folder where the VM will exist.
    - The folder should include the datacenter. A single ESXi's datacenter is `ha-datacenter`.
    - This parameter is case sensitive.
    - If multiple machines are found with same name, this parameter is used to identify uniqueness of the virtual machine.

- **provision_vm_datastore** (string):
    - Specify datastore or datastore cluster to use for the virtual machine backend storage.
    - This parameter takes precedence over the `provision_vm_disk.datastore` parameter.
    - This parameter can be used to override datastore or datastore cluster setting of the virtual machine when deploying from a template.
    - Please see the examples for more usage.

- **provision_vm_resource_pool** (string):
    - The name of a resource pool in which the VM should exist.
    - This parameter is case sensitive.
    - The resource pool should be child of the selected ESXi host or cluster.

- **provision_vm_template** (string):
    - A template or existing virtual machine that should be used to create the new virtual machine.
    - If this value is not set, the virtual machine is created without using a template.
    - If the virtual machine already exists, this parameter will be ignored.
    - This parameter is case sensitive.
    - This can be the name of the template or the absolute folder path to the template

- **provision_vm_convert** (string):
    - Specify if the disk should be converted to a new type while cloning an existing template or virtual machine.
    - Choices:
        - "thin"
        - "thick"
        - "eagerzeroedthick"

- **provision_vm_linked_clone** (boolean):
    - Specify if the clone should be linked to the snapshot from which it was created.
    - If specified, then `provision_vm_snapshot_src` is required.
    - Choices:
        - false (default)
        - true

- **provision_vm_snapshot_src** (string):
    - Name of the existing snapshot to clone and use to create a new virtual machine.
    - This parameter is case sensitive.
    - This parameter is required when using the `provision_vm_linked_clone` parameter.

- **provision_vm_advanced_settings** (list):
    - Define a list of advanced settings to be added to the VMX config.
    - Each element in the advanced settings list should include `key` and `value` attributes.
    - Example: `[{key: foo, value: bar}]`

- **provision_vm_annotation** (string):
    - A note or annotation to include in the virtual machine metadata.

- **provision_vm_cdrom** (list):
    - A list of CD-ROM configurations for the virtual machine.
    - For ide controllers, hot-adding or hot-removing CD-ROMs is not supported.
    - Each element in the list is a dictionary, described below.
    * type:
        - type: str
        - description:
            - The type of CD-ROM.
            - When `none` the CD-ROM will be disconnected but present.
        - choices: [ 'none', 'client', 'iso' ]
        - default: client
    * iso_path:
        - type: str
        - description:
            - The datastore path to the ISO file to use, in the form of `[datastore1] path/to/file.iso`.
            - Required if type is set `iso`.
    * controller_type:
        - type: str
        - description:
            - When set to `sata`, please make sure `unit_number` is correct and not used by SATA disks.
        - choices: [ 'ide', 'sata' ]
        - default: ide
    * controller_number:
        - type: int
        - description:
            - If `controller_type` is `ide`, valid value is 0 or 1.
            - If `controller_type` is `sata`, valid value is 0 to 3.
    * unit_number:
        - type: int
        - description:
            - If `controller_type` is `ide`, valid value is 0 or 1.
            - If `controller_type` is `sata`, valid value is 0 to 29.
            - `controller_number` and `unit_number` are mandatory attributes.
    * state:
        - type: str
        - description:
            - If set to `absent`, then the specified CD-ROM will be removed.
        - choices: [ 'present', 'absent' ]
        - default: present

- **provision_vm_customization** (dictionary):
    - Set parameters for OS customization when cloning from a template or a virtual machine, or apply customization to an existing virtual machine. Customization will be applied when the VM is powered on next.
    - Not all operating systems are supported for customization depending on the vCenter version, please check VMware documentation.
    - For the supported customization operating system matrix, see http://partnerweb.vmware.com/programs/guestOS/guest-os-customization-matrix.pdf
    - All parameters and VMware object names are case sensitive.
    - Linux OSes require the perl package to be installed for the `script_text` OS customization.
    - Dictionary elements are described below
    * existing_vm:
        - type: bool
        - description:
            - If set to `true`, apply OS customization directly to the specified virtual machine.
    * dns_servers:
        - type: list
        - elements: str
        - description:
            - List of DNS servers to configure.
    * dns_suffix:
        - type: list
        - elements: str
        - description:
            - List of domain suffixes, also known as DNS search path.
            - Default value is the `domain`
    * domain:
        - type: str
        - description:
            - DNS domain name to use.
    * hostname:
        - type: str
        - description:
            - Computer hostname.
            - Default is shortened `provision_vm_name` parameter.
            - Allowed characters are alphanumeric (uppercase and lowercase) and minus, rest of the characters are dropped as per RFC 952.
    * timezone:
        - type: str
        - description:
            - Timezone.
            - See List of supported time zones for different vSphere versions in Linux/Unix.
            - For Windows, see https://msdn.microsoft.com/en-us/library/ms912391.aspx
    * hwclockUTC:
        - type: bool
        - description:
            - Specifies whether the hardware clock is in UTC or local time.
            - Specific to Linux customization.
    * script_text:
        - type: str
        - description:
            - Script to run with shebang.
            - Needs to be enabled in vmware tools with `vmware-toolbox-cmd config set deployPkg enable-custom-scripts true`
            - https://docs.vmware.com/en/VMware-vSphere/7.0/com.vmware.vsphere.vm_admin.doc/GUID-9A5093A5-C54F-4502-941B-3F9C0F573A39.html
            - Specific to Linux customization.
        - version_added: '3.1.0'
    * autologon:
        - type: bool
        - description:
            - Auto logon after virtual machine customization.
            - Specific to Windows customization.
    * autologoncount:
        - type: int
        - description:
            - Number of autologon after reboot.
            - Specific to Windows customization.
            - Ignored if `autologon` is unset or set to `false`.
            - If unset, 1 will be used.
    * domainadmin:
        - type: str
        - description:
            - User used to join the AD domain.
            - Required if `joindomain` is specified.
            - Specific to Windows customization.
    * domainadminpassword:
        - type: str
        - description:
            - Password used to join the AD domain.
            - Required if `joindomain` is specified.
            - Specific to Windows customization.
    * fullname:
        - type: str
        - description:
            - Server owner name.
            - Specific to Windows customization.
            - Default is "Administrator"
    * joindomain:
        - type: str
        - description:
            - AD domain to join.
            - Not compatible with `joinworkgroup`.
            - Specific to Windows customization.
    * joinworkgroup:
        - type: str
        - description:
            - Workgroup to join.
            - Not compatible with `joindomain`.
            - Specific to Windows customization.
            - Default is "WORKGROUP"
    * orgname:
        - type: str
        - description:
            - Organization name.
            - Specific to Windows customization.
            - Default is "ACME"
    * password:
        - type: str
        - description:
            - Local administrator password.
            - If not defined, the password will be set to blank (that is, no password).
            - Specific to Windows customization.
    * productid:
        - type: str
        - description:
            - Product ID.
            - Specific to Windows customization.
    * runonce:
        - type: list
        - elements: str
        - description:
            - List of commands to run at first user logon.
            - Specific to Windows customization.

- **provision_vm_customization_spec** (string):
    - Unique name identifying the requested customization specification.
    - This parameter is case sensitive.
    - If set, this overrides customization parameter values.

- **provision_vm_customvalues** (list)
    - Define a list of custom values to set on virtual machine.
    - Each element in the list should have a `key` and `value` attribute.
    - Incorrect key and values will be ignored.
    - Example `[{key: foo, value: bar}]`

- **provision_vm_delete_from_inventory** (boolean):
    - If true the virtual machine's disks will not be deleted when `provision_vm_state` is `absent`, but the VM will still be removed from the vSphere inventory.
    - Choices:
        - false (default)
        - true

- **provision_vm_disk** (list):
    - A list of disks to add.
    - This parameter is case sensitive.
    - Shrinking disks is not supported.
    - Removing existing disks of the virtual machine is not supported.
    - Attributes `controller_type`, `controller_number`, and `unit_number` are used to configure multiple types of disk controllers and disks for creating or reconfiguring virtual machine.
    - Each item in the list may have the following attributes:
    * size:
        - description:
            - Disk storage size.
            - You should include the storage unit such as 100kb, 100mb, etc
        - type: str
    * size_kb:
        - description: Disk storage size in kb.
        - type: int
    * size_mb:
        - description: Disk storage size in mb.
        - type: int
    * size_gb:
        - description: Disk storage size in gb.
        - type: int
    * size_tb:
        - description: Disk storage size in tb.
        - type: int
    * type:
        - description:
            - Type of disk.
            - If not specified, disk type is inherited from the source VM or template when cloned and thick disk, no eagerzero otherwise.
        - type: str
        - choices: [ 'thin', 'thick', 'eagerzeroedthick' ]
    * datastore:
        - type: str
        - description:
            - The name of datastore which will be used for the disk.
            - If `autoselect_datastore` is set to True, will select the less used datastore whose name contains this `datastore` string.
    * filename:
        - type: str
        - description:
            - Existing disk image to be used.
            - Filename must already exist on the datastore.
            - Specify filename string in `[datastore_name] path/to/file.vmdk` format.
    * autoselect_datastore:
        - type: bool
        - description:
            - Select the less used datastore.
            - `datastore` and `autoselect_datastore` will not be used if `provision_vm_datastore` is specified.
    * disk_mode:
        - type: str
        - choices: ['persistent', 'independent_persistent', 'independent_nonpersistent']
        - description:
            - Type of disk mode.
            - If `persistent` is specified, changes are immediately and permanently written to the virtual disk. This is default.
            - If `independent_persistent` is specified, same as persistent, but not affected by snapshots.
            - If `independent_nonpersistent` is specified, changes to virtual disk are made to a redo log and discarded at power off, but not affected by snapshots.
    * controller_type:
        - type: str
        - choices: ['buslogic', 'lsilogic', 'lsilogicsas', 'paravirtual', 'sata', 'nvme']
        - description:
            - Type of disk controller.
            - Set this type on not supported ESXi or VM hardware version will lead to failure in deployment.
            - If set to `sata` type, please make sure `controller_number` and `unit_number` do not conflict with sata values in `provison_vm_cdrom`.
    * controller_number:
        - type: int
        - choices: [0, 1, 2, 3]
        - description:
            - Disk controller bus number.
            - The maximum number of same type controller is 4 per VM.
    * unit_number:
        - type: int
        - description:
            - Disk Unit Number.
            - Valid value range from 0 to 15 for SCSI controller, except 7.
            - Valid value range from 0 to 14 for NVME controller.
            - Valid value range from 0 to 29 for SATA controller.
            - `controller_type`, `controller_number` and `unit_number` are required when creating or reconfiguring VMs with multiple types of disk controllers and disks.
            - When creating new VM, the first configured disk in the `provision_vm_disk` list will be "Hard Disk 1".

- **provision_vm_encryption** (dictionary):
    - Manage virtual machine encryption settings
    - All parameters case sensitive.
    - The dictionary may have the following attributes:
    * encrypted_vmotion:
        - type: str
        - description: Controls encryption for live migrations with vmotion
        - choices: ['disabled', 'opportunistic', 'required']
    * encrypted_ft:
        - type: str
        - description: Controls encryption for fault tolerance replication
        - choices: ['disabled', 'opportunistic', 'required']

- **provision_vm_force** (boolean):
    - Ignore warnings and complete the actions.
    - This parameter is useful while removing virtual machine which is powered on state.
    - Choices:
        - false
        - true

- **provision_vm_guest_id** (string):
    - Set the guest ID.
    - This parameter is case sensitive.
    - This field is required when creating a new virtual machine and not required when creating from the template.
    - Valid values are referenced [here](https://vdc-download.vmware.com/vmwb-repository/dcr-public/184bb3ba-6fa8-4574-a767-d0c96e2a38f4/ba9422ef-405c-47dd-8553-e11b619185b2/SDK/vsphere-ws/docs/ReferenceGuide/vim.vm.GuestOsDescriptor.GuestOsIdentifier.html).

- **provision_vm_hardware** (dictionary):
    - Manage virtual machine's hardware attributes.
    - All parameters case sensitive.
    - The dictionary may have the following attributes:
    * hotadd_cpu:
        - type: bool
        - description:
            - Allow virtual CPUs to be added while the virtual machine is running.
            - Must be set when the VM is first created and is powered off.
    * hotremove_cpu:
        - type: bool
        - description:
            - Allow virtual CPUs to be removed while the virtual machine is running.
            - Must be set when the VM is first created and is powered off.
    * hotadd_memory:
        - type: bool
        - description:
            - Allow memory to be added while the virtual machine is running.
            - Must be set when the VM is first created and is powered off.
    * memory_mb:
        - type: int
        - description: Amount of memory in MB.
    * num_cpus:
        - type: int
        - description:
            - Number of CPUs.
            - Must be a multiple of `num_cpu_cores_per_socket`
            - For example, to create a VM with 2 sockets of 4 cores, specify `num_cpus` as 8 and `num_cpu_cores_per_socket` as 4.
    * num_cpu_cores_per_socket:
        - type: int
        - description: Number of Cores Per Socket.
    * cpu_shares_level:
        - type: str
        - choices: [ 'low', 'normal', 'high', 'custom' ]
        - description:
            - The allocation level of CPU resources for the virtual machine.
        - version_added: '3.2.0'
    * cpu_shares:
        - type: int
        - description:
            - The number of shares of CPU allocated to this virtual machine
            - cpu_shares_level will automatically be set to 'custom'
        - version_added: '3.2.0'
    * vpmc_enabled:
        - version_added: '3.2.0'
        - type: bool
        - description: Enable virtual CPU Performance Counters.
    * scsi:
        - type: str
        - description:
            - The type of scsi device to use.
            - Default is paravirtual
        choices: [ 'buslogic', 'lsilogic', 'lsilogicsas', 'paravirtual' ]
    * secure_boot:
        - type: bool
        - description: Whether to enable or disable (U)EFI secure boot.
    * memory_reservation_lock:
        - type: bool
        - description:
            - If set true, memory resource reservation for the virtual machine.
    * max_connections:
        - type: int
        - description:
            - Maximum number of active remote display connections for the virtual machines.
    * mem_limit:
        - type: int
        - description:
            - The memory utilization of a virtual machine will not exceed this limit.
            - Units are in MB.
    * mem_reservation:
        - type: int
        - description: The amount of memory resource that is guaranteed available to the virtual machine.
        - aliases: [ 'memory_reservation' ]
    * mem_shares_level:
        - type: str
        - description:
            - The allocation level of memory resources for the virtual machine.
        - choices: [ 'low', 'normal', 'high', 'custom' ]
        - version_added: '3.2.0'
    * mem_shares:
        - type: int
        - description:
            - The number of shares of memory allocated to this virtual machine
            - `mem_shares_level` will automatically be set to 'custom'
        - version_added: '3.2.0'
    * cpu_limit:
        - type: int
        - description:
            - The CPU utilization of a virtual machine will not exceed this limit.
            - Units are in MHz.
    * cpu_reservation:
        - type: int
        - description: The amount of CPU resource that is guaranteed available to the virtual machine.
    * version:
        - type: str
        - description:
            - The Virtual machine hardware versions.
            - Default is 10 (ESXi 5.5 and onwards).
            - If set to latest, the specified virtual machine will be upgraded to the most current hardware version supported on the host.
            - Please check VMware documentation for correct virtual machine hardware version.
            - Incorrect hardware version may lead to failure in deployment. If hardware version is already equal to the given.
    * boot_firmware:
        - type: str
        - description: Choose which firmware should be used to boot the virtual machine.
        - choices: [ 'bios', 'efi' ]
    * nested_virt:
        - type: bool
        - description: Enable nested virtualization capabbilities.
    * virt_based_security:
        - type: bool
        - description:
            - Enable Virtualization Based Security feature for Windows on ESXi 6.7 and later, from hardware version 14.
            - Supported Guest OS are Windows 10 64 bit, Windows Server 2016, Windows Server 2019 and later.
            - The firmware of virtual machine must be EFI and secure boot must be enabled.
            - Virtualization Based Security depends on nested virtualization and Intel Virtualization Technology for Directed I/O.
            - Deploy on unsupported ESXi, hardware version or firmware may lead to failure or deployed VM with unexpected configurations.
    * iommu:
        - type: bool
        - description: Flag to specify if I/O MMU is enabled for this virtual machine.

- **provision_vm_state** (string):
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
    - Choices:
        - "absent"
        - "poweredon"
        - "powered-on"
        - "poweredoff"
        - "powered-off"
        - "present" (default)
        - "rebootguest"
        - "reboot-guest"
        - "restarted"
        - "suspended"
        - "shutdownguest"
        - "shutdown-guest"

- **provision_vm_state_change_timeout** (integer):
    - If `provision_vm_state` is `shutdownguest`, the module will return immediately after sending the shutdown signal.
    - If this argument is set to a positive integer, the module will wait for the virtual machine to reach the poweredoff state.
    - Default: 0

- **provision_vm_vapp_properties** (list):
    - A list of vApp properties.
    - For full list of attributes and types refer to [vApp Properties info](https://vdc-download.vmware.com/vmwb-repository/dcr-public/184bb3ba-6fa8-4574-a767-d0c96e2a38f4/ba9422ef-405c-47dd-8553-e11b619185b2/SDK/vsphere-ws/docs/ReferenceGuide/vim.vApp.PropertyInfo.html)
    - Each element in the provided list may have the following attributes:
    * id:
        - type: str
        - description:
            - Property ID.
            - Required per entry.
    * value:
        - type: str
        - description:
            - Property value.
    * type:
        - type: str
        - description:
            - Value type, string type by default.
    * operation:
        - type: str
        - description:
            - Set to `remove` when removing properties.

- **provision_vm_wait_for_customization** (boolean):
    - Wait until vCenter detects all guest customizations completed successfully.
    - When enabled, the VM will automatically be powered on.
    - If vCenter does not detect guest customization or failed events after time `provision_vm_wait_for_customization_timeout` parameter specified, warning message will be printed and the role will fail.
    - Choices:
        - false
        - true

- **provision_vm_wait_for_customization_timeout** (integer):
    - Define a timeout (in seconds) for the `provision_vm_wait_for_customization` parameter.
    - Be careful when setting this value since the guest customization time may differ among guest OSes.
    - Default: 3600

- **provision_vm_wait_for_ip_address** (boolean):
    - Wait until vCenter detects an IP address for the virtual machine.
    - This requires vmware-tools (vmtoolsd) on the virtual machine.
    - Choices:
        - false (default)
        - true

- **provision_vm_wait_for_ip_address_timeout** (integer):
    - Define a timeout (in seconds) for the `provision_vm_wait_for_ip_address` parameter.
    - Default: 300


- **provision_vm_networks** (list):
    - A list of network cards to attach (in the order of the NICs).
    - Removing NICs is not allowed while reconfiguring the virtual machine.
    - All parameters and VMware object names are case sensitive.
    - The `type`, `ip`, `netmask`, `gateway`, `domain`, and `dns_servers` options are not directly applied to the virtual machine. They are used when customization is run via vmware-tools. See `provision_vm_customization`.
    - Each element in the list of networks can have the following attributes:
    * name:
        - type: str
        - description:
            - Name of the portgroup or distributed virtual portgroup for this interface.
            - Required per entry.
            - When specifying distributed virtual portgroup make sure the given `provision_vm_esxi_hostname` or `provision_vm_cluster` is associated with it.
    * vlan:
        - type: int
        - description:
            - VLAN number for this interface.
            - Required per entry.
    * device_type:
        - type: str
        - description:
            - Virtual network device type.
            - Default is vmxnet3
        - Choices: [e1000, e1000e, pcnet32, vmxnet2, vmxnet3, sriov]
    * mac:
        - type: str
        - description:
            - Customize MAC address.
            - Optional per entry.
    * dvswitch_name:
        - type: str
        - description:
            - Name of the distributed vSwitch.
            - Optional per entry.
    * type:
        - type: str
        - description:
            - Type of IP assignment.
            - Default is dhcp
        - choices: [dhcp, static]
    * ip:
        - type: str
        - description:
            - Static IP address. Only used if `type` is `static`
            - Optional per entry.
    * netmask:
        - type: str
        - description:
            - Static netmask required if `ip` is set.
            - Optional per entry.
    * gateway:
        - type: str
        - description:
            - Static gateway
            - Optional per entry.
    * typev6:
        - version_added: '4.1.0'
        - type: str
        - description:
            - Type of IPv6 assignment.
            - Optional per entry.
            - Default is dhcp
        - choices: [static, dhcp]
    * ipv6:
        - version_added: '4.1.0'
        - type: str
        - description:
            - Static IP address. Only used if `type` is `static`
            - Optional per entry.
    * netmaskv6:
        - version_added: '4.1.0'
        - type: str
        - description:
            - Static netmask required if `ipv6` is set.
            - Optional per entry.
    * gatewayv6:
        - version_added: '4.1.0'
        - type: str
        - description:
            - Static gateway
            - Optional per entry.
    * dns_servers:
        - type: str
        - description:
            - DNS servers for this network interface (Windows).
            - Optional per entry.
    * domain:
        - type: str
        - description:
            - Domain name for this network interface (Windows).
            - Optional per entry.
    * connected:
        - type: bool
        - description:
            - Indicates whether the NIC is currently connected.
    * start_connected:
        - type: bool
        - description:
            - Specifies whether or not to connect the device when the virtual machine starts.

- **provision_vm_nvdimm** (dictionary):
    - Add or remove a virtual NVDIMM device to the virtual machine.
    - VM virtual hardware version must be 14 or higher on vSphere 6.7 or later.
    - Verify that guest OS of the virtual machine supports PMem before adding virtual NVDIMM device.
    - Verify that you have the Datastore.Allocate space privilege on the virtual machine.
    - Make sure that the host or the cluster on which the virtual machine resides has available PMem resources.
    - To add or remove virtual NVDIMM device to the existing virtual machine, it must be in power off state.
    - The dictionary should have the following structure:
    * state:
        - type: str
        - description:
            - If set to `absent`, then the NVDIMM device with specified `label` will be removed.
        - choices: ['present', 'absent']
    * size_mb:
        - type: int
        - description: Virtual NVDIMM device size in MB.
        - default: 1024
    * label:
        - type: str
        - description:
            - The label of the virtual NVDIMM device to be removed or configured, e.g., "NVDIMM 1".
            - This parameter is required when `provision_vm_nvdimm.state` is `absent` or `present` to reconfigure NVDIMM device
              size. When add a new device, please do not set.

- **provision_vm_use_instance_uuid** (boolean):
    - Whether to use the VMware instance UUID instead of the BIOS UUID.
    - Choices:
        - false (default)
        - true

- **provision_vm_name_match** (string):
    - If multiple virtual machines matching the name, use the first or last found.
    - Choices:
        - "first" (default)
        - "last"

- **provision_vm_is_template** (bool):
    - If true, the VM will be created as a template instead of a regular VM.
    - Default: false


## Example Playbook

All the variables defined in section [Role Variables](#role-variables) can be defined inside the ``vars.yml`` file.

Create a ``playbook.yml`` file like this:

```
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
