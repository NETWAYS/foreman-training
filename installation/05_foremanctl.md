!SLIDE smbullets small
# foremanctl

* Containerized installation
 * Uses Ansible
 * Uses Podman-quadlet
 * Containers use same packages
* Currently in Technology Preview state
 * Only scenario Katello
 * Only Smart Proxy "Pulpcore"
* Currently in Development
 * Support for more features like Remote Execution
 * Support for more Foreman plugins

~~~SECTION:handouts~~~
****

Foreman is currently installed from packages via the foreman-installer, but there is a new approach for a containerized installation named foremanctl.
It makes use of Ansible and Podman-quadlet to manage the installation. The containers are prebuilt using the same packages.

The new way to set up Foreman is only in Technology Preview state as it supports only the scenario Katello with one Smart Proxy "Pulpcore".
But development is ongoing and the next planned features are support for more features like Remote Execution requiring more Smart Proxies and support for more Foreman plugins which will be pre-installed.
Future Development will also have to handle the Smart Proxies which manage an external service like DNS or DHCP before it can replace package-based installation. Without the need for packaging it is planned to switch to source-based containers. Also it should not only support the local installation via Podman-quadlet, but also run on any container platform.
~~~ENDSECTION~~~
