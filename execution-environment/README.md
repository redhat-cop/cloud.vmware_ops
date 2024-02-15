## How to use execution environment

### Building
To build the execution environment image:

```bash
$ export USER=yourdockerusername
$ ansible-builder build -t quay.io/$USER/vmware:mytest
```

This will create container image `quay.io/$USER/vmware:mytest`. You can upload it to quay and use from AAP.

### Local test
To test the image locally using `ansible-runner` execute the image as follows:

```bash
$ export USER=yourdockerusername
$ ansible-runner run --container-image quay.io/$USER/vmware:mytest runner --inventory localhost, -p cloud.vmware_ops.security
```

This will execute the `security.yml` playbook from playbooks directory. You can test with any playbook from this directory.
