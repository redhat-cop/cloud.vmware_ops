# cluster_settings

A role to define cluster settings in vCenter.

## Dependencies

N/A

## Role Variables
### Auth
- **cluster_settings_username**:
  - The vSphere vCenter username.

- **cluster_settings_password**:
  - The vSphere vCenter password.

- **cluster_settings_hostname**:
  - The hostname or IP address of the vSphere vCenter.

- **cluster_settings_validate_certs**
  - Allows connection when SSL certificates are not valid. Set to false when certificates are not trusted.

- **cluster_settings_cluster_name**:
  - The name of the cluster in vSphere vCenter to configure.

- **cluster_settings_datacenter_name**:
  - The name of the datacenter in vSphere vCenter which contains the cluster to configure.

- **cluster_settings_port**:
  - str or int, The port used to authenticate to the vSphere vCenter that contains the cluster to configure.

### Cluster settings

#### Distributed Power Management (DPM)

- **cluster_settings_dpm_enable**:
  - bool, If true, DPM will be enabled and configured using the settings below. If false, DPM will be disabled. If undefined, no action will be taken

- **cluster_settings_dpm_default_behavior**:
  - str, Set the DPM behavior. Value should be 'automated' or 'manual'

- **cluster_settings_dpm_host_power_action_rate**:
  - int, Specify host power action rate as a number 1-5. 1 is the most conservative and 5 the most aggressive


#### DRS

- **cluster_settings_drs_enable**:
  - bool, If true, DRS will be enabled and configured using the settings below. If false, DRS will be disabled. If undefined, no action will be taken

- **cluster_settings_drs_enable_vm_behavior_overrides**:
  - bool, If true, DRS Behavior overrides for individual virtual machines are enabled.

- **cluster_settings_drs_enable_vm_behavior**
  - str, Specifies the cluster-wide default DRS behavior for virtual machines.
  - If set to `partiallyAutomated`, vCenter generates recommendations for virtual machine migration and for the placement with a host, then automatically implements placement recommendations at power on.
  - If set to `manual`, then vCenter generates recommendations for virtual machine migration and for the placement with a host, but does not implement the recommendations automatically.
  - If set to `fullyAutomated`, then vCenter automates both the migration of virtual machines and their placement with a host at power on.

- **cluster_settings_drs_vmotion_rate**:
  - int, Threshold for generated ClusterRecommendations ranging from 1 (lowest) to 5 (highest).

- **cluster_settings_drs_advanced_settings**
  - dict, A dictionary of advanced DRS settings.

- **cluster_settings_drs_predictive**:
  - bool, If true, DRS will respond to forecasted metrics provided by vRealize Operations Manager in addition to real-time metrics.
  - You must have already configured Predictive DRS in a version of vRealize Operations that supports this feature.

- **cluster_settings_drs_apply_recommendations**:
  - bool, If true, apply available DRS recommendations after DRS settings above are configured. Default is False


#### Cluster HA

- **cluster_settings_ha_enable**:
  - bool, If true, HA will be enabled and configured using the settings below. If false, HA will be disabled. If undefined, no action will be taken

- **cluster_settings_ha_host_monitoring**:
  - str, Whether HA restarts virtual machines after a host fails. Either `enabled` or `disabled`

- **cluster_settings_ha_vm_monitoring**:
  - str, State of virtual machine health monitoring service. One of `vmAndAppMonitoring`, `vmMonitoringDisabled`, `vmMonitoringOnly`

- **cluster_settings_ha_host_isolation_response**:
  - str, Indicates whether VMs should be powered off if a host determines that it is isolated from the rest of the compute resource. One of `none`, `powerOff`, `powerOn`

- **cluster_settings_ha_slot_based_admission_control**:
  - dict, Configure slot based admission control policy.
  - `cluster_settings_ha_slot_based_admission_control`, `cluster_settings_ha_reservation_based_admission_control` and `cluster_settings_ha_failover_host_admission_control` are mutually exclusive.
  - Refer to this documentation for child attributes https://docs.ansible.com/ansible/latest/collections/community/vmware/vmware_cluster_ha_module.html#parameter-slot_based_admission_control

- **cluster_settings_ha_reservation_based_admission_control**:
  - dict, Configure reservation based admission control policy.
  - `cluster_settings_ha_slot_based_admission_control`, `cluster_settings_ha_reservation_based_admission_control` and `cluster_settings_ha_failover_host_admission_control` are mutually exclusive.
  - Refer to this documentation for child attributes https://docs.ansible.com/ansible/latest/collections/community/vmware/vmware_cluster_ha_module.html#parameter-reservation_based_admission_control

- **cluster_settings_ha_failover_host_admission_control**:
  - dict, Configure dedicated failover hosts.
  - `cluster_settings_ha_slot_based_admission_control`, `cluster_settings_ha_reservation_based_admission_control` and `cluster_settings_ha_failover_host_admission_control` are mutually exclusive.
  - Refer to this documentation for child attributes https://docs.ansible.com/ansible/latest/collections/community/vmware/vmware_cluster_ha_module.html#parameter-failover_host_admission_control

