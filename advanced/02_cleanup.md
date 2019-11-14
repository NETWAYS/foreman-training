!SLIDE subsectionnonum
# Cleanup / Backup / Restore / Upgrade

!SLIDE smbullets small
# Cleanup

* Reports are send to the Foreman and stored in the database
 * Puppet reports every 30 minutes
 * Chef reports every 30 minutes
 * Salt reports every 10 minutes
 * Ansible reports on every run
 * Requires a lot of space

* Cleanup job is provided by the Foreman
 * Execute via cron
 * Can run with different parameters

~~~SECTION:handouts~~~

****

The configuration management solution sends reports to Foreman which are then stored in the database afterwards.
Depending on the solution, configuration and interval the required storage space can differ.

~~~PAGEBREAK~~~

Foreman provides a cleanup job for this. Best Practice would be an execution as a cronjob. The command takes parameters
for the maximum age to keep the status of the reports.

Depending on your needs configure a daily cronjob like this to delete all reports 'without event', 'after one day' or
those with events 'after 7 days'.

    #!/bin/sh
    foreman-rake reports:expire days=1 status=0
    foreman-rake reports:expire days=7

~~~ENDSECTION~~~


!SLIDE smbullets small
# Backup

* _In a regular interval, at least before an upgrade!_

* Foreman 
 * Configuration - Archive the configuration directory
 * Database - Backupjob provided by Foreman
* Puppet 
 * CA - Archive the certificates 
 * Puppet Code - Archive the modules
* Smart proxies 
 * Smart proxies itself - Archive the Smart proxy configuration 
 * Managed Service - Follow instructions for the service

~~~SECTION:handouts~~~

****

Backup should be done in a regular interval, but at least performed before any upgrade, and it should cover all components.

Foreman backup can be done by archiving the configuration directory "/etc/foreman" and for the database a dump can
be generated with the following command "foreman-rake db:dump" provided by the Foreman.

The Puppet backup should include the certificates which are located in "/var/lib/puppet/ssl" on the Puppet CA server and the
Puppet Code underneath "/etc/puppet/environments". Other configuration management solutions will be handled in a similar
way.

To backup the Smart proxy, archive the folder "/etc/foreman-proxy" and do not forget about the managed service. 
For this follow the instructions for the service. With the "Orchestration rebuilder" feature, the Foreman can also rebuild all configuration issued via the Smart proxy from the "All Hosts" menu as an action.

~~~ENDSECTION~~~


!SLIDE smbullets small
# Restore

* _Always stop the service before doing any restore!_

* Foreman 
 * Configuration - Restore the configuration directory
 * Database - Restorejob provided by Foreman
* Puppet 
 * CA - Restore the certificates 
 * Puppet Code - Restore the modules
* Smart proxies 
 * Smart proxies itself - Restore the Smart proxy configuration 
 * Managed Service - Follow instructions for the service

~~~SECTION:handouts~~~

****

Before starting a restore always stop the service!

~~~PAGEBREAK~~~

Restore the configuration directory of the Foreman carefully and inspect it before overwritting the current one. The database
dump can be restored with the command "foreman-rake db:import_dump file=/usr/share/foreman/db/foreman.TIMESTAMP.sql". Drop
an existing database in advance to have a clean restore.

For Puppet restore simply copy back the files, the same goes for the Smart proxy. The managed services should be restored according to
their instructions.

~~~ENDSECTION~~~


!SLIDE smbullets small
# Upgrade

* _Always follow the instructions in the Foreman manual!_

* In General:
 * _Backup_
 * Change package repository to the new release
 * Update the packages
 * Run Database migration and seed script
 * Clear the cache and sessions
 * Optionally run the foreman-installer to verify
 * Restart the service

~~~SECTION:handouts~~~

****

Always follow the instructions in the Foreman manual providing release and operating system specific steps to do.

~~~PAGEBREAK~~~

In general you should start by creating an up to date backup of the old configuration. Afterwards you have to change the package repository to the newest release because Foreman is always providing a separate repository for any major release. Then cleanup the package metadata and update the packages. It should run the database migration and seed script during the package update but if running them manually will show you any error then clear the cache and existing sessions. As a last step
before restarting the service you can optionally run the foreman-installer in simulation mode to verify the installation
and see pending config changes, if some are shown run the foreman-installer again to apply them finally.

~~~ENDSECTION~~~


!SLIDE smbullets small
# Foreman Maintain

* A tool developed to automate the previous tasks
* Handles multiple strategies for
 * Backup
 * Restore
* Handles Updates including Health checks
* Maintenance mode prevents access to Foreman

~~~SECTION:handouts~~~

****

Foreman Maintain is a newly developed tool which tries to automate the previous tasks. It can handle multiple strategies for backup and restore,
like offline and online, full and incremental. It ensures system health during Update and its maintenance mode prevents access to Foreman.

For more information: https://theforeman.org/plugins/foreman_maintain/0.2/index.html

~~~ENDSECTION~~~
