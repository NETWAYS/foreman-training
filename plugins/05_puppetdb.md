!SLIDE smbullets small
# PuppetDB

* Disable hosts in the PuppetDB during deletion
* Display the PuppetDB in the dashboard

* _Use case:_ Should always be installed when using PuppetDB with Foreman

~~~SECTION:handouts~~~

****

When PuppetDB is used with Foreman there is normally no interaction between both, they are completely
two different independent report targets. With this plugin a host is also disabled in PuppetDB when it is deleted in
Foreman.

In addition the PuppetDB dashboard is also integrated in the Foreman WebGUI to display the performance of
the backend.

More details on: https://github.com/theforeman/puppetdb_foreman

~~~ENDSECTION~~~
