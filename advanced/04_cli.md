!SLIDE subsectionnonum
# CLI

!SLIDE smbullets small
# Hammer CLI

* Written in Ruby based on clamp
* Modular CLI
 * Basicly a framework
 * Plugins for Foreman
 * Some Foreman plugins provide a Hammer plugin
 * Other tools (especially around Katello)
 * Create your own plugin

~~~SECTION:handouts~~~

****

The commandline interface for Foreman is based on the Hammer CLI which is basicly a framework
written in Ruby based on clamp. Foreman provides a plugin to manage most aspects of Foreman
like the WebGUI and the API. Some of the Foreman plugins also provide a Hammer plugin, like 
some other tools especially around Katello do. But the framework is not limited to the Foreman
environment, so feel free to create your own plugins to solve your own administrative tasks.

A list of plugins is provided by the Github page of the framework: https://github.com/theforeman/hammer-cli

~~~ENDSECTION~~~

!SLIDE smbullets small
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Working with the CLI

* Objective:
 * Use the CLI to prepare a new Operatingsystem entry
* Steps:
 * Make sure to provide the correct credentials.
 * Create the new Operatingsystem entry for "CentOS 6.8"
 * Associate the template "Kickstart default PXELinux" and set it as default template
 * Associate the template "Kickstart default" and set it as default template


!SLIDE supplemental exercises
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Working with the CLI

## Objective:

****

* Use the CLI to prepare a new Operatingsystem entry

## Steps:

****

* Make sure to provide the correct credentials.
* Create the new Operatingsystem entry for "CentOS 6.8"
* Associate the template "Kickstart default PXELinux" and set it as default template
* Associate the template "Kickstart default" and set it as default template


!SLIDE supplemental solutions
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Working with the CLI

****

## Use the CLI to prepare a new Operatingsystem entry

****

### Make sure to provide the correct credentials.

Adjust the configuration if required in `~/.hammer/cli.modules.d/foreman.yml`:

   # vi ~/.hammer/cli.modules.d/foreman.yml
   :foreman:
     :username: 'admin'
     :password: 'PASSWORD'

### Create the new Operatingsystem entry for "CentOS 6.8"

    # hammer os create --name CentOS --major 6 --minor 8 --description "CentOS 6.8" --architectures x86_64 \ 
    --family "Redhat" --password-hash SHA256 --media "CentOS mirror" --partition-tables "Kickstart default"

### Associate the template "Kickstart default PXELinux" and set as default template

The ids may vary depending on our environment but you can get them with the list subcommands.

    # hammer template add-operatingsystem --name "Kickstart default PXELinux" \
    --operatingsystem "CentOS 6.8"
    # hammer os set-default-template --config-template-id 35 --id 6

### Associate the template "Kickstart default" and set as default template

    # hammer template add-operatingsystem --name "Kickstart default" \
    --operatingsystem "CentOS 6.8"
    # hammer os set-default-template --config-template-id 31 --id 6
