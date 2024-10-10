# info

A role that gathers information from vCenter.

## Dependencies

N/A

## Role Variables

### Auth

- **info_username**:
  - The vSphere vCenter username.
  - If this variable is not set, the collection level variable `vmware_ops_username` will be used. If that variable is not set, the environment variable `VMWARE_USER` will be used. At least one of these variables must be set to use this role.
  - See the [authentication documentation](https://github.com/redhat-cop/cloud.vmware_ops/blob/main/docs/authentication.md) for examples.

- **info_password**:
  - The vSphere vCenter password.
  - If this variable is not set, the collection level variable `vmware_ops_password` will be used. If that variable is not set, the environment variable `VMWARE_PASSWORD` will be used. At least one of these variables must be set to use this role.
  - See the [authentication documentation](https://github.com/redhat-cop/cloud.vmware_ops/blob/main/docs/authentication.md) for examples.

- **info_hostname**:
  - The hostname or IP address of the vSphere vCenter.
  - If this variable is not set, the collection level variable `vmware_ops_hostname` will be used. If that variable is not set, the environment variable `VMWARE_HOST` will be used. At least one of these variables must be set to use this role.
  - See the [authentication documentation](https://github.com/redhat-cop/cloud.vmware_ops/blob/main/docs/authentication.md) for examples.

- **info_validate_certs**
  - Allows connection when SSL certificates are not valid. Set to false when certificates are not trusted.
  - If this variable is not set, the collection level variable `vmware_ops_validate_certs` will be used. If that variable is not set, the environment variable `VMWARE_VALIDATE_CERTS` will be used.
  - See the [authentication documentation](https://github.com/redhat-cop/cloud.vmware_ops/blob/main/docs/authentication.md) for examples.

### Output
- **info_expose_outputs_as_variable**
  - If set to true, the role will expose the gathered information as a variable which can be used later on in your playbook. The variable is called `vmware_ops_info_outputs`. If set to false, this variable is not set.
  - The variable and it's attributes (license, appliance, etc) are returned regardless if data was gathered or not. However, if you do not gather information pertaining to an attribute an empty data set is returned.
  - The empty data set will be the same type as a populated dataset; meaning if the data set is normally a list, an empty list will be returned.
  - For example, if `info_appliance` is set to `false`, then `vmware_ops_info_outputs.appliance` will be `{}`. If `info_guests` is set to `false`, then `vmware_ops_info_outputs.guests` will be `[]`.

The variable's attributes have the following data types:
```
vmware_ops_info_outputs:
  appliance: dict
  license: list(str)
  cluster: list(dict)
  guest: list(dict)
  storage: list(dict)
```

An abbreviated example of the data returned can be found below:
```
"vmware_ops_info_outputs": {
  "appliance": {
      "access": {
          "access": {
                    "consolecli": true,
                    "dcui": true,
                    "shell": {
                        "enabled": "False",
                        "timeout": "0"
                    },
                    "ssh": true
                }
            },
      "firewall": {
        "inbound": []
      },
      .....   # note: this example is abbreviated for conciseness
  },
  "cluster": [
    {
      "My-Cluster": {
        "configuration": {
          "dasConfig": {
              "enabled": false
          }
        },
        "name": "My-Cluster",
        "summary": {
            "totalCpu": 514080
        }
      }
    }
  ],
  "guest": [
    {
      "advanced_settings": {
        "cpuid.coresPerSocket.cookie": "1",
        "ethernet0.pciSlotNumber": "32",
        "guestinfo.vmtools.buildNumber": "22544099",
      .....   # note: this example is abbreviated for conciseness
    },
  ]
  "license": [
    "00000-0AA0A-000AA-000AA-0A0A0",
  ]
  "storage": [
    {
      "constraints_sub_profiles": [
        {
          "rule_set_info": [
            {
              "id": "com.vmware.storage.tag.openshift-rh-qfklm.property",
              "value": [
                "rh-qfklm"
              ]
            }
          ],
          "rule_set_name": "Tag based placement"
        }
      ],
      "description": null,
      "id": "34d58084-5b43-49f7-a29e-fd4b00f9f801",
      "name": "openshift-storage-policy-rh-qfklm"
    }
  ]
}
```

### Appliance
- **info_appliance**
  - Define whether appliance information should be gathered. Default is `false`.

- **info_appliance_gather**
  - Define the sections of the appliance to gather. By default we gather all appliance information.

- **info_appliance_file**
  - File where to store the gathered data. Default is `/tmp/vmware_ops_info_appliance`
  - If set to an empty string or `false`, the data is not written to a file.

### License
- **info_license**
  - Define whether license information should be gathered. Default is `false`.

- **info_license_file**
  - File where to store the gathered data. Default is `/tmp/vmware_ops_info_license`
  - If set to an empty string or `false`, the data is not written to a file.

### Cluster
- **info_cluster**
  - Define whether cluster information should be gathered. Default is `false`.

- **info_cluster_file**
  - File where to store the gathered data. Default is `/tmp/vmware_ops_info_cluster`
  - If set to an empty string or `false`, the data is not written to a file.

### Storage
- **info_storage**
  - Define whether storage information should be gathered. Default is `false`.

- **info_storage_file**
  - File where to store the gathered data. Default is `/tmp/vmware_ops_info_storage`
  - If set to an empty string or `false`, the data is not written to a file.

### Guest
- **info_guest**
  - Define whether guest information should be gathered. Default is `false`.

- **info_guest_file**
  - File where to store the gathered data. Default is `/tmp/vmware_ops_info_guest`
  - If set to an empty string or `false`, the data is not written to a file.


## Example Playbook
```yaml
---
- name: Manage vmware operation visibility
  hosts: all
  gather_facts: false

  vars:
    info_hostname: "vcenterhostname"
    info_username: "username"
    info_password: "password"

    info_license: true
    info_storage: true
    info_appliance: true

  roles:
    - role: cloud.vmware_ops.info

  tasks:
    # Note, this variable can contain a lot of data
    - name: Debug Output Variable
      ansible.builtin.debug:
        var: vmware_ops_info_outputs
```
## License

GNU General Public License v3.0 or later

See [LICENSE](https://github.com/ansible-collections/cloud.aws_troubleshooting/blob/main/LICENSE) to see the full text.

## Author Information

- Ansible Cloud Content Team
