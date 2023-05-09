!SLIDE smbullets small
# Remote Execution

* Execute jobs on remote systems from the Foreman WebGUI
* It can utilize different tools via providers
 * Script (SSH for push and MQTT for pull)
 * Ansible
 * Salt
* Provides a Cockpit integration via SSH

* _Use case:_ 
 * Trigger configuration management runs immediately
 * Execute one-time or irregular commands
 * Orchestrate operations on servers
 * OpenSCAP scans on demand (requires the plugin)
 * Webconsole to the systems

~~~SECTION:handouts~~~

****

~~~PAGEBREAK~~~

The Foreman Plugin Remote Execution adds WebGUI and workflow for executing jobs on remote systems.
It utilizes different providers.

The Script provider runs per default commands via SSH as root, but can also be configure to run as unpriviledged
user and run sudo to accquire elevated privileges. It also integrates Cockpit as a Webconsole using
this credentials and a SSH socket. Also a pull mode using mqtt was introduced to it.

The Ansible provider uses the same SSH configuration but uses Ansible syntax for the jobs.
The same goes for Salt.

It is usefully to trigger configuration management runs immediately to get an adhoc deployment,
execute one-time or irregular commands and also to orchestrate operations like updates on your servers.
It also allows to schedule jobs or reoccurring execution.

With the OpenSCAP plugin installed in addition an option to run scans on demand is added.

More details on: https://docs.theforeman.org/3.5/Managing_Hosts/index-katello.html#Configuring_and_Setting_Up_Remote_Jobs_managing-hosts

~~~ENDSECTION~~~

!SLIDE smbullets small
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Remote Execution

* Objective:
 * Trigger a Job on a remote system
* Steps:
 * Install the Foreman Plugin Remote Execution
 * Bring out the SSH key
 * Change the settings to use IP instead of FQDN
 * Schedule a Job executing the command "id"

!SLIDE supplemental exercises
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Remote Execution

## Objective:

****

* Trigger a Job on a remote system

## Steps:

****

* Install the Foreman Plugin Remote Execution using the Foreman Installer
* Bring out the SSH key
* Change the settings to use IP instead of FQDN

In our environment Foreman is not using itself as DNS server so we need to change the settings to use IP.

* Schedule a Job executing the command "id"

#### Expected result:

The Job is executed and the result is visible in the WebUI


!SLIDE supplemental solutions
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Remote Execution

****

## Trigger a Job on a remote system

****

### Install the Foreman Plugin Remote Execution using the Foreman Installer

This will install both the Foreman and Smart proxy Plugin, create a SSH key and restart the services.

    # foreman-installer --enable-foreman-plugin-remote-execution \
                        --enable-foreman-proxy-plugin-remote-execution-script

### Bring out the SSH key

You can use the "ssh-copy-id":

    # ssh-copy-id -i ~foreman-proxy/.ssh/id_rsa_foreman_proxy root@foreman.localdomain

Or get it via the Smart proxy (running on port 9090 on the Katello server instead of default 8443):

    # curl -k https://foreman.localdomain:9090/ssh/pubkey >> ~/.ssh/authorized_keys

### Change the settings to use IP instead of FQDN

Navigate to "Administer > Settings" and on the tab "Remote Execution" switch "Connect by IP" to "Yes".

### Schedule a Job executing the command "id"

Navigate to the host and press "Schedule a Job". For multiple hosts the action is also available in the action menu
of the "All Hosts" view. Keep the category "Commands" and the template "Run Command - Script default". 
Keep the selected host and add the command "id". No need to change any advanced fields or the schedule, so on the review press "Run" to execute it and watch
for the execution. By clicking on the host in the list, you can get the actual output of the Job run on the host.


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

~~~PAGEBREAK~~~

It is also possible to write templates for jobs in a similar manner like Provisioning Templates. In this
templates you can use a special function "input" to get the value of input fields associated to it. These
fields can be a free-form or list of values for a user to add, facts, variables or Puppet parameters. 

Furthermore you can reference another template, which you can also render in your newly created one with the
"render_template" function.

The default templates provided depend on the installed plugins and have evolved over time.

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

On the "Inputs" tab add an input with name "ping_target", input type "User input" and a description.

### Run it without input and inspect the output

Select a host to run the job without any input and have a look on the output by clicking the hostname on
the "Hosts" tab of the job.

### Run it with input and inspect the output

Select a host to run the job, provide a different target as input and have a look on the output by clicking
the hostname on the "Hosts" tab of the job.


!SLIDE smbullets small
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Remote Execution - Webconsole

* Objective:
 * Integrate Cockpit
* Steps:
 * Enable the integration in the Foreman plugin using the foreman-installer
 * Install Cockpit on the client
 * Access the webconsole from the host view


!SLIDE supplemental exercises
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Remote Execution - Webconsole

## Objective:

****

* Integrate Cockpit

## Steps:

****

* Enable the integration in the Foreman plugin using the foreman-installer

The integration requires some additional configuration which can all be automated by the parameter `--enable-foreman-plugin-remote-execution-cockpit`

* Install Cockpit on the client

Cockpit shows all of its installed plugins in the interface, but as a minimum you need to install `cockpit-system`.

* Access the webconsole from the host view

If the integration is enabled and Cockpit is detected on a system the webconsole button will be enabled on the host view.


!SLIDE supplemental solutions
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Remote Execution - Job template

****

## Integrate Cockpit

****

### Enable the integration in the Foreman plugin using the foreman-installer

Run the `foreman-installer` with `--enable-foreman-plugin-remote-execution-cockpit` to enable it.

    # foreman-installer --enable-foreman-plugin-remote-execution-cockpit

### Install Cockpit on the client

The client can be every system you prepared with the SSH key. The installation differs then based on the system.

On CentOS:

    # dnf install -y cockpit-system

On Debian/Ubuntu:

    # apt install -y cockpit-system

The websocket and access to it is not required, so installting this subpackage is enough, but you can add others for more features.

### Access the webconsole from the host view

Navigate to the Host overview and click on one of the prepared hosts to get the host view. In the host view click on the three dots and then "Web Console" to enter Cockpit.
You can see now some system information and control options depending on the installed Cockpit plugins, furthermore there is a terminal you can use.
