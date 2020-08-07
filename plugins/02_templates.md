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

More details on: https://theforeman.org/plugins/foreman_templates/6.0/index.html

A different approach is provided by the plugin "foreman_git_templates" which directly
uses the templates stored in git without syncing them to Foreman.

For details visit: https://github.com/dm-drogeriemarkt/foreman_git_templates

~~~ENDSECTION~~~

!SLIDE smbullets small
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Templates

* Objective:
 * Import the Community templates
* Steps:
 * Install the Foreman Plugin Templates
 * Run the synchronisation job
* Optional:
 * Change settings to add a prefix during import

!SLIDE supplemental exercises
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Templates

## Objective:

****

* Import the Community templates

## Steps:

****

* Install the Foreman Plugin Templates using the foreman-installer
* Run the synchronisation job (using UI, with Rake job or an API call)

## Optional:

****

* Change settings to add a prefix during import

#### Expected result:

Additional templates are available in the WebGUI.

!SLIDE supplemental solutions
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Templates

****

## Import the Community templates

****

### Install the Foreman Plugin Templates using the foreman-installer

    # foreman-installer --enable-foreman-plugin-templates

### Run the synchronisation job with (using UI, with Rake job or an API call)

Navigate to "Hosts > Sync Templates" and use the wizard to sync.

    # foreman-rake templates:import
    # curl -H "Accept:application/json,version=2" -H "Content-Type:application/json" \
    -u admin:PASSWORD -k https://foreman.localdomain/api/v2/templates/import -X POST

### Optional: Change settings to add a prefix during import

Optionally change the settings on the "TemplateSync" tab of "Administer > Settings" to add a Prefix
