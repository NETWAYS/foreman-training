!SLIDE subsectionnonum
# API

!SLIDE smbullets small
# API

* Version 1 of the API is deprecated
* Version 2 
 * JSON API
 * Shared with Katello
 * Requires username and password
 * Collections are paged
 * Search strings like provided in the WebGUI
 * Apidoc generated on your system at /apidoc
* GraphQL
 * Available since 1.22, still considered experimental
 * Intended for development

~~~SECTION:handouts~~~

****

~~~PAGEBREAK~~~

Foreman provides a web based JSON API which is shared with Katello. This is Version 2 of the
API which is favored instead of the already deprecated version 1. It requires an authentication
by username and password. Perhaps unusal is the handling of collections which are paged in the
same way like in the webinterface. The same way it handles search strings like they are provided
in the WebGUI but they have to be URL encoded.

Another API was introduced with GraphQL in 1.22. This API is more intended for development of
plugins instead of scripting and still considered experimental, but should cover all objects
of the core now and be available for a good number of plugins already.

Usage explainations can be found at http://theforeman.org/manuals/latest/index.html#5.1API

API documentation is located at http://theforeman.org/api/2.0/index.html or on your system at /apidocs.

~~~ENDSECTION~~~

!SLIDE smbullets small
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Working with the API

* Objective:
 * Use the API to query, create and update objects
* Steps:
 * Query the API for all subnets
 * Query the API for all Debian hosts
 * Create a hostgroup "training" using the API
 * Change the root password for the hostgroup "training" using the API

!SLIDE supplemental exercises
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Working with the API

## Objective:

****

* Use the API to query, create and update objects

## Steps:

****

* Query the API for all subnets using the URL endpoint "/api/subnets"
* Query the API for all Debian hosts using the URL endpoint "/api/hosts" and the search "os=Debian" or "facts.osfamily=Debian"
* Create a hostgroup "training" using the API with valid defaults
* Change the root password for the hostgroup "training" using the API

!SLIDE supplemental solutions
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Working with the API

****

## Use the API to query, create and update objects

****

### Query the API for all subnets using the URL endpoint "/api/subnets"

    # curl -k -u admin:PASSWORD -H "Accept: version=2,application/json" \ 
    https://foreman.localdomain/api/subnets | python3 -m json.tool

### Query the API for all Debian hosts using the URL endpoint "/api/hosts" and the search "os=Debian" or "facts.osfamily=Debian"

If you want to see all systems configured in Foreman with operating system "Debian" run the following curl command. 
This will also include hosts with provisioning pending.

    # curl -k -u admin:PASSWORD -H "Accept: version=2,application/json" \ 
    https://foreman.localdomain/api/hosts?search=os%3DDebian | python3 -m json.tool

If you want to see all systems reported to run operating system "Debian" :

    # curl -k -u admin:PASSWORD -H "Accept: version=2,application/json" \ 
    https://foreman.localdomain/api/hosts?search=facts.osfamily%3DDebian | python3 -m json.tool

### Create a hostgroup "training" using the API with valid defaults

In the following command the ids depend on your environment and may differ:

    # curl -k -u admin:PASSWORD -H "Accept: version=2,application/json" -H "Content-Type: application/json" \ 
    -X POST -d '{ "name":"training", "environment_id":1, "puppet_ca_proxy_id":1, "puppet_proxy_id":1, 
    "subnet_id":1, "domain_id":1, "architecture_id":1, "operatingsystem_id":1, "medium_id":1, "ptable_id":94, 
    "root_pass":"start123", "organization_id":2, "location_id":1 }' \
    https://foreman.localdomain/api/hostgroups | python3 -m json.tool

### Change the root password for the hostgroup "training" using the API

You can verify the change in the Audits menu afterwards with:

    # curl -k -u admin:PASSWORD -H "Accept: version=2,application/json" -H "Content-Type: application/json" \ 
    -X PUT -d '{ "root_pass":"St@rt123" }' \
    https://foreman.localdomain/api/hostgroups/training | python3 -m json.tool
