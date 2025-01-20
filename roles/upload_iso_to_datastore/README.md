# upload_iso_to_datastore
A role intended for uploading local ISO files to a Datastore.


## Dependencies

N/A


## Role Variables

### Auth

- **upload_iso_to_datastore_hostname** (str, required)
    - The hostname or IP address of the vSphere vCenter or ESXi host.
    - If this variable is not set, the collection level variable `vmware_ops_hostname` will be used. If that variable is not set, the environment variable `VMWARE_HOST` will be used. At least one of these variables must be set to use this role.
    - See the [authentication documentation](https://github.com/redhat-cop/cloud.vmware_ops/blob/main/docs/authentication.md) for examples.

- **upload_iso_to_datastore_username** (str, required)
    - The vSphere vCenter or ESXi host username.
    - If this variable is not set, the collection level variable `vmware_ops_username` will be used. If that variable is not set, the environment variable `VMWARE_USER` will be used. At least one of these variables must be set to use this role.
    - See the [authentication documentation](https://github.com/redhat-cop/cloud.vmware_ops/blob/main/docs/authentication.md) for examples.

- **upload_iso_to_datastore_password** (str, required)
    - The vSphere vCenter or ESXi host password.
    - If this variable is not set, the collection level variable `vmware_ops_password` will be used. If that variable is not set, the environment variable `VMWARE_PASSWORD` will be used. At least one of these variables must be set to use this role.
    - See the [authentication documentation](https://github.com/redhat-cop/cloud.vmware_ops/blob/main/docs/authentication.md) for examples.

- **upload_iso_to_datastore_validate_certs** (bool)
    - Allows connection when SSL certificates are not valid. Set to false when certificates are not trusted.
    - If this variable is not set, the collection level variable `vmware_ops_validate_certs` will be used. If that variable is not set, the environment variable `VMWARE_VALIDATE_CERTS` will be used.
    - See the [authentication documentation](https://github.com/redhat-cop/cloud.vmware_ops/blob/main/docs/authentication.md) for examples.

- **upload_iso_to_datastore_port** (int or str)
    - The port used to authenticate to the vSphere vCenter or ESXi host.
    - If this variable is not set, the collection level variable `vmware_ops_port` will be used. If that variable is not set, the environment variable `VMWARE_PORT` will be used.
    - See the [authentication documentation](https://github.com/redhat-cop/cloud.vmware_ops/blob/main/docs/authentication.md) for examples.

### Proxy

- **upload_iso_to_datastore_proxy_host** (str)
    - The hostname of a proxy host that should be used for all HTTPs communication by the role.
    - The format is a hostname or an IP.
    - If this variable is not set, the collection level variable `vmware_ops_proxy_host` will be used. If that variable is not set, the environment variable `VMWARE_PROXY_HOST` will be used.
    - See the [authentication documentation](https://github.com/redhat-cop/cloud.vmware_ops/blob/main/docs/authentication.md) for examples.

- **upload_iso_to_datastore_proxy_port** (str or int)
    - The port of a proxy host that should be used for all HTTPs communication by the role
    - If this variable is not set, the collection level variable `vmware_ops_proxy_host` will be used. If that variable is not set, the environment variable `VMWARE_PROXY_PORT` will be used.
    - See the [authentication documentation](https://github.com/redhat-cop/cloud.vmware_ops/blob/main/docs/authentication.md) for examples.

### Uploading an ISO file

- **upload_iso_to_datastore_src** (str, required)
    - Absolute path to the ISO file to upload.
    - This parameter is case sensitive.

- **upload_iso_to_datastore_datacenter** (str, required)
    - The name of the datacenter where the Datastore resides.
    - This parameter is case sensitive.

- **upload_iso_to_datastore_datastore** (str, required)
    - The ISO will be uploaded into this Datastore.
    - Please see the examples for more usage.

- **upload_iso_to_datastore_dst** (str, required)
    - The ISO file will be uploaded into this destination path within the Datastore.
    - This parameter is case sensitive.

## Examples

All the variables defined in section [Role Variables](#role-variables) can be defined inside the ``vars.yml`` file.

Create a ``playbook.yml`` file like this:

```yaml
---
- hosts: localhost
  gather_facts: true

  tasks:
    - name: Upload ISO to Datastore
      ansible.builtin.import_role:
        name: cloud.vmware_ops.upload_iso_to_datastore
      vars:
        upload_iso_to_datastore_hostname: "test"
        upload_iso_to_datastore_username: "test"
        upload_iso_to_datastore_password: "test"
        upload_iso_to_datastore_validate_certs: false
        upload_iso_to_datastore_datacenter: "DC0"
        upload_iso_to_datastore_port: "8989"
        upload_iso_to_datastore_datastore: "eco-iscsi-ds1"
        upload_iso_to_datastore_src: "/tmp/test.iso"
        upload_iso_to_datastore_dst: "/test.iso"
```

Run the playbook:

```shell
ansible-playbook playbook.yml -e "@vars.yml"
```

## License

GNU General Public License v3.0 or later

See [LICENSE](https://github.com/ansible-collections/cloud.vmware_ops/blob/main/LICENSE) to see the full text.

## Author Information

- Ansible Cloud Content Team
