# Security role

A role to define security options for vCenter.

## Requirements

N/A

## Role Variables
### Auth
- **security_username**:
  - The vSphere vCenter username.

- **security_password**:
  - The vSphere vCenter password.

- **security_hostname**:
  - The hostname or IP address of the vSphere vCenter.

- **security_validate_certs**
  - Allows connection when SSL certificates are not valid. Set to false when certificates are not trusted.

### Security
- **security_dcui_enabled**:
  - Enable/Disable state of Direct Console User Interface (DCUI TTY2).

- **security_shell_enabled**:
  - Enable/Disable state of BASH, that is, access to BASH from within the controlled CLI.

- **security_shell_timeout**:
  - The timeout (in seconds) specifies how long you enable the Shell access. The maximum timeout is 86400 seconds(1 day). This parameter is mandatory.

- **security_ssh_enabled**:
  - Enable/Disable state of the SSH-based controlled CLI.

- **security_firewall_rules**:
  - Set the ordered list of firewall rules to allow or deny traffic from one or more incoming IP addresses. Within the list of traffic rules, rules are processed in order of appearance, from top to bottom.

- **security_firewall_rules_append**:
  - If `false` the rules overwrites the existing firewall rules and creates a new rule list. If `true` we append the rules to existing rules. Default is `true`.

## Dependencies

- NA

## Example Playbook
```yaml
---
- name: Manage vmware security
  hosts: all
  gather_facts: false

  roles:
    - role: cloud.vmware_ops.security
```
## License

GNU General Public License v3.0 or later

See [LICENCE](https://github.com/ansible-collections/cloud.aws_troubleshooting/blob/main/LICENSE) to see the full text.

## Author Information

- Ansible Cloud Content Team
