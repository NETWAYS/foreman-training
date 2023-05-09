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

<br/>

An possibly incomplete list of plugins is provided by the Github page of the framework: https://theforeman.github.io/foreman-plugin-overview/

~~~ENDSECTION~~~

!SLIDE smbullets small
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Working with the CLI

* Objective:
 * Use the CLI to prepare a new Operatingsystem entry
* Steps:
 * Make sure to provide the correct credentials.
 * Create the new Operatingsystem entry for "CentOS Stream 9"
 * Optionally add the parameter "enable-official-puppet7-repo"

~~~SECTION:handouts~~~

****

For CentOS no need to associate templates occurs as there is a new feature handling this provided since Foreman 3.5, other Distributions than RHEL derivates still lack this feature, so additional steps are required.

~~~ENDSECTION~~~

!SLIDE supplemental exercises
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Working with the CLI

## Objective:

****

* Use the CLI to prepare a new Operatingsystem entry

## Steps:

****

* Make sure to provide the correct credentials.
* Create the new Operatingsystem entry for "CentOS Stream 9"
* Optionally add the parameter "enable-official-puppet7-repo"

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

### Create the new Operatingsystem entry for "CentOS Stream 9"

    # hammer os create --name CentOS --major 9 --description "CentOS Stream 9" --architectures x86_64 \ 
    --family "Redhat" --password-hash SHA256 --media "CentOS Stream 9 mirror" --partition-tables "Kickstart default"

### Optionally add the parameter "enable-official-puppet7-repo"

Instead of running a separate command later you can add the parameter "--os-parameters-attributes" on the initial run, take key value or json as imput

    # ... --os-parameters-attributes '[{"name":"enable-official-puppet7-repo","value":"true","parameter_type":"boolean"}]'

Otherwise you can use the same parameter with `hammer os update` or use the command `hammer os set-parameter` instead.

    # hammer os set-parameter --operatingsystem "CentOS Stream 9" --name enable-official-puppet7-repo --value true --parameter-type boolean
