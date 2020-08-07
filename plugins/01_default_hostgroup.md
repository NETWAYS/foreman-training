!SLIDE smbullets small
# Default Hostgroup

* Sets a default hostgroup on host creation
* Configured as a yaml hash

* _Use case:_ 
 * Introduce Foreman in an already puppetized environment
 * Combines well with Ansible setup and callback

~~~SECTION:handouts~~~

****

If a host does not already exist, it will be created when the first puppet run (or a different report) triggers
the upload of the facts. Normally the host is added without any additional configuration
in Foreman, the plugin "Default Hostgroup" simply adds the possibility to set a default
hostgroup to assign to these newly created hosts. This allows to add a classification
via the hostgroup already on the first run and without manual intervention.

~~~PAGEBREAK~~~

To use it simply install the package and create a file "/etc/foreman/plugins/default_hostgroup.yaml"
containing a hash which maps facts to hostgroups to assign.

    ---
    :default_hostgroup:
      :facts_map:
        "Default":
          "hostname": ".*"

<br/>

The plugin is very useful if you plan to embed Foreman in an already puppetized
environment as Puppet ENC. It also works fine with Ansible setup module and 
callback plugin to get hosts in Foreman. A similar workflow should be available
for all other configuration management solutions.

More details on: https://github.com/theforeman/foreman_default_hostgroup

~~~ENDSECTION~~~
