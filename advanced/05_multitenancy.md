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

Foreman has built-in multitenancy enabled by default. 
Depending on your needs you can add Organizations and/or Locations. Every object will require 
exactly one context with the exception of users who can have multiple contexts and one of these assigned
as their default context. But he has to keep care of in which context he works because objects he creates
will be in this context.

~~~PAGEBREAK~~~

Organization and Location can both be nested to represent a hierarchy with a top-down approach.
Katello is limiting nesting to Locations and does not support it for Organizations.

~~~ENDSECTION~~~
