# Authentication Variables

Each role in this collection has its own set of authentication and proxy variables. It is not convenient to set those variables for every role, so there are options to set the variables for all roles in the collection at once.

Here is the order of precedence from greatest to least (the first listed variables override all other variables):

1. Role variables (for example, `info_hostname` for the `info` role)
2. Collection level variables (for example, `vmware_ops_hostname`)
3. Environment variables (for example, `VMWARE_HOST`)

## Collection and Environment Variables

The list of collection/environment variables is pulled from the [vars/main.yml](https://github.com/redhat-cop/cloud.vmware_ops/blob/main/vars/main.yml)

The available collection level variables and their corresponding environment variables can be found below:

- vmware_ops_hostname
    * str, The hostname or IP address of the vSphere vCenter or ESXi host to manage.
    * Environment Var: `VMWARE_HOST`

- vmware_ops_username
    * str, The username to use when authenticating to the vSphere vCenter or ESXi host.
    * Environment Var: `VMWARE_USER`

- vmware_ops_password
    * str, The password to use when authenticating to the vSphere vCenter or ESXi host.
    * Environment Var: `VMWARE_PASSWORD`

- vmware_ops_validate_certs
    * bool, Allows connection when SSL certificates are not valid. Set to false when certificates are not trusted.
    * Environment Var: `VMWARE_VALIDATE_CERTS`

- vmware_ops_port
    * int, The port to use when authenticating to the vSphere vCenter or ESXi host to manage.
    * Environment Var: `VMWARE_PORT`

- vmware_ops_proxy_host
    * str, The hostname or IP address of a proxy host to use. If set all requests to the vCenter or ESXi host will go through the proxy host.
    * Environment Var: `VMWARE_PROXY_HOST`

- vmware_ops_proxy_port
    * int, The port of a proxy host to use. If set all requests to the vCenter or ESXi host will go through the proxy host.
    * Environment Var: `VMWARE_PROXY_PORT`

## Example Playbook

```yaml
- name: Example Of Setting Different variables
  hosts: localhost
  environment:
    VMWARE_HOST: myvcenter.local
    VMWARE_USER: myadmin

  vars:
    # You can avoid exposing the password as an environment variable, and leverage ansible-vault by using the collection level
    # variable instead
    vmware_ops_password: vaultedPassword!

  roles:
    # This role will use VMWARE_HOST, VMWARE_USER, and vmware_ops_password
    - role: cloud.vmware_ops.provision_vm

    # This role will use VMWARE_HOST, info_username, and info_password
    - role: cloud.vmware_ops.info
      info_username: myreader
      info_password: readerPassword!
```
