# vmware_ops Experience

This experience bootstraps basic VMware resources in AAP and creates job templates that may be useful to operators. <br>

If the user is expected to update some resources after the experience is loaded, it should be documented in the setup.yml user_message and here.

## Created Resources

### Credentials

#### VMware Ops - vCenter Credential

This is a credential for VMware vCenter. It securly holds the authentication details for your vCenter while also sharing them with the playbook as environment variables. This makes authentication seemless.

You must edit the credential once it has been loaded and update the values for the following attributes:
- username
- password
- vCenter hostname

### Inventories

#### VMware Ops - localhost

This is a simple inventory containing only the localhost. That is generally sufficient for more vmware_ops playbooks.

You can add additional connection variables, or variables you want applied to all templates, to this inventory.

### Templates

#### VMware Ops - Gather Info

This template gathers a variety of info from vCenter. It runs the `playbooks/info.yml` playbook.
