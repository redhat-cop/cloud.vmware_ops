# Provision virtual machine
A role to provision a virtual machine, create associated resources if they don't exist (subnets, vCPU, memory configuration, storage configuration, etc)
This includes cloning and building from VM templates.


## Requirements 
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

### Provisioning a VM
- **provision_vm_clone_from_vm** (boolean):
    Create from an existing VM

- **provision_vm_clone_from_template** (boolean):
    Create from template VM

- **provision_vm_vm_name**  (string, Required):
    Name of the virtual machine to work with.
    Virtual machine names in vCenter are not necessarily unique, which may be problematic, see O(name_match).
    If multiple virtual machines with same name exists, then O(folder) is required parameter to
    identify uniqueness of the virtual machine.
    This parameter is required, if (state=poweredon), (state=powered-on), (state=poweredoff), (state=powered-off),
    (state=present), (state=restarted), (state=suspended) and virtual machine does not exists.
    This parameter is case sensitive.

- **provision_vm_uuid**  (string):
    UUID of the virtual machine to manage if known, this is VMware's unique identifier.
    This is required if O(name) is not supplied.
    If virtual machine does not exists, then this parameter is ignored.
    Please note that a supplied UUID will be ignored on virtual machine creation, as VMware creates the UUID internally.

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

- **provision_vm_cluster** (String):
    The cluster name where the virtual machine will run.

  - **provision_vm_esxi_hostname** (string):
      The ESXi hostname where the virtual machine will run.
      This is a required parameter, if cluster is not set.
      esxi_hostname and cluster are mutually exclusive parameters.    
      This parameter is case sensitive.

- **provision_vm_datacenter** (string):
    Destination datacenter for the deploy operation.
    This parameter is case sensitive.
    Default: "ha-datacenter"

- **provision_vm_folder** (string):
    Destination folder, absolute path to find an existing guest or create the new guest.
    The folder should include the datacenter. ESXi's datacenter is ha-datacenter.
    This parameter is case sensitive.
    If multiple machines are found with same name, this parameter is used to identify
    uniqueness of the virtual machine.
  
- **provision_vm_datastore** (string):
    Specify datastore or datastore cluster to provision virtual machine.
    This parameter takes precedence over disk.datastore parameter.
    This parameter can be used to override datastore or datastore cluster setting of the virtual machine when deployed from the template.
    Please see example for more usage.

- **provision_vm_resource_pool** (string):
    Use the given resource pool for virtual machine operation.
    This parameter is case sensitive.
    Resource pool should be child of the selected host parent.
    When not specified Resources is taken as default value.

- **provision_vm_template** (string):
    Template or existing virtual machine used to create new virtual machine.
    If this value is not set, virtual machine is created without using a template.
    If the virtual machine already exists, this parameter will be ignored.
    This parameter is case sensitive.
    From version 2.8 onwards, absolute path to virtual machine or template can be used.

- **provision_vm_convert** (string):
    Specify convert disk type while cloning template or virtual machine.
    Choices:
    - "thin"
    - "thick"
    - "eagerzeroedthick"

- **provision_vm_linked_clone** (boolean):
    Whether to create a linked clone from the snapshot specified.
    If specified, then snapshot_src is required parameter.
    Choices:
    - false ← (default)
    - true

- **provision_vm_snapshot_src** (string):
    Name of the existing snapshot to use to create a clone of a virtual machine.
    This parameter is case sensitive.
    While creating linked clone using linked_clone parameter, this parameter is required.

- **provision_vm_advanced_settings** (list):
    Define a list of advanced settings to be added to the VMX config.
    An advanced settings object takes the two fields key and value.

- **provision_vm_annotation** (string):
    A note or annotation to include in the virtual machine.

