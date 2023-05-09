!SLIDE subsection
# ~~~SECTION:MAJOR~~~ Orchestration & <br/>Configuration management

!SLIDE smbullets small
# Orchestration

* Definition:

 * *In system administration, orchestration is the automated configuring, coordinating, and managing of computer systems and software.*

* Tasks required in addition to Configuration management
* Foreman uses the Remote Execution plugin for this utilizing different providers

~~~SECTION:handouts~~~

****

The definition taken from Wikipedia explains orchestration as "automated configuring, coordinating, and managing of computer systems and software."

While there are many tools for the "automated configuring" part, there are additional takes not solved by them.
So with the integration of these tools there was still a gap to fill which was done with the plugin Remote Execution.
This plugin utilizes different providers to run jobs on systems for "coordinating and managing" them.

~~~ENDSECTION~~~


!SLIDE smbullets small
# Configuration management

* Definition:

 * *Configuration management is a systems engineering process for establishing and maintaining consistency of a product performance, functional, and physical attributes with its requirements, design and operational information throughout its life.*

* Tools integrated in Foreman:
 * Puppet
 * Chef
 * Salt
 * Ansible

~~~SECTION:handouts~~~

****

Wikipedia defines configuration management as a *systems engineering process for establishing and maintaining consistency of a 
product's performance, functional, and physical attributes with its requirements, design and operational information throughout
its life.*

~~~PAGEBREAK~~~

So configuration management software is used to describe a desired state, configure a system to be in this state and recognize
drifts from this state to revert them.

Foreman integrates different tools to solve this task. Puppet is deeply integrated because Foreman started as a WebGUI for it,
but the UI parts were moved to a plugin to get it in line with the other tools. The features of the plugins differ depending
on the capabilities based on the tools they depend on. For example some can only report system information and state while others can assign a configuration
using the web interface. Some tools also have a focus more on rapid deployment than on managing the system state.

We will use Puppet in this training because it provides the complete feature set and its descriptive language is also quite accessible/readable
without knowing Puppet in-depth. As a second option Ansible is integrated for its simplicity and being quite common in environments
introducing configuration management nowadays.

~~~ENDSECTION~~~
