# cloud.vmware_ops Execution Environment (EE)

## Building

You can build a container image capable of running the playbooks in this collection using `ansible-builder`.
You can install it by running `pip install ansible-builder`

To build the execution environment image:
```bash
# change your working directory to this dir
cd ./execution-environment

# you may need to remove the context dir for a clean build
rm -rf ./context

ansible-builder build -t my_image_name:my_tag
```

This will create container image `my_image_name:my_tag`.
You can then upload it to your container image repository (quay, docker hub, etc) and use from AAP.


## Running Locally

You can run the container image locally using `ansible-runner`.
You can install it by running `pip install ansible-runner`

As an example, you can run the info playbook with no options set using the following command:
```bash
ansible-runner run --container-image my_image_name:my_tag -p cloud.vmware_ops.info /tmp
```
