# content_library

A role to manage VMWare content libraries. You can create or delete both local and subscribed content libraries.

## Dependencies

N/A

## Role Variables
### Auth
- **content_library_username**:
  - The vSphere vCenter username.

- **content_library_password**:
  - The vSphere vCenter password.

- **content_library_hostname**:
  - The hostname or IP address of the vSphere vCenter.

- **content_library_validate_certs**
  - Allows connection when SSL certificates are not valid. Set to false when certificates are not trusted.

- **content_library_cluster_name**:
  - The name of the cluster in vSphere vCenter to configure.

- **content_library_datacenter_name**:
  - The name of the datacenter in vSphere vCenter which contains the cluster to configure.

- **content_library_port**:
  - str or int, The port used to authenticate to the vSphere vCenter that contains the cluster to configure.

### Library
- **content_library_datastore_name**:
  - str, The name of the local datastore that should be used as storage for the content library. Required if state is `present`

- **content_library_description**:
  - str, A description to attach to the content library

- **content_library_name**:
  - str, Required. The name of the content library to manage

- **content_library_state**:
  - str, `present` or `absent`. Controls if the library should be created or deleted. Default is `present`

- **content_library_type**:
  - str, `local` or `subscribed`. Controls if the library will be hosted locally or should subscribe to a remote library

#### Subscribed Library Settings
- **content_library_ssl_thumbprint**:
  - str, The SSL thumbprint of the content library you want to which you want to subscribe.

- **content_library_subscription_url**:
  - str, The URL of the library to which you want to subscribe

- **content_library_update_on_demand**:
  - bool, If true, content in the library will be updated when it is requested. If false, the content is updated regularly

### Other
- **content_library_proxy_host**:
  - str, The hostname of a proxy host that should be used for all HTTPs communication by the role. Optional

- **content_library_proxy_port**:
  - str, The port of a proxy host that should be used for all HTTPs communication by the role. Optional


## Example Playbook
```yaml
---
- name: Manage VMWare Content Library
  hosts: all
  gather_facts: false

  roles:
    - role: cloud.vmware_ops.content_library
      vars:
        content_library_hostname: <>
        content_library_username: <>
        content_library_password: <>

        content_library_datastore_name: DS1
        content_library_name: my-content-library
        content_library_type: local
```
## License

GNU General Public License v3.0 or later

See [LICENSE](https://github.com/ansible-collections/cloud.aws_troubleshooting/blob/main/LICENSE) to see the full text.

## Author Information

- Ansible Cloud Content Team
