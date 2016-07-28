!SLIDE smbullets small
# Column View

* Adds additional columns to the "All Hosts" view

* _Use case:_ 
 * Present more information in the WebGUI
 * Add links to the other webinterfaces

~~~SECTION:handouts~~~

****

The Foreman Plugin Column View is a very simple example of enhancement an existing view
in Foreman but could be verify useful in combination with some custom facts like
showing the responsible team or project. It is also capable of adding additional links to
other webinterfaces providing additional information.

More details on: https://github.com/theforeman/foreman_column_view

~~~ENDSECTION~~~

!SLIDE smbullets small
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Column View

* Objective:
 * Add Architecture and Uptime to the "All Hosts" view
* Steps:
 * Install the Foreman Plugin Column View
 * Configure it to show the facts for architecture and uptime

!SLIDE supplemental exercises
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Column View

## Objective:

****

* Add Architecture and Uptime to the "All Hosts" view

## Steps:

****

* Install the Foreman Plugin Column View using the package "tfm-rubygem-foreman_column_view"
* Configure it to show the facts for architecture and uptime and restart the service

#### Expected result:

Additional columns are showing the values of the facts for architecture and uptime on all hosts which reported
a Puppet run.


!SLIDE supplemental solutions
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Column View

****

## Add Architecture and Uptime to the "All Hosts" view

****

### Install the Foreman Plugin Column View using the package "tfm-rubygem-foreman_column_view"

    # yum install tfm-rubygem-foreman_column_view -y

### Configure it to show the facts architecture and uptime and restart the service

    # cp /etc/foreman/plugins/foreman_column_view.yaml.example /etc/foreman/plugins/foreman_column_view.yaml
    # systemctl restart httpd.service