- **provision_vm_cdrom** (list):
    A list of CD-ROM configurations for the virtual machine.
    For ide controller, hot-add or hot-remove CD-ROM is not supported.

    Element keys:
     * type:
        type: str
        description:
        - The type of CD-ROM.
        - With V(none) the CD-ROM will be disconnected but present.
        choices: [ 'none', 'client', 'iso' ]
        default: client
    * iso_path:
        type: str
        description:
        - The datastore path to the ISO file to use, in the form of C([datastore1] path/to/file.iso).
        - Required if type is set V(iso).
    * controller_type:
        type: str
        description:
        - When set to V(sata), please make sure O(cdrom.unit_number) is correct and not used by SATA disks.
        choices: [ 'ide', 'sata' ]
        default: ide
    * controller_number:
        type: int
        description:
        - For O(cdrom.controller_type=ide), valid value is 0 or 1.
        - For O(cdrom.controller_type=sata), valid value is 0 to 3.
    * unit_number:
        type: int
        description:
        - For O(cdrom.controller_type=ide), valid value is 0 or 1.
        - For O(cdrom.controller_type=sata), valid value is 0 to 29.
        - O(cdrom.controller_number) and O(cdrom.unit_number) are mandatory attributes.
    * state:
        type: str
        description:
        - If set to V(absent), then the specified CD-ROM will be removed.
        choices: [ 'present', 'absent' ]
        default: present

