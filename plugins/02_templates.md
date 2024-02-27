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
which was deprecated in favor of having provisioning templates in the main project underneath
"/app/views/unattended" and other templates in their matching project. 

~~~PAGEBREAK~~~

This job can also be used to import your own git repository if you want to manage the templates on
an external version control system. In addition the imported templates will also be associated
to the existing operating systems. Another option is to use the export function for syncing
changes back to a repository.

More details on: https://theforeman.org/plugins/foreman_templates/8.0/index.html

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
 * Change settings to import from the current repository
 * Run the synchronisation job

!SLIDE supplemental exercises
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Templates

## Objective:

****

* Import the Community templates

## Steps:

****

* Install the Foreman Plugin Templates using the foreman-installer
* Change settings to import from the current repository
* Run the synchronisation job (using UI, with Rake job or an API call)

#### Expected result:

Additional templates are available in the WebGUI.

!SLIDE supplemental solutions
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Templates

****

## Import the Community templates

****

### Install the Foreman Plugin Templates using the foreman-installer

    # foreman-installer --enable-foreman-plugin-templates

### Change settings to import from the current repository

Change the settings on the "TemplateSync" tab of "Administer > Settings" to point to the new location.
The repo is the clone URL of the project "https://github.com/theforeman/foreman.git" and the dirname is "/app/views/unattended".
The branch can be set to the current version of Foreman like "3.9-stable" if you want to be sure to not get incompatible versions.
Filter and prefix can also help to manage the templates.

### Run the synchronisation job with (using UI, with Rake job or an API call)

Navigate to "Hosts > Templates > Sync Templates" and use the wizard to sync or as an alternative use one of the following commands.

    # foreman-rake templates:import
    # curl -H "Accept:application/json,version=2" -H "Content-Type:application/json" \
    -u admin:PASSWORD -k https://foreman.localdomain/api/v2/templates/import -X POST
