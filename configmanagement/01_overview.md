!SLIDE subsection
# ~~~SECTION:MAJOR~~~ Configuration management

!SLIDE smbullets small
# Configuration management

* Definition:

*Configuration management is a systems engineering process for establishing and maintaining consistency of a 
product performance, functional, and physical attributes with its requirements, design and operational 
information throughout its life.*

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

So configuration management software is used to describe a desired state, configure a system to be in this state and recognize
drifts from this state to revert them.

~~~PAGEBREAK~~~

Foreman integrates different tools to solve this task. Puppet is deeply integrated because Foreman started as a WebGUI for it,
but it is planned to move on to a state being a plugin equal to all the other solutions. The features of the plugins differ depending
on the capabilities based ont the tools they depend on. For example some can only report system information and state while others can assign a configuration
using the web interface. Some tools also have a focus more on rapid deployment than on managing the system state.

We will use puppet in this training because it provides the complete feature set and its descriptive language is also quite accessible/readable
without knowing puppet in-depth.

~~~ENDSECTION~~~