- **provision_vm_customization** (dictionary):
    Parameters for OS customization when cloning from the template or the virtual machine, or apply to the existing virtual machine directly.
    Not all operating systems are supported for customization with respective vCenter version, please check VMware documentation for respective OS customization.
    For supported customization operating system matrix, (see http://partnerweb.vmware.com/programs/guestOS/guest-os-customization-matrix.pdf)
    All parameters and VMware object names are case sensitive.
    Linux based OSes requires Perl package to be installed for OS customizations.
    
    Element keys:
    * existing_vm:
        type: bool
        description:
        - If set to V(true), do OS customization on the specified virtual machine directly.
        - Common for Linux and Windows customization.
    * dns_servers:
        type: list
        elements: str
        description:
        - List of DNS servers to configure.
        - Common for Linux and Windows customization.
    * dns_suffix:
        type: list
        elements: str
        description:
        - List of domain suffixes, also known as DNS search path.
        - Default C(domain) parameter.
        - Common for Linux and Windows customization.
    * domain:
        type: str
        description:
        - DNS domain name to use.
        - Common for Linux and Windows customization.
    * hostname:
        type: str
        description:
        - Computer hostname.
        - Default is shortened O(name) parameter.
        - Allowed characters are alphanumeric (uppercase and lowercase) and minus, rest of the characters are dropped as per RFC 952.
        - Common for Linux and Windows customization.
    * timezone:
        type: str
        description:
        - Timezone.
        - See List of supported time zones for different vSphere versions in Linux/Unix.
        - Common for Linux and Windows customization.
        - L(Windows, https://msdn.microsoft.com/en-us/library/ms912391.aspx).
    * hwclockUTC:
        type: bool
        description:
        - Specifies whether the hardware clock is in UTC or local time.
        - Specific to Linux customization.
    * script_text:
        type: str
        description:
        - Script to run with shebang.
        - Needs to be enabled in vmware tools with vmware-toolbox-cmd config set deployPkg enable-custom-scripts true
        - https://docs.vmware.com/en/VMware-vSphere/7.0/com.vmware.vsphere.vm_admin.doc/GUID-9A5093A5-C54F-4502-941B-3F9C0F573A39.html
        - Specific to Linux customization.
        version_added: '3.1.0'
    * autologon:
        type: bool
        description:
        - Auto logon after virtual machine customization.
        - Specific to Windows customization.
    * autologoncount:
        type: int
        description:
        - Number of autologon after reboot.
        - Specific to Windows customization.
        - Ignored if O(customization.autologon) is unset or set to O(customization.autologon=false).
        - If unset, 1 will be used.
    * domainadmin:
        type: str
        description:
        - User used to join in AD domain.
        - Required if O(customization.joindomain) specified.
        - Specific to Windows customization.
    * domainadminpassword:
        type: str
        description:
        - Password used to join in AD domain.
        - Required if O(customization.joindomain) specified.
        - Specific to Windows customization.
    * fullname:
        type: str
        description:
        - Server owner name.
        - Specific to Windows customization.
        - If unset, "Administrator" will be used as a fall-back.
    * joindomain:
        type: str
        description:
        - AD domain to join.
        - Not compatible with O(customization.joinworkgroup).
        - Specific to Windows customization.
    * joinworkgroup:
        type: str
        description:
        - Workgroup to join.
        - Not compatible with O(customization.joindomain).
        - Specific to Windows customization.
        - If unset, "WORKGROUP" will be used as a fall-back.
    * orgname:
        type: str
        description:
        - Organisation name.
        - Specific to Windows customization.
        - If unset, "ACME" will be used as a fall-back.
    * password:
        type: str
        description:
        - Local administrator password.
        - If not defined, the password will be set to blank (that is, no password).
        - Specific to Windows customization.
    * productid:
        type: str
        description:
        - Product ID.
        - Specific to Windows customization.
    * runonce:
        type: list
        elements: str
        description:
        - List of commands to run at first user logon.
        - Specific to Windows customization.


- **provision_vm_customization_spec** (string):
    Unique name identifying the requested customization specification.
    This parameter is case sensitive.
    If set, then overrides customization parameter values.

- **provision_vm_customvalues** (list)
    Define a list of custom values to set on virtual machine.
    A custom value object takes the two fields key and value.
    Incorrect key and values will be ignored.

- **provision_vm_delete_from_inventory** (boolean):
    Whether to delete Virtual machine from inventory or delete from disk.
    Choices:
    - false ← (default)
    - true

- **provision_vm_disk** (list):
    A list of disks to add.
    This parameter is case sensitive.
    Shrinking disks is not supported.
    Removing existing disks of the virtual machine is not supported.
    Attributes disk.controller_type, disk.controller_number, disk.unit_number are used to configure multiple types of disk controllers and disks for creating or reconfiguring virtual machine.
    
    Element keys:
    * size:
        description:
        - Disk storage size.
        - Please specify storage unit like [kb, mb, gb, tb].
        type: str
    * size_kb:
        description: Disk storage size in kb.
        type: int
    * size_mb:
        description: Disk storage size in mb.
        type: int
    * size_gb:
        description: Disk storage size in gb.
        type: int
    * size_tb:
        description: Disk storage size in tb.
        type: int
    * type:
        description:
        - Type of disk.
        - If not specified, disk type is inherited from the source VM or template when cloned and thick disk, no eagerzero otherwise.
        type: str
        choices: [ 'thin', 'thick', 'eagerzeroedthick' ]
    * datastore:
        type: str
        description:
        - The name of datastore which will be used for the disk.
        - If O(disk.autoselect_datastore) is set to True, will select the less used datastore whose name contains this "disk.datastore" string.
    * filename:
        type: str
        description:
        - Existing disk image to be used.
        - Filename must already exist on the datastore.
        - Specify filename string in C([datastore_name] path/to/file.vmdk) format.
    * autoselect_datastore:
        type: bool
        description:
        - Select the less used datastore.
        - O(disk.datastore) and O(disk.autoselect_datastore) will not be used if O(datastore) is specified outside this O(disk) configuration.
    * disk_mode:
        type: str
        choices: ['persistent', 'independent_persistent', 'independent_nonpersistent']
        description:
        - Type of disk mode.
        - If V(persistent) specified, changes are immediately and permanently written to the virtual disk. This is default.
        - If V(independent_persistent) specified, same as persistent, but not affected by snapshots.
        - If V(independent_nonpersistent) specified, changes to virtual disk are made to a redo log and discarded at power off,
          but not affected by snapshots.
    * controller_type:
        type: str
        choices: ['buslogic', 'lsilogic', 'lsilogicsas', 'paravirtual', 'sata', 'nvme']
        description:
        - Type of disk controller.
          Set this type on not supported ESXi or VM hardware version will lead to failure in deployment.
        - When set to V(sata), please make sure O(disk.unit_number) is correct and not used by SATA CDROMs.
        - If set to V(sata) type, please make sure O(disk.controller_number) and O(disk.unit_number) are set correctly when O(cdrom=sata).
    * controller_number:
        type: int
        choices: [0, 1, 2, 3]
        description:
        - Disk controller bus number.
        - The maximum number of same type controller is 4 per VM.
    * unit_number:
        type: int
        description:
        - Disk Unit Number.
        - Valid value range from 0 to 15 for SCSI controller, except 7.
        - Valid value range from 0 to 14 for NVME controller.
        - Valid value range from 0 to 29 for SATA controller.
        - O(disk.controller_type), O(disk.controller_number) and O(disk.unit_number) are required when creating or reconfiguring VMs
          with multiple types of disk controllers and disks.
        - When creating new VM, the first configured disk in the O(disk) list will be "Hard Disk 1".

- **provision_vm_encryption** (dictionary):
    Manage virtual machine encryption settings
    All parameters case sensitive.
    Element keys:
    * encrypted_vmotion:
        type: str
        description: Controls encryption for live migrations with vmotion
        choices: ['disabled', 'opportunistic', 'required']
    * encrypted_ft:
        type: str
        description: Controls encryption for fault tolerance replication
        choices: ['disabled', 'opportunistic', 'required']

- **provision_vm_force** (boolean):
    Ignore warnings and complete the actions.
    This parameter is useful while removing virtual machine which is powered on state.
    This module reflects the VMware vCenter API and UI workflow, as such, in some cases the `force` flag will be mandatory to perform the action to ensure you are certain the action has to be taken, no matter what the consequence. This is specifically the case for removing a powered on the virtual machine when state=absent.
    Choices:
    - false ← (default)
    - true

- **provision_vm_guest_id** (string):
    Set the guest ID.
    This parameter is case sensitive.
    This field is required when creating a virtual machine, not required when creating from the template.
    Valid values are referenced here: https://code.vmware.com/apis/358/doc/vim.vm.GuestOsDescriptor.GuestOsIdentifier.html

- **provision_vm_hardware** (dictionary):
    Manage virtual machine's hardware attributes.
    All parameters case sensitive.
    Keys:
    * hotadd_cpu:
        type: bool
        description: Allow virtual CPUs to be added while the virtual machine is running.
    * hotremove_cpu:
        type: bool
        description: Allow virtual CPUs to be removed while the virtual machine is running.
    * hotadd_memory:
        type: bool
        description: Allow memory to be added while the virtual machine is running.
    * memory_mb:
        type: int
        description: Amount of memory in MB.
    * num_cpus:
        type: int
        description:
        - Number of CPUs.
        - Must be a multiple of O(hardware.num_cpu_cores_per_socket).
        - For example, to create a VM with 2 sockets of 4 cores, specify O(hardware.num_cpus) as 8 and O(hardware.num_cpu_cores_per_socket) as 4.
    * num_cpu_cores_per_socket:
        type: int
        description: Number of Cores Per Socket.
    * cpu_shares_level:
        type: str
        choices: [ 'low', 'normal', 'high', 'custom' ]
        description:
        - The allocation level of CPU resources for the virtual machine.
        version_added: '3.2.0'
    * cpu_shares:
        type: int
        description:
        - The number of shares of CPU allocated to this virtual machine
        - cpu_shares_level will automatically be set to 'custom'
        version_added: '3.2.0'
    * vpmc_enabled:
        version_added: '3.2.0'
        type: bool
        description: Enable virtual CPU Performance Counters.
    * scsi:
        type: str
        description:
        - Valid values are V(buslogic), V(lsilogic), V(lsilogicsas) and V(paravirtual).
        - V(paravirtual) is default.
        choices: [ 'buslogic', 'lsilogic', 'lsilogicsas', 'paravirtual' ]
    * secure_boot:
        type: bool
        description: Whether to enable or disable (U)EFI secure boot.
    * memory_reservation_lock:
        type: bool
        description:
        - If set V(true), memory resource reservation for the virtual machine.
    * max_connections:
        type: int
        description:
        - Maximum number of active remote display connections for the virtual machines.
    * mem_limit:
        type: int
        description:
        - The memory utilization of a virtual machine will not exceed this limit.
        - Unit is MB.
    * mem_reservation:
        type: int
        description: The amount of memory resource that is guaranteed available to the virtual machine.
        aliases: [ 'memory_reservation' ]
    * mem_shares_level:
        type: str
        description:
        - The allocation level of memory resources for the virtual machine.
        choices: [ 'low', 'normal', 'high', 'custom' ]
        version_added: '3.2.0'
    * mem_shares:
        type: int
        description:
        - The number of shares of memory allocated to this virtual machine
        - mem_shares_level will automatically be set to 'custom'
        version_added: '3.2.0'
    * cpu_limit:
        type: int
        description:
        - The CPU utilization of a virtual machine will not exceed this limit.
        - Unit is MHz.
    * cpu_reservation:
        type: int
        description: The amount of CPU resource that is guaranteed available to the virtual machine.
    * version:
        type: str
        description:
        - The Virtual machine hardware versions.
        - Default is 10 (ESXi 5.5 and onwards).
        - If set to V(latest), the specified virtual machine will be upgraded to the most current hardware version supported on the host.
        - Please check VMware documentation for correct virtual machine hardware version.
        - Incorrect hardware version may lead to failure in deployment. If hardware version is already equal to the given.
    * boot_firmware:
        type: str
        description: Choose which firmware should be used to boot the virtual machine.
        choices: [ 'bios', 'efi' ]
    * nested_virt:
        type: bool
        description:
        - Enable nested virtualization.
    * virt_based_security:
        type: bool
        description:
        - Enable Virtualization Based Security feature for Windows on ESXi 6.7 and later, from hardware version 14.
        - Supported Guest OS are Windows 10 64 bit, Windows Server 2016, Windows Server 2019 and later.
        - The firmware of virtual machine must be EFI and secure boot must be enabled.
        - Virtualization Based Security depends on nested virtualization and Intel Virtualization Technology for Directed I/O.
        - Deploy on unsupported ESXi, hardware version or firmware may lead to failure or deployed VM with unexpected configurations.
    * iommu:
        type: bool
        description: Flag to specify if I/O MMU is enabled for this virtual machine.

- **provision_vm_state** (string):
    Specify the state the virtual machine should be in.
    If present and virtual machine exists, ensure the virtual machine configurations conforms to task arguments.
    If absent and virtual machine exists, then the specified virtual machine is removed with it's associated components.
    If set to one of poweredon, powered-on, poweredoff, powered-off, present, restarted, suspended and virtual machine does not exists, virtual machine is deployed with the given parameters.
    If set to poweredon or powered-on and virtual machine exists with powerstate other than powered on, then the specified virtual machine is powered on.
    If set to poweredoff or powered-off and virtual machine exists with powerstate other than powered off, then the specified virtual machine is powered off.
    If set to restarted and virtual machine exists, then the virtual machine is restarted.
    If set to suspended and virtual machine exists, then the virtual machine is set to suspended mode.
    If set to shutdownguest or shutdown-guest and virtual machine exists, then the virtual machine is shutdown.
    If set to rebootguest or reboot-guest and virtual machine exists, then the virtual machine is rebooted.
    Choices:
    - "absent"
    - "poweredon"
    - "powered-on"
    - "poweredoff"
    - "powered-off"
    - "present" ← (default)
    - "rebootguest"
    - "reboot-guest"
    - "restarted"
    - "suspended"
    - "shutdownguest"
    - "shutdown-guest"

- **provision_vm_state_change_timeout** (integer):
    If the state=shutdownguest, by default the module will return immediately after sending the shutdown signal.
    If this argument is set to a positive integer, the module will instead wait for the virtual machine to reach the poweredoff state.
    The value sets a timeout in seconds for the module to wait for the state change.
    Default: 0

- **provision_vm_vapp_properties** (list):
    A list of vApp properties.
    For full list of attributes and types refer to: https://code.vmware.com/apis/704/vsphere/vim.vApp.PropertyInfo.html
    Element keys:
    * id:
      type: str
      description:
      - Property ID.
      - Required per entry.
    * value:
        type: str
        description:
        - Property value.
    * type:
        type: str
        description:
        - Value type, string type by default.
    * operation:
        type: str
        description:
        - The C(remove) attribute is required only when removing properties.

- **provision_vm_wait_for_customization** (boolean):
    Wait until vCenter detects all guest customizations as successfully completed.
    When enabled, the VM will automatically be powered on.
    If vCenter does not detect guest customization start or succeed, failed events after time wait_for_customization_timeout parameter specified, warning message will be printed and task result is fail.
    Choices:
    - false ← (default)
    - true

- **provision_vm_wait_for_customization_timeout** (integer):
    Define a timeout (in seconds) for the wait_for_customization parameter.
    Be careful when setting this value since the time guest customization took may differ among guest OSes.
    Default: 3600

- **provision_vm_wait_for_ip_address** (boolean):
    Wait until vCenter detects an IP address for the virtual machine.
    This requires vmware-tools (vmtoolsd) to properly work after creation.
    vmware-tools needs to be installed on the given virtual machine in order to work with this parameter.
    Choices:
    - false ← (default)
    - true

- **provision_vm_wait_for_ip_address_timeout** (integer):
    Define a timeout (in seconds) for the wait_for_ip_address parameter.
    Default: 300


- **provision_vm_networks** (list):
    A list of networks (in the order of the NICs).
    Removing NICs is not allowed, while reconfiguring the virtual machine.
    All parameters and VMware object names are case sensitive.
    The type, ip, netmask, gateway, domain, dns_servers options don't set to a guest when creating a blank new virtual machine. They are set by the customization via vmware-tools. If you want to set the value of the options to a guest, you need to clone from a template with installed OS and vmware-tools(also Perl when Linux).
    Element keys:
    * name:
        type: str
        description:
        - Name of the portgroup or distributed virtual portgroup for this interface.
        - Required per entry.
        - When specifying distributed virtual portgroup make sure given O(esxi_hostname) or O(cluster) is associated with it.
    * vlan:
        type: int
        description:
        - VLAN number for this interface.
        - Required per entry.
    * device_type:
        type: str
        description:
        - Virtual network device.
        - Valid value can be one of C(e1000), C(e1000e), C(pcnet32), C(vmxnet2), C(vmxnet3), C(sriov).
        - C(vmxnet3) is default.
        - Optional per entry.
        - Used for virtual hardware.
    * mac:
        type: str
        description:
        - Customize MAC address.
        - Optional per entry.
        - Used for virtual hardware.
    * dvswitch_name:
        type: str
        description:
        - Name of the distributed vSwitch.
        - Optional per entry.
        - Used for virtual hardware.
    * type:
        type: str
        description:
        - Type of IP assignment.
        - Valid values are one of C(dhcp), C(static).
        - C(dhcp) is default.
        - Optional per entry.
        - Used for OS customization.
    * ip:
        type: str
        description:
        - Static IP address. Implies C(type=static).
        - Optional per entry.
        - Used for OS customization.
    * netmask:
        type: str
        description:
        - Static netmask required for C(ip).
        - Optional per entry.
        - Used for OS customization.
    * gateway:
        type: str
        description:
        - Static gateway.
        - Optional per entry.
        - Used for OS customization.
    * typev6:
        version_added: '4.1.0'
        type: str
        description:
        - Type of IP assignment.
        - Valid values are one of C(dhcp), C(static).
        - C(dhcp) is default.
        - Optional per entry.
        - Used for OS customization.
    * ipv6:
        version_added: '4.1.0'
        type: str
        description:
        - Static IP address. Implies C(type=static).
        - Optional per entry.
        - Used for OS customization.
    * netmaskv6:
        version_added: '4.1.0'
        type: str
        description:
        - Static netmask required for C(ip).
        - Optional per entry.
        - Used for OS customization.
    * gatewayv6:
        version_added: '4.1.0'
        type: str
        description:
        - Static gateway.
        - Optional per entry.
        - Used for OS customization.
    * dns_servers:
        type: str
        description:
        - DNS servers for this network interface (Windows).
        - Optional per entry.
        - Used for OS customization.
    * domain:
        type: str
        description:
        - Domain name for this network interface (Windows).
        - Optional per entry.
        - Used for OS customization.
    * connected:
        type: bool
        description:
        - Indicates whether the NIC is currently connected.
    * start_connected:
        type: bool
        description:
        - Specifies whether or not to connect the device when the virtual machine starts.

- **provision_vm_nvdimm** (dictionary):
    Add or remove a virtual NVDIMM device to the virtual machine.
    VM virtual hardware version must be 14 or higher on vSphere 6.7 or later.
    Verify that guest OS of the virtual machine supports PMem before adding virtual NVDIMM device.
    Verify that you have the Datastore.Allocate space privilege on the virtual machine.
    Make sure that the host or the cluster on which the virtual machine resides has available PMem resources.
    To add or remove virtual NVDIMM device to the existing virtual machine, it must be in power off state.
    Keys:
    * state:
         type: str
         description:
         - If set to V(absent), then the NVDIMM device with specified O(nvdimm.label) will be removed.
         choices: ['present', 'absent']
    * size_mb:
        type: int
        description: Virtual NVDIMM device size in MB.
        default: 1024
    * label:
         type: str
         description:
         - The label of the virtual NVDIMM device to be removed or configured, e.g., "NVDIMM 1".
         - 'This parameter is required when O(nvdimm.state=absent), or O(nvdimm.state=present) to reconfigure NVDIMM device
           size. When add a new device, please do not set.'

- **provision_vm_use_instance_uuid** (boolean):
    Whether to use the VMware instance UUID rather than the BIOS UUID.
    Choices:
    - false ← (default)
    - true

- **provision_vm_name_match** (string):

    If multiple virtual machines matching the name, use the first or last found.
    Choices:
    - "first" ← (default)
    - "last"


## Dependencies

N/A

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
        name: cloud.vmware_ops.provision_virtual_machine
      vars:
        aa: "{{ }}"
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