!SLIDE smbullets small
# Ansible

* Written in python
* Runs on Linux, Unix, Windows
* Describes desired state in yaml files

<pre>
    ---
    - name: Install package vim
      become: true
      yum: name={{ item }} state=installed
      with_items:
      - vim-enhanced
</pre>

* Workflow
 * Roles or Playbook stored on a system with Ansible installed
 * Inventory is managed for Ansible
 * Ansible connects to a system and collects system information
 * Ansible runs tasks on the system
 * Ansible can report back to other tools via callback plugin

~~~SECTION:handouts~~~

****
<br/>

Ansible is written in python and its control machine runs on Linux while it is possible to manage Linux, Unix and Windows.

For configuration it uses yaml format for simple playbooks and some additional structure for roles. An example for one
task is shown above. Those files are stored on one or more control machines which also need an inventory as a static
file or script for dynamic inventory. There is no agent required as it utilizes SSH (or winrm for Windows), so the control machine
connects to one or more systems to collect system information and run tasks on them. Afterwards callback plugins are used to report
back to other tools.

~~~ENDSECTION~~~

~~~ENDSECTION~~~

!SLIDE smbullets small
# Foreman Ansible Integration

* Foreman -> Ansible
 * Smart proxy Ansible allows to import Ansible roles
 * Smart proxy Ansible allows to play Ansible roles

* Ansible -> Foreman
 * Ansible uploads facts to Foreman via callback
 * Ansible transfers reports to Foreman via callback
 * Ansible can use Foreman as dynamic inventory

~~~SECTION:handouts~~~

****

Foreman can integrate Ansible in several ways and can also integrate itself into Ansible. Communication from the WebGUI to Ansible is handled
using the Smart proxy for Ansible. It allows to import Ansible roles known to Ansible and to play Ansible roles. The configuration automatically
includes the callback to upload facts and reports.

~~~PAGEBREAK~~~

On a separate Ansible control machine a callback plugin can be activated to upload facts and reports to Foreman, if you still want to use Ansible
independent from Foreman. Forthermore a script could be deployed to use Foreman as dynamic inventory.

For more information have a look at the plugin documentation: https://docs.theforeman.org/3.9/Managing_Configurations_Ansible/index-katello.html

~~~ENDSECTION~~~


!SLIDE smbullets small
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Configure Graphical Integration

* Objective:
 * Configure Foreman Plugin and Smart Proxy Plugin
* Steps:
 * Install Foreman Plugin and Smart Proxy Plugin
 * Download the collection "community.general"
 * Download the role "geerlingguy.ntp"
 * Import roles and assign them
 * Play roles using the webinterface 
* Optional:
 * Import variables and overwrite values

~~~SECTION:notes~~~

* This exercises is for those that want to use Ansible integrated in Foreman

~~~ENDSECTION~~~

~~~SECTION:handouts~~~

****

Graphical integration uses Remote-Execution plugin which we covered earlier.

~~~ENDSECTION~~~

!SLIDE supplemental exercises
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Configure Graphical Integration

## Objective:

****

* Configure Foreman Plugin and Smart Proxy Plugin

## Steps:

****

* Install Foreman Plugin and Smart Proxy Plugin using foreman-installer
* Download the collection "community.general"
* Download the role "geerlingguy.ntp"

Ansible roles and collections can be downloaded from Ansible Galaxy using the CLI or a Remote Execution Job.

* Import roles and assign them
* Play roles using the webinterface 

Optional: 

* Import variables and overwrite values to adjust the ntp configuration 


~~~ENDSECTION~~~

!SLIDE supplemental solutions
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Configure Graphical Integration

****

## Configure Foreman Plugin and Smart Proxy Plugin

****

### Install Foreman Plugin and Smart Proxy Plugin using foreman-installer

    # foreman-installer --enable-foreman-plugin-ansible --enable-foreman-proxy-plugin-ansible

### Download the collection "community.general"

