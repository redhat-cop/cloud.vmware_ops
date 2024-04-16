# manage_vcenter_host_connection

Add, remove, connect, disconnect, or reconnect an ESXi host from a VCenter

## Requirements

pyvomi

## Role Variables

### Auth
- **manage_vcenter_host_connection_hostname**:
  - str, The hostname of the vcenter to which you want to connect. Required

- **manage_vcenter_host_connection_username**:
  - str, The username to use to authenticate to the vcenter to which you want to connect. Required

- **manage_vcenter_host_connection_password**:
  - str, The password to use to authenticate to the esxi or vcenter to which you want to connect. Required

- **manage_vcenter_host_connection_validate_certs**:
  - bool, If true then certificates will be validated when connecting to the vcenter for auth. Optional.

- **manage_vcenter_host_connection_port**:
  - int, The port of the vcenter to which you want to connect. Optional.

### Placement
- **manage_vcenter_host_connection_folder**:
  - str, The folder path where the ESXi host should be added. Required if the cluster name is not provided

- **manage_vcenter_host_connection_datacenter**:
  - str, The datacenter name where the ESXi host should be added. Required

- **manage_vcenter_host_connection_cluster**:
  - str, The cluster name where the ESXi host should be added. Required if the folder name is not provided

### Connection Settings
- **manage_vcenter_host_connection_state**:
  - str, The connection state of the ESXi host that you want to set. Default is `present`
  - If set to `present`, add the host if host is absent.
  - If set to `present`, update the location of the host if host already exists.
  - If set to `absent`, remove the host if host is present.
  - If set to `absent`, do nothing if host already does not exists.
  - If set to `add_or_reconnect`, add the host if it’s absent else reconnect it and update the location.
  - If set to `reconnect`, then reconnect the host if it’s present and update the location.
  - If set to `disconnected`, disconnect the host if the host already exists.

- **manage_vcenter_host_connection_add_connected**:
  - bool, If true then the host will be connected as soon as its added to vcenter. Optional

- **manage_vcenter_host_connection_esxi_hostname**:
  - str, The hostname of the ESXi host that you want to manage. Required

- **manage_vcenter_host_connection_esxi_username**:
  - str, The username for the ESXi host that you want to manage. Required when adding the host.

- **manage_vcenter_host_connection_esxi_password**:
  - str, The password for the ESXi host that you want to manage. Required when adding the host.

- **manage_vcenter_host_connection_esxi_ssl_thumbprint**:
  - str, The SSL thumbprint for the ESXi host that you want to manage. Optional.

- **manage_vcenter_host_connection_fetch_ssl_thumbprint**:
  - bool, If true, the ESXi host thumprint will be fetched and trusted prior to adding. Optional.

- **manage_vcenter_host_connection_force_connection**:
  - bool, If true, the connection status will be forced even if the host is managed by another vcenter. Optional

- **manage_vcenter_host_connection_reconnect_disconnected**:
  - bool, The port of a proxy host that should be used for all HTTPs communication by the role. Optional

### Other
- **manage_vcenter_host_connection_proxy_host**:
  - str, The hostname of a proxy host that should be used for all HTTPs communication by the role. Optional

- **manage_vcenter_host_connection_proxy_port**:
  - str, The port of a proxy host that should be used for all HTTPs communication by the role. Optional


## Dependencies

- NA

## Example Playbook
```yaml
---
- name: Add an ESXi Host To VCenter
  hosts: localhost
  roles:
    - role: cloud.vmware_ops.manage_vcenter_host_connection
      vars:
        manage_vcenter_host_connection_hostname: "{{ vcenter_hostname }}"
        manage_vcenter_host_connection_username: "{{ vcenter_username }}"
        manage_vcenter_host_connection_password: "{{ vcenter_password }}"
        manage_vcenter_host_connection_datacenter: dc1
        manage_vcenter_host_connection_cluster: cluster1
        manage_vcenter_host_connection_esxi_hostname: myesxi.contoso.org
        manage_vcenter_host_connection_esxi_username: root
        manage_vcenter_host_connection_esxi_password: supersecret!


- name: Remove an ESXi Host From VCenter
  hosts: localhost
  roles:
    - role: cloud.vmware_ops.manage_vcenter_host_connection
      vars:
        manage_vcenter_host_connection_hostname: "{{ vcenter_hostname }}"
        manage_vcenter_host_connection_username: "{{ vcenter_username }}"
        manage_vcenter_host_connection_password: "{{ vcenter_password }}"
        manage_vcenter_host_connection_datacenter: dc1
        manage_vcenter_host_connection_cluster: cluster1
        manage_vcenter_host_connection_esxi_hostname: myesxi.contoso.org
        manage_vcenter_host_connection_state: absent
```

License
-------

GNU General Public License v3.0 or later

See [LICENCE](https://github.com/ansible-collections/cloud.aws_troubleshooting/blob/main/LICENSE) to see the full text.

Author Information
------------------

- Ansible Cloud Content Team
