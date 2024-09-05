# Ansible Collection: cloud.vmware_ops

This repository hosts the `cloud.vmware_ops` validated Ansible Collection.

The collection includes a variety of Ansible roles and playbooks to help automate the management of VMware.

It focuses on playbooks and roles that allow users to quickly and easily perform VMware operations tasks. The playbooks cover common use cases and leverage the roles inside the collection. The roles can be used to create your own playbooks and cover custom use cases for your environment.

## Requirements

This repository comes with an execution environment definition. This can be used to quickly build a container image that contains all of the software required to run the playbooks and roles in this repository. See [execution-environment/README.md](https://github.com/redhat-cop/cloud.vmware_ops/tree/main/execution-environment/README.md) for more information.

It is common for people to use `localhost` to run the tasks in this content since most tasks simply interact with the vSphere environment. If you do not use the execution environment, the following requirements are needed on whatever host runs the tasks:
  - Python 3.9 or greater
  - Python requirements found in [execution-environment/requirements.txt](https://github.com/redhat-cop/cloud.vmware_ops/tree/main/execution-environment/requirements.txt)

Once the collection is installed, you can install the python requirements using pip: `pip install -r ~/.ansible/collections/ansible_collections/cloud/vmware_ops/execution-environment/requirements.txt`

### vSphere compatibility

This collection supports vSphere 7.x and 8.x.

### Ansible version compatibility

This collection has been tested against following Ansible versions: **>=2.15.0**.


## Installation and Usage

### Galaxy Requirements

Required collections are listed in the `galaxy.yml` and will be installed automatically when this collection is installed.

### Installation

This content can be installed from git by anyone with access to the repository.

To consume this Validated Content from Automation Hub, please ensure that you add the following lines to your ansible.cfg file.

```
[galaxy]
server_list = automation_hub

[galaxy_server.automation_hub]
url=https://cloud.redhat.com/api/automation-hub/
auth_url=https://sso.redhat.com/auth/realms/redhat-external/protocol/openid-connect/token
token=<SuperSecretToken>
```
The token can be obtained from the [Automation Hub Web UI](https://console.redhat.com/ansible/automation-hub/token).

Once the above steps are done, you can run the following command to install the collection.

```
ansible-galaxy collection install cloud.vmware_ops
```

### Using this collection

Once installed, you can reference the cloud.vmware_ops collection content by its fully qualified collection name (FQCN), for example:

```yaml
  - hosts: localhost
    roles:
      - role: cloud.vmware_ops.system_settings
```

### See Also

* [Ansible Using collections](https://docs.ansible.com/ansible/latest/user_guide/collections_using.html) for more details.


## Use Cases

* Use Case Name: Create and Modify Cluster Settings and Perform ESXi Maintenance
  * Actors:
    * System Admin
  * Description:
    * A systems administrator can modify various vCenter cluster settings.
  * Related Playbooks:
    * cluster_settings/disable_high_availability.yml
    * cluster_settings/enable_high_availability.yml
    * cluster_settings/manage_all_settings.yml
    * esxi_management/disable_maintenance_mode.yml
    * esxi_management/enable_maintenance_mode.yml
  * Roles:
    * `cloud.vmware_ops.cluster_settings` - Set DPM, DRS, vCLS, HA, and vSAN settings
    * `cloud.vmware_ops.esxi_maintenance_mode` - Manage the maintenance status of an ESXi host
  * Flow:
    - Using the `manage_all_settings` playbook, control a variety of settings in vCenter
    - Quickly enable or disable high availability on the cluster using the dedicated playbooks
    - Put an ESXi host in maintenance mode to adjust settings on the host, then add it back into production using the `esxi_maintenance_mode` role
    - When a new ESXi host or datastore has been added to the cluster, include the `cluster_settings` role to adjust related settings.

* Use Case Name: Create and Manage Virtual ESXi Hosts and a Nested VCenter
  * Actors:
    * System Admin
  * Description:
    * A systems administrator can deploy a virtual vSphere environment for testing or isolation purposes.
  * Related Playbooks:
    * esxi_management/add_esxi_host_to_vcenter.yml
    * esxi_management/remove_esxi_host_from_vcenter.yml
    * esxi_management/reconnect_esxi_host_in_vcenter.yml
    * provision_vcenter/provision_vcsa_on_esxi.yml
    * system_settings.yml
  * Roles:
    * `cloud.vmware_ops.provision_virtual_esxi` - Provision a set of virtual ESXi hosts on an existing vSphere environment
    * `cloud.vmware_ops.vcenter_host_connection` - Manage the connection status of an ESXi host to a vCenter appliance
    * `cloud.vmware_ops.system_settings` - Manage the system settings of a vCenter appliance
    * `cloud.vmware_ops.provision_vcenter` - Provision a vCenter appliance on an ESXi host or on an existing vCenter cluster
  * Flow:
    - Deploy virtual ESXi hosts on an existing cluster using the `provision_virtual_esxi` role
    - Deploy a vCenter appliance to one of the new virtual hosts using the `provision_vcenter` role or `provision_vcsa_on_esxi` playbook
    - Add the other virtual ESXi hosts to the new vCenter using the `add_esxi_host_from_vcenter` playbook or `vcenter_host_connection` role
    - Modify vCenter appliance system settings using the `system_settings` playbook or `system_settings` role

* Use Case Name: Manage a VM and Export and/or Deploy as an OVF
  * Actors:
    * System Admin
  * Description:
    * A systems administrator can create or modify an existing VM, export it as an OVF, and deploy the OVF to other clusters.
  * Related Playbooks:
    * provision_vm/manage_vm.yml
    * provision_vm/deploy_ovf.yml
    * export_vm_as_ovf.yml
    * snapshot_management/create_snapshot.yml
    * snapshot_management/remove_all_snapshots.yml
    * snapshot_management/remove_snapshot.yml
    * snapshot_management/revert_to_a_snapshot.yml
  * Roles:
    * `cloud.vmware_ops.export_vm_as_ovf` - Exports an existing VM as an OVF file
    * `cloud.vmware_ops.provision_vm` - Create, manage, or delete a VM
    * `cloud.vmware_ops.snapshot_management` - Manage the snapshots of a VM
    * `cloud.vmware_ops.manage_folder` - Create or delete a folder
    * `cloud.vmware_ops.deploy_ovf` - Deploy an OVF file to an ESXi host or existing vCenter Cluster
  * Flow:
    - Create or adjust a VM to prepare it for export using the `provision_vm` role or `manage_vm` playbook
    - Optionally take snapshots of the VM using the `snapshot_management` role or `create_snapshot` playbook
    - Power off the VM using `provision_vm` role or `manage_vm` playbook
    - Export the VM as an OVF file using the `export_vm_as_ovf` playbook or `export_vm_as_ovf` role
    - Deploy the VM from an OVF file using the `deploy_ovf` playbook or `deploy_ovf` role


## Testing

All releases will meet the following test criteria.

* 100% success for [Integration](https://github.com/redhat-cop/cloud.vmware_ops/tree/main/tests/integration) tests.
* 100% success for [Sanity](https://docs.ansible.com/ansible/latest/dev_guide/testing/sanity/index.html#all-sanity-tests) tests as part of [ansible-test](https://docs.ansible.com/ansible/latest/dev_guide/testing.html#run-sanity-tests).
* 100% success for [ansible-lint](https://ansible.readthedocs.io/projects/lint/) allowing only false positives.

## Contributing

This community is currently not accepting direct contributions. We encourage you to open [git issues](https://github.com/redhat-cop/cloud.vmware_ops/issues) for bugs, comments or feature requests.

Refer to the [Ansible community guide](https://docs.ansible.com/ansible/devel/community/index.html).

## Communication

* Join the Ansible forum:
  * [Get Help](https://forum.ansible.com/c/help/6): get help or help others.
  * [Posts tagged with 'vmware'](https://forum.ansible.com/tag/vmware): subscribe to participate in collection-related conversations.
  * [Ansible VMware Automation Working Group](https://forum.ansible.com/g/ansible-vmware): by joining the team you will automatically get subscribed to the posts tagged with ['vmware'](https://forum.ansible.com/tag/vmware).
  * [Social Spaces](https://forum.ansible.com/c/chat/4): gather and interact with fellow enthusiasts.
  * [News & Announcements](https://forum.ansible.com/c/news/5): track project-wide announcements including social events.

* The Ansible [Bullhorn newsletter](https://docs.ansible.com/ansible/devel/community/communication.html#the-bullhorn): used to announce releases and important changes.

For more information about communication, see the [Ansible communication guide](https://docs.ansible.com/ansible/devel/community/communication.html).


## Support

As Red Hat Ansible [Validated Content](https://catalog.redhat.com/software/search?target_platforms=Red%20Hat%20Ansible%20Automation%20Platform), this collection is entitled to [support](https://access.redhat.com/support/) through [Ansible Automation Platform](https://www.redhat.com/en/technologies/management/ansible) (AAP).


## License

GNU General Public License v3.0 or later

See [LICENSE](https://github.com/ansible-collections/cloud.vmware_ops/blob/main/LICENSE) to see the full text.
