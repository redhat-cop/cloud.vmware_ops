# esxi_maintenance_mode

Either put an ESXi host in maintenance mode or take the host out of maintenance mode.

## Dependencies

N/A

## Role Variables

### Auth
- **esxi_maintenance_mode_hostname**:
  - str, The hostname of the ESXi or vCenter on which you want to deploy the application. Required.

- **esxi_maintenance_mode_username**:
  - str, The username to use to authenticate to the ESXi or vCenter on which you want to deploy the application. Required.

- **esxi_maintenance_mode_password**:
  - str, The password to use to authenticate to the ESXi or vCenter on which you want to deploy the application. Required.

- **esxi_maintenance_mode_port**:
  - str or int, The port to use to authenticate to the ESXi or vCenter on which you want to deploy the application. Required.

- **esxi_maintenance_mode_validate_certs**:
  - bool, If true then certificates will be validated when connecting to the ESXi or vCenter for auth. Optional.

### Proxy Options

- **esxi_maintenance_mode_proxy_host**:
  - str, Address of a proxy that will receive all HTTPS requests and relay them.

- **esxi_maintenance_mode_proxy_port**:
  - int, Port of the HTTP proxy that will receive all HTTPS requests and relay them.

### Other Options
- **esxi_maintenance_mode_enable**:
  - bool, If true the ESXi host will be put into maintenance mode. If false, the host will be taken out of maintenance mode
  - Default value is True

- **esxi_maintenance_mode_esxi_hostname**:
  - str, The hostname of the ESXi host that you want to manage. Required

- **esxi_maintenance_mode_evacuate**:
  - bool, If true, powered off VMs on the ESXi host will be evacuated.

- **esxi_maintenance_mode_timeout**:
  - int, Set the length of time to wait for the host to move into the appropriate maintenance state before throwing an error.

- **esxi_maintenance_mode_vsan**:
  - str, Set the VSAN compliance mode for the host to enter.
  - One of `ensureObjectAccessibility`, `evacuateAllData`, `noAction`


## Example Playbook
```yaml
---
- name: Put Host In Maintenance Mode
  hosts: localhost
  roles:
    - role: esxi_maintenance_mode
      vars:
        esxi_maintenance_mode_validate_certs: false
        esxi_maintenance_mode_hostname: vcenter.example  # or IP like 192.168.123.5
        esxi_maintenance_mode_username: root
        esxi_maintenance_mode_password: 'password'
        esxi_maintenance_mode_esxi_hostname: my-esxi-host.example
        esxi_maintenance_mode_enable: True


- name: Take Host Out Of Maintenance Mode
  hosts: localhost
  roles:
    - role: esxi_maintenance_mode
      vars:
        esxi_maintenance_mode_validate_certs: false
        esxi_maintenance_mode_hostname: vcenter.example  # or IP like 192.168.123.5
        esxi_maintenance_mode_username: root
        esxi_maintenance_mode_password: 'password'
        esxi_maintenance_mode_esxi_hostname: my-esxi-host.example
        esxi_maintenance_mode_enable: False
```

License
-------

GNU General Public License v3.0 or later

See [LICENSE](https://github.com/ansible-collections/cloud.aws_troubleshooting/blob/main/LICENSE) to see the full text.

Author Information
------------------

- Ansible Cloud Content Team
