import testinfra
import pytest

@pytest.fixture
def host(request):
    # Create the Testinfra host using the Ansible inventory
    print("the host :: ", testinfra.get_host(f'ansible://{request.config.getoption("--ansible-inventory")}'))
    return testinfra.get_host(f'ansible://{request.config.getoption("--ansible-inventory")}')

def test_vm_os(host):
    # Use Testinfra to check the properties of the VM
    distribution = host.system_info.distribution
    release = host.system_info.release
    print("release :: ", release)
    version = host.system_info.release

    # Assert the expected OS type
    assert distribution.lower() == 'linux'
    assert version.startswith('7.')  # Adjust this based on your expected OS version