# vcenter_host_connection

Add, remove, connect, disconnect, or reconnect an ESXi host from a VCenter

## Dependencies

N/A

## Role Variables

### Auth
- **vcenter_host_connection_hostname**:
  - str, The hostname of the vCenter to which you want to connect. Required

- **vcenter_host_connection_username**:
  - str, The username to use to authenticate to the vCenter to which you want to connect. Required

- **vcenter_host_connection_password**:
  - str, The password to use to authenticate to the ESXi or vCenter to which you want to connect. Required

- **vcenter_host_connection_validate_certs**:
  - bool, If true then certificates will be validated when connecting to the vCenter for auth. Optional.

- **vcenter_host_connection_port**:
  - int, The port of the vCenter to which you want to connect. Optional.

### Placement
- **vcenter_host_connection_folder**:
  - str, The folder path where the ESXi host should be added. Required if the cluster name is not provided

- **vcenter_host_connection_datacenter**:
  - str, The datacenter name where the ESXi host should be added. Required

- **vcenter_host_connection_cluster**:
  - str, The cluster name where the ESXi host should be added. Required if the folder name is not provided

### Connection Settings
- **vcenter_host_connection_state**:
  - str, The connection state of the ESXi host that you want to set. Default is `present`
  - If set to `present`, add the host if host is absent, or update the location of the host if host already exists.
  - If set to `absent`, remove the host if host is present, or do nothing if host already does not exist.
  - If set to `add_or_reconnect`, add the host if it's absent else reconnect it and update the location.
  - If set to `reconnect`, then reconnect the host if it's present and update the location.
  - If set to `disconnected`, disconnect the host if the host already exists.

- **vcenter_host_connection_add_connected**:
  - bool, If true then the host will be connected as soon as it's added to vCenter. Optional

- **vcenter_host_connection_esxi_hostname**:
  - str, The hostname of the ESXi host that you want to manage. Required

- **vcenter_host_connection_esxi_username**:
  - str, The username for the ESXi host that you want to manage. Required when adding the host.

- **vcenter_host_connection_esxi_password**:
  - str, The password for the ESXi host that you want to manage. Required when adding the host.

- **vcenter_host_connection_esxi_ssl_thumbprint**:
  - str, The SSL thumbprint for the ESXi host that you want to manage. Optional.

- **vcenter_host_connection_fetch_ssl_thumbprint**:
  - bool, If true, the ESXi host thumbprint will be fetched and trusted prior to adding. Optional.

- **vcenter_host_connection_force_connection**:
  - bool, If true, the connection status will be forced even if the host is managed by another vCenter. Optional

- **vcenter_host_connection_reconnect_disconnected**:
  - bool, Reconnect disconnected hosts, if the state is present and the host already exists. Optional

### Other
- **vcenter_host_connection_proxy_host**:
  - str, The hostname of a proxy host that should be used for all HTTPs communication by the role. Optional

- **vcenter_host_connection_proxy_port**:
  - str, The port of a proxy host that should be used for all HTTPs communication by the role. Optional


## Example Playbook
```yaml
---
- name: Add an ESXi Host To VCenter
  hosts: localhost
  roles:
    - role: cloud.vmware_ops.vcenter_host_connection
      vars:
        vcenter_host_connection_hostname: "{{ vcenter_hostname }}"
        vcenter_host_connection_username: "{{ vcenter_username }}"
        vcenter_host_connection_password: "{{ vcenter_password }}"
        vcenter_host_connection_datacenter: dc1
        vcenter_host_connection_cluster: cluster1
        vcenter_host_connection_esxi_hostname: myesxi.contoso.org
        vcenter_host_connection_esxi_username: root
        vcenter_host_connection_esxi_password: supersecret!


- name: Remove an ESXi Host From VCenter
  hosts: localhost
  roles:
    - role: cloud.vmware_ops.vcenter_host_connection
      vars:
        vcenter_host_connection_hostname: "{{ vcenter_hostname }}"
        vcenter_host_connection_username: "{{ vcenter_username }}"
        vcenter_host_connection_password: "{{ vcenter_password }}"
        vcenter_host_connection_datacenter: dc1
        vcenter_host_connection_cluster: cluster1
        vcenter_host_connection_esxi_hostname: myesxi.contoso.org
        vcenter_host_connection_state: absent
```

License
-------

GNU General Public License v3.0 or later

See [LICENSE](https://github.com/ansible-collections/cloud.aws_troubleshooting/blob/main/LICENSE) to see the full text.

Author Information
------------------

- Ansible Cloud Content Team
