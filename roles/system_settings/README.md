# System settings role

A role to define system settings for vCenter.

## Requirements

N/A

## Role Variables
### Auth
- **system_settings_username**:
  - The vSphere vCenter username.

- **system_settings_password**:
  - The vSphere vCenter password.

- **system_settings_hostname**:
  - The hostname or IP address of the vSphere vCenter.

- **system_settings_validate_certs**
  - Allows connection when SSL certificates are not valid. Set to false when certificates are not trusted.

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

- **system_settings_dns_mode_append**
  - If `true` items from `system_settings_dns_servers` will be added to already configured DNS servers. If `false` servers will be overriden.

- **system_settings_dns_domains**:
  - List of DNS domains to add/set.

- **system_settings_dns_mode_append**
  - If `true` items from `system_settings_dns_domains` will be added to already configured DNS domains. If `false` domains will be overriden.

- **system_settings_dns_hostname**:
  - Set the hostname of the vcenter.

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

## Dependencies

- vmware.vmware_rest

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

See [LICENCE](https://github.com/ansible-collections/cloud.aws_troubleshooting/blob/main/LICENSE) to see the full text.

## Author Information

- Ansible Cloud Content Team
