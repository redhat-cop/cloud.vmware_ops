# VCSA Deployment Configuration

This role creates a JSON configuration file which is used by the VCSA deployment utility to configure the vCenter deployment. The JSON schema and the options inside are owned and managed by VMWare.

The original configuration files are packaged and included in the VCSA ISO. The ISO also includes some utilities that provide additional documentation on the configuration schema and options.

## Mounting the ISO and Accessing Utilities

In order to run some of the commands below, you must mount and access the vCenter ISO. Heres one way of doing this:
```bash
mkdir -p /mnt/vcenter
sudo mount -o ro ~/vcenter.8.0.2-23319993.iso /mnt/vcenter
```

Once you are done, you can unmount the device
```bash
sudo umount /mnt/vcenter
```

## Useful Information and Commands Inside The ISO

The sections below assume the current directory is the root of the ISO.

### Utility Binaries

Utility binaries can be found in `./vcsa-cli-installer/lin64` or `./vcsa-cli-installer/mac`

For example: `./vcsa-cli-installer/lin64/vcsa-deploy --help`

### Config Template Options and Definitions

VMWare provides supported templates from inside the ISO. You can view them in `./vcsa-cli-installer/templates`
Alternatively, you can run `./vcsa-cli-installer/lin64/vcsa-deploy install --template-help` to see a list of all possible template options and their descriptions.<br>

### Supported Deployment Sizes

The VCSA deployment only supports specific "sizes", meaning you cannot specify CPU or memory directly. Instead you need to specify one of the VMWare specified sizes.<br>
You can list these sizes by running the command: `./vcsa-cli-installer/lin64/vcsa-deploy --supported-deployment-sizes`

## Additional VMware Documentation

VMWare publishes ISO cli information online. It is dependent on the vSphere version, so refering to the commands provided by the ISO may be preferred. <br>
Below are some helpful document names and links to versions of that documentation.

[Prepare Your JSON Configuration File for CLI Deployment](https://docs.vmware.com/en/VMware-vSphere/7.0/com.vmware.vcenter.install.doc/GUID-3683BA76-B08A-4DDB-9CCF-66660F6AD1CF.html)<br>
[Deployment Configuration Parameters](https://docs.vmware.com/en/VMware-vSphere/7.0/com.vmware.vcenter.install.doc/GUID-457EAE1F-B08A-4E64-8506-8A3FA84A0446.html#GUID-457EAE1F-B08A-4E64-8506-8A3FA84A0446)<br>