- **cluster_settings_ha_vm_failure_interval**:
  - int, The number of seconds after which virtual machine is declared as failed if no heartbeat has been received.
  - Used only when `cluster_settings_ha_vm_monitoring` is `vmAndAppMonitoring` or `vmMonitoringOnly`

- **cluster_settings_ha_vm_min_up_time**:
  - int, The number of seconds for the virtual machine's heartbeats to stabilize after the virtual machine has been powered on.
  - Used only when `cluster_settings_ha_vm_monitoring` is `vmAndAppMonitoring` or `vmMonitoringOnly`

- **cluster_settings_ha_vm_max_failures**:
  - int, Maximum number of failures and automated resets allowed during the time that ha_vm_max_failure_window specifies.
  - Used only when `cluster_settings_ha_vm_monitoring` is `vmAndAppMonitoring` or `vmMonitoringOnly`

- **cluster_settings_ha_vm_max_failure_window**:
  - int, The number of seconds for the window during which up to `cluster_settings_ha_vm_max_failures` resets can occur before automated responses stop. Default specifies no failure window.
  - Used only when `cluster_settings_ha_vm_monitoring` is `vmAndAppMonitoring` or `vmMonitoringOnly`

- **cluster_settings_ha_restart_priority**:
  - str, The priority HA gives to a virtual machine if sufficient capacity is not available to power on all failed virtual machines. Options are `disabled`, `low`, `medium`, or `high`
  - Used only when `cluster_settings_ha_vm_monitoring` is `vmAndAppMonitoring` or `vmMonitoringOnly`

- **cluster_settings_ha_advanced_settings**:
  - dict, A dictionary of advanced HA settings.

- **cluster_settings_ha_apd_response**:
  - str, VM storage protection setting for storage failures categorized as All Paths Down (APD).
  - Options are `disabled`, `warning`, `restartConservative`, `restartAggressive`

- **cluster_settings_ha_apd_delay**:
  - int, The response recovery delay time in sec for storage failures categorized as All Paths Down (APD).
  - Used only when `cluster_settings_ha_apd_response` is `restartConservative` or `restartAggressive`.

- **cluster_settings_ha_apd_reaction**:
  - str, VM response recovery reaction for storage failures categorized as All Paths Down (APD). Either `reset` or `none`
  - Used only when `cluster_settings_ha_apd_response` is `restartConservative` or `restartAggressive`.

- **cluster_settings_ha_pdl_response**:
  - str, VM storage protection setting for storage failures categorized as Permanent Device Loss (PDL).
  - Options are `disabled`, `warning`, `restartAggressive`


#### vCLS Datastore

- **cluster_settings_vcls_allowed_datastores**:
  - list, List of the allowed Datastores. Any currently allowed datastores not in the list will be removed.
  - If this is undefined, no action is taken.

#### vSAN
- **cluster_settings_vsan_enable**:
  - bool, If true, vSAN will be enabled and configured using the parameters below. If false, vSAN will be disabled. If undefined, no action will be taken

- **cluster_settings_vsan_auto_claim_storage**:
  - bool, If true, the VSAN service is configured to automatically claim local storage on VSAN-enabled hosts in the cluster.

- **cluster_settings_vsan_advanced_options**:
  - A dictionary of advanced vSAN options. Suboptions include:
  - `automatic_rebalance`: bool, If true, vSAN automatically rebalances (moves the data among disks) when a capacity disk fullness hits proactive rebalance threshold.
  - `disable_site_read_locality`: bool, For vSAN stretched clusters, reads to vSAN objects occur on the site the VM resides on. Setting to true will force reads across all mirrors.
  - `large_cluster_support`: bool, If true, allow > 32 VSAN hosts per cluster. If this is changed on an existing vSAN cluster, all hosts are required to reboot to apply this change.
  - `object_repair_timer`: int, Delay time in minutes for VSAN to wait for the absent component to come back before starting to repair it.
  - `thin_swap`: bool, If true, swap objects would not reserve 100% space of their size on vSAN datastore.

### Other
- **cluster_settings_proxy_host**:
  - str, The hostname of a proxy host that should be used for all HTTPs communication by the role. Optional

- **cluster_settings_proxy_port**:
  - str, The port of a proxy host that should be used for all HTTPs communication by the role. Optional


## Example Playbook
```yaml
---
- name: Manage vmware cluster settings
  hosts: all
  gather_facts: false

  roles:
    - role: cloud.vmware_ops.cluster_settings
```
## License

GNU General Public License v3.0 or later

See [LICENSE](https://github.com/ansible-collections/cloud.aws_troubleshooting/blob/main/LICENSE) to see the full text.

## Author Information

- Ansible Cloud Content Team
