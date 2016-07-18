!SLIDE smbullets small
# Templates

* Creates a synchronisation job for templates
 * Community Templates
 * Your own git repository

* _Use case:_
 * Get additional templates maintained by the community
 * Manage your own templates with external versioning

~~~SECTION:handouts~~~

****

By installing the plugin you get a synchronisation job for templates which per default
import the community templates from https://github.com/theforeman/community-templates
matching your Foreman version and adding support for more operating systems. This job can
also be used to import your own git repository if you want to manage the templates on
an external version control system. In addition the imported templates will also be associated
to the existing operating systems.

More details on: https://github.com/theforeman/foreman_templates

~~~ENDSECTION~~~

!SLIDE smbullets small
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Templates

* Objective:
 * Import the Community templates
* Steps:
 * Install the Foreman Plugin Templates
 * Run the synchronisation job

!SLIDE supplemental exercises
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Templates

## Objective:

****

* Import the Community templates

## Steps:

****

* Install the Foreman Plugin Templates using the foreman-installer
* Run the synchronisation job with "foreman-rake templates:sync"

#### Expected result:

Additional templates with the prefix "Community" are available in the WebGUI.

!SLIDE supplemental solutions
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Templates

****

## Import the Community templates

****

### Install the Foreman Plugin Templates using the foreman-installer

    # foreman-installer --enable-foreman-plugin-templates

### Run the synchronisation job with "foreman-rake templates:sync"

    # foreman-rake templates:sync
