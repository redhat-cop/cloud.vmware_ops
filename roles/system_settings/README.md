# system_settings

A role to define system settings for vCenter.

## Dependencies

N/A

## Role Variables

### Auth

- **system_settings_username**:
  - The vSphere vCenter username.
  - If this variable is not set, the collection level variable `vmware_ops_username` will be used. If that variable is not set, the environment variable `VMWARE_USER` will be used. At least one of these variables must be set to use this role.
  - See the [authentication documentation](https://github.com/redhat-cop/cloud.vmware_ops/blob/main/docs/authentication.md) for examples.

- **system_settings_password**:
  - The vSphere vCenter password.
  - If this variable is not set, the collection level variable `vmware_ops_password` will be used. If that variable is not set, the environment variable `VMWARE_PASSWORD` will be used. At least one of these variables must be set to use this role.
  - See the [authentication documentation](https://github.com/redhat-cop/cloud.vmware_ops/blob/main/docs/authentication.md) for examples.

- **system_settings_hostname**:
  - The hostname or IP address of the vSphere vCenter.
  - If this variable is not set, the collection level variable `vmware_ops_hostname` will be used. If that variable is not set, the environment variable `VMWARE_HOST` will be used. At least one of these variables must be set to use this role.
  - See the [authentication documentation](https://github.com/redhat-cop/cloud.vmware_ops/blob/main/docs/authentication.md) for examples.

- **system_settings_validate_certs**
  - Allows connection when SSL certificates are not valid. Set to false when certificates are not trusted.
  - If this variable is not set, the collection level variable `vmware_ops_validate_certs` will be used. If that variable is not set, the environment variable `VMWARE_VALIDATE_CERTS` will be used.
  - See the [authentication documentation](https://github.com/redhat-cop/cloud.vmware_ops/blob/main/docs/authentication.md) for examples.

### System settings

#### General

- **system_settings_timezone**:
  - Set time zone.

- **system_settings_global_fips**:
  - Enable/Disable Global FIPS mode for the appliance. *Caution:* Changing the value of this setting will reboot the Appliance.

- **system_settings_resize_storage**:
  - Resize all partitions to 100 percent of disk size. Default is `false`.

#### DNS

- **system_settings_dns_mode**:
  - Set the DNS mode - either `is_static` or `dhcp`.

- **system_settings_dns_servers**:
  - List of DNS servers to add/set.

- **system_settings_dns_domains**:
  - List of DNS domains to add/set.

- **system_settings_dns_mode_append**
  - If `true` items from `system_settings_dns_domains` and `system_settings_dns_servers` will be added to already configured DNS domains/servers. If `false` domains/servers will be overridden.

- **system_settings_dns_hostname**:
  - Set the hostname of the vCenter.

#### NTP
Note: NTP service will be restarted if configuration is changed.

- **system_settings_timesync_mode**:
  - Set time synchronization mode.

- **system_settings_ntp_servers**:
  - List of NTP servers. This method updates old NTP servers from configuration and sets the input NTP servers in the configuration. If NTP based time synchronization is used internally, the NTP daemon will be restarted to reload given NTP configuration. In case NTP based time synchronization is not used, this method only replaces servers in the NTP configuration.

#### Proxy

- **system_settings_noproxy**:
  - List of hosts that should be ignored by proxy configuration.

- **system_settings_proxy**:
  - A list of proxy configurations.

    Proxy options:
    * enabled: Required. Define if this proxy configuration should be enabled.
    * url: Required. Define the URL of the proxy server (including protocol ie. http://...).
    * port: Required. Define the port of the proxy server.
    * protocol: Required. Define the protocol of the proxy server(FTP, HTTP, HTTPS).
    * state: Define if the proxy configuration should be `present` or `absent`.
    * username: Define `username` for the proxy server if proxy requires authentication.
    * password: Define `password` for the proxy server if proxy requires authentication.

#### Security
- **system_settings_dcui_enabled**:
  - Enable/Disable state of Direct Console User Interface (DCUI TTY2).

- **system_settings_shell_enabled**:
  - Enable/Disable state of BASH, that is, access to BASH from within the controlled CLI. This parameter is mandatory in case `system_settings_shell_timeout` is specified.

- **system_settings_shell_timeout**:
  - The timeout (in seconds) specifies how long you enable the Shell access. The maximum timeout is 86400 seconds(1 day). This parameter is mandatory in case `system_settings_shell_enabled` is specified.

- **system_settings_ssh_enabled**:
  - Enable/Disable state of the SSH-based controlled CLI.

- **system_settings_firewall_rules**:
  - Set the ordered list of firewall rules to allow or deny traffic from one or more incoming IP addresses. Within the list of traffic rules, rules are processed in order of appearance, from top to bottom.

- **system_settings_firewall_rules_append**:
  - If `false` the rules overwrite the existing firewall rules and creates a new rule list. If `true` we append the rules to existing rules. Default is `true`.


## Example Playbook
```yaml
---
- name: Manage vmware system settings
  hosts: all
  gather_facts: false

  roles:
    - role: cloud.vmware_ops.system_settings
```
## License

GNU General Public License v3.0 or later

See [LICENSE](https://github.com/ansible-collections/cloud.aws_troubleshooting/blob/main/LICENSE) to see the full text.

## Author Information

- Ansible Cloud Content Team
