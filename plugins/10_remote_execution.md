!SLIDE smbullets small
# Remote Execution

* Execute jobs on remote systems from the Foreman WebGUI
* It can handle different protocols
 * SSH
 * Ansible

* _Use case:_ 
 * Trigger configuration management runs immediately
 * Execute one-time or irregular commands
 * Orchestrate operations on servers
 * OpenSCAP scans on demand

~~~SECTION:handouts~~~

****

The Foreman Plugin Remote Execution adds WebGUI and workflow for executing jobs on remote systems.
It utilizes different providers, which are SSH and Ansible for now.

The SSH provider runs per default command as root, but can also be configure to run as unpriviledged
user and run sudo to accquire elevated privileges.

~~~PAGEBREAK~~~

It is usefully to trigger configuration management runs immediately to get an adhoc deployment,
execute one-time or irregular commands and also to orchestrate operations like updates on your servers.
It also allows to schedule jobs or reoccurring execution.

With the OpenSCAP plugin installed in addition an option to run scans on demand is added.

More details on: https://theforeman.org/plugins/foreman_remote_execution/1.3/index.html

~~~ENDSECTION~~~

!SLIDE smbullets small
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Remote Execution

* Objective:
 * Trigger a Puppet run on a remote system
* Steps:
 * Install the Foreman Plugin Remote Execution
 * Bring out the SSH key
 * Initiate the Puppet run
* Optional:
 * Run OpenSCAP scan

!SLIDE supplemental exercises
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Remote Execution

## Objective:

****

* Initiate a Puppet run on a remote system

## Steps:

****

* Install the Foreman Plugin Remote Execution using the Foreman Installer
* Bring out the SSH key
* Initiate the Puppet run

## Optional:

****

* Run OpenSCAP scan

#### Expected result:

Puppet run is executed on the remote system and report is uploaded


!SLIDE supplemental solutions
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Remote Execution

****

## Trigger a Puppet run on a remote system

****

### Install the Foreman Plugin Remote Execution using the Foreman Installer

This will install both the Foreman and Smart proxy Plugin, create a SSH key and restart the services.

    # foreman-installer --enable-foreman-plugin-remote-execution \
                        --enable-foreman-proxy-plugin-remote-execution-ssh

### Bring out the SSH key

You can use the "ssh-copy-id":

    # ssh-copy-id -i ~foreman-proxy/.ssh/id_rsa_foreman_proxy root@foreman.localdomain

Or get it via the Smart proxy:

    # curl -k https://foreman.localdomain:8443/ssh/pubkey >> ~/.ssh/authorized_keys

### Trigger the Puppet run

Navigate to the host and press "Schedule Remote Job". For multiple hosts the action is also available in the action menu
of the "All Hosts" view. To Trigger the Puppet agent run, select the Job Category "Puppet" which has the
"Puppet Run Once" as default Job. For more output add "puppet_options" "--verbose". Press "Submit" to execute it and watch
for the execution.

### Optional: Run OpenSCAP scan

Navigate to the host and press "Run OpenSCAP scan". It will automatically choose the Policy in this way.


!SLIDE smbullets small
# Remote Execution - Job Templates

* Similar to Provisioning Templates
* Input
 * User Input - free-form or list of values
 * Fact value
 * Variable
 * Puppet parameter
 * Reference on other templates
 * Special ERB function "input"
* Default Templates:
 * Puppet Run Once
 * Package Action
 * Service Action
 * Run Command

~~~SECTION:handouts~~~

****

It is also possible to write templates for jobs in a similar manner like Provisioning Templates. In this
templates you can use a special function "input" to get the value of input fields associated to it. These
fields can be a free-form or list of values for a user to add, facts, variables or Puppet parameters. 

~~~PAGEBREAK~~~

Furthermore you can reference another template, which you can also render in your newly created one with the
"render_template" function.

The default templates provided are "Puppet Run Once" to trigger a puppet run, "Package Action" for handling
package management and "Service Action" for managing service which both include operating system specific 
handling and "Run Command" to run a simple commandline.

~~~ENDSECTION~~~


!SLIDE smbullets small
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Remote Execution - Job Template

* Objective:
 * Create a Job Template "ping" to run the ping command on remote hosts
* Steps:
 * Create a Job Template to run ping with default values and input field
 * Run it without input
 * Run it with input


!SLIDE supplemental exercises
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Remote Execution - Job Template

## Objective:

****

* Create a Job Template "ping" to run the ping command on remote hosts

## Steps:

****

* Create a Job Template to run ping with default values for count and target and input field for target
* Run it without input and inspect the output
* Run it with input and inspect the output


!SLIDE supplemental solutions
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Remote Execution - Job template

****

## Create a Job Template "ping" to run the ping command on remote hosts

****

### Create a Job Template to run ping with default values for count and target and input field for target

Navigate to "Hosts > Job templates" and click "New Job Templates". As a template use something like this:

    ping -c 10 <%= input("ping_target").blank? ? "8.8.8.8" : input("ping_target") %>

On the "Job" tab add an input with name "ping_target", input type "User input" and a description.

### Run it without input and inspect the output

Select a host to run the job without any input and have a look on the output by clicking the hostname on
the "Hosts" tab of the job.

### Run it with input and inspect the output

Select a host to run the job, provide a different target as input and have a look on the output by clicking
the hostname on the "Hosts" tab of the job.
