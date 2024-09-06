# AAP Experiences

Experiences are an easy way to create AAP resources from YAML templates to get new users up and running quickly. For example, the `vmware_ops` experience creates credentials, templates that require minimal configuration to work.

## Additional Resources

#### Controller Configuration
This is the collection that actually loads the `setup.yml` into AAP.
https://github.com/redhat-cop/controller_configuration

## Loading the Experience Locally

When creating the `setup.yml` that defines experience resources to create, it may be useful to load the experience from the command line.

1. Install pre-req collections `ansible-galaxy collection install infra.controller_configuration awx.awx`
2. Set environment variables to connect to your instance of AAP: CONTROLLER_HOST, CONTROLLER_USERNAME, CONTROLLER_PASSWORD
2. Run the playbook, `ansible-playbook extensions/experiences/load_experience.yml`
3. Optionally, you can load a specific experience by setting the name. For example `-e experience_name=vmware_ops`
