# manage_folder

A role to create, delete, or update a folder or folder tree in vCenter.

## Dependencies

N/A

## Role Variables
### Auth
- **manage_folder_username**:
  - The vSphere vCenter username.

- **manage_folder_password**:
  - The vSphere vCenter password.

- **manage_folder_hostname**:
  - The hostname or IP address of the vSphere vCenter.

- **manage_folder_validate_certs**
  - Allows connection when SSL certificates are not valid. Set to false when certificates are not trusted.

- **manage_folder_datacenter_name**:
  - The name of the datacenter in vSphere vCenter which contains the cluster to configure.

- **manage_folder_port**:
  - str or int, The port to use to authenticate to the vSphere vCenter which contains the cluster to configure.

### Other
- **manage_folder_folder_name**:
  - str, required, The name of folder to manage. It can be a single name like `foo` or a path like `foo/bar/buzz`.

- **manage_folder_parse_name_as_path**:
  - bool, If true then `manage_folder_folder_name` is treated as a path. All folders along the path will be managed.
    If false, the name is treated as a literal string. Default is true.

- **manage_folder_folder_type**:
  - str, The type of folder to manage. Can be `datastore`, `host`, `vm`, or `network`. The default is `vm`.

- **manage_folder_parent_folder**:
  - >-
    str, Set the folder path where the new folder(s) should be managed. This path must already exist.
    For example, for the folder `foo/bizz/buzz` the parent is `foo/bizz/buzz`

- **manage_folder_state**:
  - str, optional, Choose if the folder should be 'present' or 'absent'. Default value is 'present'

### Other
- **manage_folder_proxy_host**:
  - str, The hostname of a proxy host that should be used for all HTTPs communication by the role. Optional

- **manage_folder_proxy_port**:
  - str, The port of a proxy host that should be used for all HTTPs communication by the role. Optional


## Example Playbook
```yaml
---
- name: Manage VMWare Folders
  hosts: all
  gather_facts: false
  vars:
    manage_folder_username: <>
    manage_folder_password: <>
    manage_folder_hostname: <>
    manage_folder_datacenter: DC01
    manage_folder_type: host

  roles:
    - role: cloud.vmware_ops.manage_folder
      manage_folder_folder_name: my/folder
      manage_folder_state: present

    - role: cloud.vmware_ops.manage_folder
      manage_folder_folder_name: my/folder
      manage_folder_state: absent

  tasks:
    - name: Create Folder Trees
      ansible.builtin.include_role:
        name: manage_folder
      vars:
        manage_folder_state: present
        manage_folder_folder_name: "{{ item }}"
      loop:
        - production/foo/web
        - uat/foo/web
        - development/foo/web

    - name: Create Folders Without Managing Full Tree
      ansible.builtin.include_role:
        name: manage_folder
      vars:
        manage_folder_state: present
        manage_folder_folder_name: "{{ item }}"
        manage_folder_parent_folder: production/foo
      loop:
        - backend
        - db

    - name: Create A Folder With A Slash In It
      ansible.builtin.include_role:
        name: manage_folder
      vars:
        manage_folder_state: present
        manage_folder_folder_name: security/syseng
        manage_folder_parent_folder: production/foo
        manage_folder_parse_name_as_path: false

    - name: Delete The Whole Tree
      ansible.builtin.include_role:
        name: manage_folder
      vars:
        manage_folder_state: absent
        manage_folder_folder_name: production
```
## License

GNU General Public License v3.0 or later

See [LICENSE](https://github.com/ansible-collections/cloud.aws_troubleshooting/blob/main/LICENSE) to see the full text.

## Author Information

- Ansible Cloud Content Team
