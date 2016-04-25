!SLIDE subsectionnonum
# Multitenancy

!SLIDE smbullets small
# Multitenancy

* Adds Organizations and/or Locations
 * Can be nested
* All Objects require one context
* User
 * can have multiple contexts
 * can have a default context
 * keep care of in which context he works

~~~SECTION:handouts~~~

****

Foreman has build in multitenancy which is not enabled by default. To enable it run the Foreman Installer
with the corresponding parameters or edit "/etc/foreman/settings.yaml". 

Depending on your needs you can add Organizations and/or Locations. After that every object will require 
exactly one context with the exception of users who can have multiple contexts and one of these assigned
as their default context. But he has to keep care of in which context he works because objects he creates
will be in this context.

Organization and Location can both be nested to represent a hierarchy with a top-down approach.

~~~PAGEBREAK~~~

The best way to think about multitenancy is in advance and if it could be required directly from the start of your enviroment. 
Later enabling is possible but migration is a quite challenging and time consuming task.  

In Katello it is enabled by default, so we will see it in the last chapter.

~~~ENDSECTION~~~