You can run this on the commandline or use the Job "Ansible Collection - Install from Galaxy" from the category "Ansible Galaxy".

    # ansible-galaxy collection install community.general -p /etc/ansible/collections

### Download the role "geerlingguy.ntp"

You can run this on the commandline or use the Job "Ansible Roles - Install from Galaxy" from the category "Ansible Galaxy".

    # ansible-galaxy install geerlingguy.ntp -p /etc/ansible/roles

### Import roles and assign them

Navigate to "Configure > Ansible > Roles" and import using "Import from foreman.localdomain".
Afterwards navigate to the host and edit them to assign the roles in the new tab group "Ansible" on the tab "Roles".

### Play roles using the webinterface 

Navigate to the host and press "Run Ansible roles" from the "Schedule Remote Job" selection. It is also available as action from the Host overview for bulk requests.

### Optional: Import variables and overwrite values

Navigate to "Configure > Ansible > Variables" and import using "Import from foreman.localdomain".
After the import set "ntp_manage_config" to "true" and "ntp_area" to your country code, e.g. "de" for Germany.

!SLIDE smbullets small
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Configure Ansible Callback

* Objective:
 * Install Ansible-Core and configure the callback plugin for Foreman
* Steps:
 * Install Ansible-Core
 * Configure callback plugin
 * Add your host to the inventory
 * Create and distribute a SSH key
 * Run Ansibles setup module

~~~SECTION:notes~~~

* This exercises is for those that want to import existing Hosts via Ansible
* The inventory should be created in an automatic way like export from a cmdb

~~~ENDSECTION~~~

!SLIDE supplemental exercises
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Configure Ansible Callback

## Objective:

****

* Install Ansible and configure the callback plugin for Foreman

## Steps:

****

* Install Ansible-Core using dnf

Ansible is available from centos-extras repository, the callback plugin also requires python-requests.
In our training setup Ansible is already installed on the Foreman system if you have done the previous exercise.

* Configure callback plugin 

The callback plugin is moved to the Foreman Ansible Modules forming the Ansible collection "theforeman.foreman" since Ansible 2.10, 
so easiest way to install it is via dnf as "ansible-collection-theforeman-foreman" from the client repository.
The plugin itself can be enabled in the default section of ansible.cfg and configured in a new section of the configuration.
Furthermore a setting needs to be enabled so Ansible uses the callback also on the `ansible` command in addition to `ansible-playbook`.

* Add your host to the inventory

We will use the static configuration for now.

* Create and distribute a SSH key

Use `ssh-keygen` and `ssh-copy-id`.

* Run Ansibles setup module

The setup module gathers facts about the system and via callback uploads them to Foreman which creates hosts.

#### Expected result:

* Setup module is played successfully and report is uploaded to Foreman.


!SLIDE supplemental solutions
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Configure Ansible Callback

****

## Install Ansible and configure the callback plugin for Foreman

****

### Install Ansible using dnf

    # dnf install ansible-core python3.12-requests -y

### Configure callback plugin 

    # dnf config-manager --add-repo http://yum.theforeman.org/plugins/3.9/el8/x86_64/
    # dnf install ansible-collection-theforeman-foreman -y
    # vi /etc/ansible/ansible.cfg
    [defaults]
    callbacks_enabled = foreman
    bin_ansible_callbacks = True
    [callback_foreman]
    url = 'https://foreman.localdomain'
    ssl_cert = /etc/foreman-proxy/foreman_ssl_cert.pem
    ssl_key = /etc/foreman-proxy/foreman_ssl_key.pem
    verify_certs = /etc/foreman-proxy/foreman_ssl_ca.pem

### Add your host to the inventory

    # echo "foreman.localdomain" >> /etc/ansible/hosts

### Create and distribute a SSH key

    # ssh-keygen
    [Enter]
    [Enter]
    [Enter]
    # ssh-copy-id foreman.localdomain

### Run Ansibles setup module

    # ansible -m setup all

