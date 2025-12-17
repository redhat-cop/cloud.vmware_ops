# deploy_custom_windows_template

Deploy a windows vm from a content library and customize it using windows sysprep

## Dependencies

N/A

## Role Variables

### Auth

- **deploy_custom_windows_template_hostname** (str, required)
    - The hostname or IP address of the vSphere vCenter.
    - If this variable is not set, the collection level variable `vmware_ops_hostname` will be used. If that variable is not set, the environment variable `VMWARE_HOST` will be used. At least one of these variables must be set to use this role.
    - See the [authentication documentation](https://github.com/redhat-cop/cloud.vmware_ops/blob/main/docs/authentication.md) for examples.

- **deploy_custom_windows_template_username** (str, required)
    - The vSphere vCenter username.
    - If this variable is not set, the collection level variable `vmware_ops_username` will be used. If that variable is not set, the environment variable `VMWARE_USER` will be used. At least one of these variables must be set to use this role.
    - See the [authentication documentation](https://github.com/redhat-cop/cloud.vmware_ops/blob/main/docs/authentication.md) for examples.

- **deploy_custom_windows_template_password** (str, required)
    - The vSphere vCenter password.
    - If this variable is not set, the collection level variable `vmware_ops_password` will be used. If that variable is not set, the environment variable `VMWARE_PASSWORD` will be used. At least one of these variables must be set to use this role.
    - See the [authentication documentation](https://github.com/redhat-cop/cloud.vmware_ops/blob/main/docs/authentication.md) for examples.

- **deploy_custom_windows_template_validate_certs** (bool)
    - Allows connection when SSL certificates are not valid. Set to false when certificates are not trusted.
    - If this variable is not set, the collection level variable `vmware_ops_validate_certs` will be used. If that variable is not set, the environment variable `VMWARE_VALIDATE_CERTS` will be used.
    - See the [authentication documentation](https://github.com/redhat-cop/cloud.vmware_ops/blob/main/docs/authentication.md) for examples.

- **deploy_custom_windows_template_port** (int or str)
    - The port used to authenticate to the vSphere vCenter that contains the cluster to configure.
    - If this variable is not set, the collection level variable `vmware_ops_port` will be used. If that variable is not set, the environment variable `VMWARE_PORT` will be used.
    - See the [authentication documentation](https://github.com/redhat-cop/cloud.vmware_ops/blob/main/docs/authentication.md) for examples.

### Proxy

- **deploy_custom_windows_template_proxy_host** (str)
    - The hostname of a proxy host that should be used for all HTTPs communication by the role.
    - The format is a hostname or an IP.
    - If this variable is not set, the collection level variable `vmware_ops_proxy_host` will be used. If that variable is not set, the environment variable `VMWARE_PROXY_HOST` will be used.
    - See the [authentication documentation](https://github.com/redhat-cop/cloud.vmware_ops/blob/main/docs/authentication.md) for examples.

- **deploy_custom_windows_template_proxy_port** (str or int)
    - The port of a proxy host that should be used for all HTTPs communication by the role
    - If this variable is not set, the collection level variable `vmware_ops_proxy_host` will be used. If that variable is not set, the environment variable `VMWARE_PROXY_PORT` will be used.
    - See the [authentication documentation](https://github.com/redhat-cop/cloud.vmware_ops/blob/main/docs/authentication.md) for examples.

### Deployment

- **deploy_custom_windows_template_vm_name** (str, required)
    - The name of the VM that should be deployed.

- **deploy_custom_windows_template_vm_folder** (str)
    - The folder path where the VM should be deployed.

- **deploy_custom_windows_template_datacenter** (str, required)
    - The datacenter name where the VM should be deployed.

- **deploy_custom_windows_template_cluster** (str)
    - The cluster name where the VM should be deployed. Either cluster or resource pool is required.

- **deploy_custom_windows_template_resource_pool** (str)
    - The resource pool name where the VM should be deployed. Either cluster or resource pool is required.

- **deploy_custom_windows_template_datastore** (str)
    - The datastore name where the VM should be deployed.

- **deploy_custom_windows_template_library_name** (str, required)
    - The name of the content library name where OVF template can be found.

- **deploy_custom_windows_template_library_item_name** (str, required)
    - The name of the OVF template in the content library that should be deployed.

### Customization

- **deploy_custom_windows_template_force_customization** (bool)
    - If true, customization will be applied even if the VM already exists. The VM must be in
      a powered off state with no pending customizations, otherwise an error will be thrown.
    - Default is `true`

- **deploy_custom_windows_template_domain_join_user** (str)
    - If true, customization will be applied even if the VM already exists. The VM must be in

- **deploy_custom_windows_template_domain_join_pass** (str)
    - If true, customization will be applied even if the VM already exists. The VM must be in

- **deploy_custom_windows_template_domain_join_name** (str)
    - If true, customization will be applied even if the VM already exists. The VM must be in

- **deploy_custom_windows_template_domain_join_ou** (str)
    - If true, customization will be applied even if the VM already exists. The VM must be in

- **deploy_custom_windows_template_post_customization_action** (str)
    - If true, customization will be applied even if the VM already exists. The VM must be in

- **deploy_custom_windows_template_gui_run_once_commands** (list(str))
    - If true, customization will be applied even if the VM already exists. The VM must be in

- **deploy_custom_windows_template_auto_logon** (bool)
    - If true, customization will be applied even if the VM already exists. The VM must be in
    - Default is `true`

- **deploy_custom_windows_template_auto_logon_count** (int)
    - If true, customization will be applied even if the VM already exists. The VM must be in
    - Default is `1`

- **deploy_custom_windows_template_sysprep_password** (str, required)
    - If true, customization will be applied even if the VM already exists. The VM must be in

- **deploy_custom_windows_template_sysprep_hostname** (str, required)
    - If true, customization will be applied even if the VM already exists. The VM must be in

- **deploy_custom_windows_template_workgroup** (str)
    - If true, customization will be applied even if the VM already exists. The VM must be in

- **deploy_custom_windows_template_users_full_name** (str, required)
    - If true, customization will be applied even if the VM already exists. The VM must be in

- **deploy_custom_windows_template_users_org_name** (str, required)
    - If true, customization will be applied even if the VM already exists. The VM must be in

- **deploy_custom_windows_template_users_product_id** (str, required)
    - If true, customization will be applied even if the VM already exists. The VM must be in

- **deploy_custom_windows_template_global_dns_servers** (list(str), required)
    - If true, customization will be applied even if the VM already exists. The VM must be in

- **deploy_custom_windows_template_global_dns_resolution_suffixes** (list(str), required)
    - If true, customization will be applied even if the VM already exists. The VM must be in

- **deploy_custom_windows_template_nic_specific_settings** (list(dict))
    - If true, customization will be applied even if the VM already exists. The VM must be in


## Examples

```yaml
---
- name: Deploy windows host
  hosts: localhost
  gather_facts: false
  vars:
    vm_name: win-vm-1
    local_admin_password: superSecret!123
    domain_admin_password: 123pass123
  roles:
    - role: cloud.vmware_ops.deploy_custom_windows_template
      deploy_custom_windows_template_hostname: vcenter.my.org
      deploy_custom_windows_template_username: admin
      deploy_custom_windows_template_password: password
      deploy_custom_windows_template_datacenter: DC01
      deploy_custom_windows_template_cluster: Cluster01
      deploy_custom_windows_template_library_name: ovf_template_content_library
      deploy_custom_windows_template_library_item_name: windows-2022-golden-template
      deploy_custom_windows_template_vm_name: "{{ vm_name }}"
      deploy_custom_windows_template_post_customization_action: reboot
      deploy_custom_windows_template_gui_run_once_commands:
        - powershell -command "winrm quickconfig /force"
        - powershell -command "set-netfirewallprofile -profile domain,private,public -enabled false"
        - powershell -Command "new-item -path c:\pstest.txt -type file"
        - shutdown -r
      deploy_custom_windows_template_auto_logon: true
      deploy_custom_windows_template_auto_logon_count: 1
      deploy_custom_windows_template_domain_join_user: myorg\domain_admin
      deploy_custom_windows_template_domain_join_pass: "{{ domain_admin_password }}"
      deploy_custom_windows_template_domain_join_name: my.org
      deploy_custom_windows_template_sysprep_password: "{{ local_admin_password }}"
      deploy_custom_windows_template_sysprep_hostname: "{{ vm_name }}"
      deploy_custom_windows_template_users_full_name: Bob Smith
      deploy_custom_windows_template_users_org_name: Contoso Org
      deploy_custom_windows_template_users_product_id: 1111-1111-1111-1111-1111
      deploy_custom_windows_template_global_dns_servers:
        - '8.8.8.8'
      deploy_custom_windows_template_global_dns_resolution_suffixes:
        - my.org
        - contoso.org
      deploy_custom_windows_template_nic_specific_settings:
        ipv4: {}  # dhcp
        ipv6:     # static
          gateways:
            - "fe80::3ca1:e11c:a903:d6f1"
          subnet_mask: 64
          address: "fe80::3ca1:e11c:a903:d6f1"
      deploy_custom_windows_template_force_customization: false

    # Host will get an IP in the middle of customization, so even once this succeeds the host is not
    # ready.
    - name: Wait for vm to get IP
      vmware.vmware.guest_info:
        name: "{{ vm_name }}"
      register: _vm_info
      until: _vm_info.guests[0].ipv4 is defined and _vm_info.guests[0].ipv4 is string
      retries: 20
      delay: 5

    - name: Add host
      ansible.builtin.add_host:
        name: "{{ vm_name }}"
        ansible_host: "{{ _vm_info.guests[0].ipv4 }}"
        ansible_user: myorg\domain_admin
        ansible_password: "{{ domain_admin_password }}"
        ansible_connection: winrm
        ansible_winrm_transport: ntlm
        ansible_winrm_server_cert_validation: ignore
        ansible_winrm_port: 5985


- name: Run against new host
  hosts: "{{ vm_name }}"
  tasks:
    - name: Wait for connection
      ansible.builtin.wait_for_connection:
        delay: 60
        timeout: 120
        sleep: 5
        connect_timeout: 30

    - name: Gather facts
      ansible.builtin.setup: {}
...
```

## License

GNU General Public License v3.0 or later

See [LICENSE](https://github.com/ansible-collections/cloud.aws_troubleshooting/blob/main/LICENSE) to see the full text.

## Author Information

- Ansible Cloud Content Team
