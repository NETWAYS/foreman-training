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
 * Ansible uses Foreman as dynamic inventory

~~~SECTION:handouts~~~

****

Foreman can integrate Ansible in several ways and can also integrate itself into Ansible. Communication from the WebGUI to Ansible is handled
using the Smart proxy for Ansible. It allows to import Ansible roles known to Ansible and to play Ansible roles.

~~~PAGEBREAK~~~

On the Ansible control machine a callback plugin can be activated to upload facts and reports to Foreman. Forthermore a script could be deployed
to use Foreman as dynamic inventory.

~~~ENDSECTION~~~


!SLIDE smbullets small
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Configure Ansible Callback

* Objective:
 * Install Ansible and configure the callback plugin for Foreman
* Steps:
 * Install Ansible
 * Configure callback plugin
 * Add your host to the inventory
 * Create and distribute a SSH key
 * Download the role "geerlingguy.ntp"
 * Create a playbook and run it

!SLIDE supplemental exercises
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Configure Ansible Callback

## Objective:

****

* Install Ansible and configure the callback plugin for Foreman

## Steps:

****

* Install Ansible using yum

Ansible is available from centos-extras repository, the callback plugin also requires python-requests.

* Configure callback plugin 

The callback plugin is part of Ansible since 2.2, so only needs to be enabled in the configuration.
The plugin itself requires environment variables to be set for configuration.

* Add your host to the inventory

We will use the static configuration for now, dynamic inventory will be introduced later.

* Create and distribute a SSH key

Use `ssh-keygen` and `ssh-copy-id`.

* Download the role "geerlingguy.ntp"

Ansible roles can be downloaded from Ansible Galaxy using the CLI.

* Create a playbook and run it

The playbook only requires an array of hosts and roles.

#### Expected result:

* Playbook is played successfully and report is uploaded to Foreman.


!SLIDE supplemental solutions
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Configure Ansible Callback

****

## Install Ansible and configure the callback plugin for Foreman

****

### Install Ansible using yum

    # yum install ansible python-requests

### Configure callback plugin 

    # vi /etc/ansible/ansible.cfg
    [defaults]
    callback_whitelist = foreman
    ...
    [callback_foreman]
    url = 'https://foreman.localdomain'
    ssl_cert = /etc/puppetlabs/puppet/ssl/certs/foreman.localdomain.pem
    ssl_key = /etc/puppetlabs/puppet/ssl/private_keys/foreman.localdomain.pem
    verify_certs = /etc/puppetlabs/puppet/ssl/certs/ca.pem

### Add your host to the inventory

    # echo "foreman.localdomain" >> /etc/ansible/hosts

### Create and distribute a SSH key

    # ssh-keygen
    [Enter]
    [Enter]
    [Enter]
    # ssh-copy-id foreman.localdomain

### Download the role "geerlingguy.ntp"

    # ansible-galaxy install geerlingguy.ntp -p /etc/ansible/roles

### Create a playbook and run it

    # vi playbook.yml
    ---
    - hosts: foreman.localdomain
      roles:
        - geerlingguy.ntp
    # ansible-playbook playbook.yml


!SLIDE smbullets small
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Configure Ansible Dynamic Inventory

* Objective:
 * Configure Ansible Dynamic Inventory
* Steps:
 * Download Dynamic Inventory and sample configuration
 * Adjust configuration
 * Test Dynamic Inventory
* Optional:
 * Distribute the SSH key and change the playbook to all hosts


!SLIDE supplemental exercises
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Configure Ansible Dynamic Inventory

## Objective:

****

* Configure Ansible Dynamic Inventory

## Steps:

****

* Download Dynamic Inventory and sample configuration

Dynamic Inventory scripts are not included in the package, but available at Github: https://github.com/ansible/ansible/tree/devel/contrib/inventory

* Adjust configuration

Configuration has to include Foreman url, user and password.

* Test Dynamic Inventory

You can run the script directly to the output and use it with the parameter `-i` during playbook runs.


!SLIDE supplemental solutions
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Configure Ansible Dynamic Inventory

****

## Configure Ansible Dynamic Inventory

****

### Download Dynamic Inventory and sample configuration

    # wget -P /etc/ansible/ http://raw.githubusercontent.com/ansible/ansible/devel/contrib/inventory/foreman.ini
    # wget -P /etc/ansible/ http://raw.githubusercontent.com/ansible/ansible/devel/contrib/inventory/foreman.py
    # chmod +x /etc/ansible/foreman.py

### Adjust configuration

    # vi /etc/ansible/foreman.ini
    [foreman]
    url = https://foreman.localdomain
    user = admin
    password = netways
    ssl_verify = False

### Test Dynamic Inventory

    # /etc/ansible/foreman.py
    # ansible-playbook -i /etc/ansible/foreman.py playbook.yml


!SLIDE smbullets small
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Configure Graphical Integration

* Objective:
 * Configure Foreman Plugin and Smart Proxy Plugin
* Steps:
 * Install Foreman Plugin and Smart Proxy Plugin
 * Import roles and assign them
 * Prepare Smart proxy to play roles
 * Play roles using the webinterface 

~~~SECTION:handouts~~~

****

Graphical integration uses Remote-Execution plugin which will be covered later in more depth.

~~~ENDSECTION~~~

!SLIDE supplemental exercises
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Configure Graphical Integration

## Objective:

****

* Configure Foreman Plugin and Smart Proxy Plugin

## Steps:

****

* Install Foreman Plugin and Smart Proxy Plugin using foreman-installer
* Import roles and assign them
* Prepare Smart proxy to play roles

Smart Proxy needs a SSH key to play roles.

* Play roles using the webinterface 

~~~ENDSECTION~~~

!SLIDE supplemental solutions
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Configure Graphical Integration

****

## Configure Foreman Plugin and Smart Proxy Plugin

****

* Install Foreman Plugin and Smart Proxy Plugin using foreman-installer


<pre><code># foreman-installer --enable-foreman-plugin-ansible --enable-foreman-proxy-plugin-ansible</code></pre>


* Import roles and assign them

Navigate to "Configure > Roles" and import using "Import from foreman.localdomaon".
Afterwards navigate to the host and edit them to assign the roles in the new "Ansible Roles" tab.

* Prepare Smart proxy to play roles

<pre><code># install -o foreman-proxy -g foreman-proxy -m 0700 -d ~foreman-proxy/.ssh
# su - foreman-proxy -s /bin/bash
# ssh-keygen -f .ssh/id_rsa_foreman_proxy
[ENTER]
[ENTER]
# ssh-copy-id -i .ssh/id_rsa_foreman_proxy root@foreman.localdomain
</code></pre>

* Play roles using the webinterface 

Navigate to the host and press "Run Ansible roles" from the "Schedule Remote Job" selection. It is also available as action from the Host overview for bulk requests.
