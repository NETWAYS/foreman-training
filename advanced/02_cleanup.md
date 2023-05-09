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
 * Executed via cron
 * Can run with different parameters

~~~SECTION:handouts~~~

****

The configuration management solution sends reports to Foreman which are then stored in the database afterwards.
Depending on the solution, configuration and interval the required storage space can differ.

~~~PAGEBREAK~~~

Foreman provides a cleanup job for this in form of a cronjob. Best Practice would be to adjust is based on your needs. The command takes parameters
for the maximum age to keep the status of the reports.

For example configure the daily cronjob like this to delete all reports 'without event' 'after one day' and
those with events 'after 7 days'.

    # vi /etc/cron.d/foreman
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
* Katello
 * Candlepin - Database backup
 * Pulp - Database backup + Content archive

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

Katello adds to additional components requiring backup. Candlepin uses its own database which needs to be backuped. The same with Pulp which also requires you to archive the content if not everything could be downloaded again.
The recommended way to run a backup for Katello is using foreman-maintain, we will discuss at the end of the section.

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
* Katello
 * Candlepin - Database needs to be restored
 * Pulp - Database + Content needs to be restored

~~~SECTION:handouts~~~

****

Before starting a restore always stop the service!

Restore the configuration directory of the Foreman carefully and inspect it before overwritting the current one. The database
dump can be restored with the command "foreman-rake db:import_dump file=/usr/share/foreman/db/foreman.TIMESTAMP.sql". Drop
an existing database in advance to have a clean restore.

For Puppet restore simply copy back the files, the same goes for the Smart proxy. The managed services should be restored according to
their instructions.

Katello's additional services also need to be restored using foreman-maintain.

~~~ENDSECTION~~~


!SLIDE smbullets small
# Upgrade

* _Always follow the instructions in the Foreman documentation!_

* In General:
 * _Backup_
 * Change package repository to the new release
 * Update the packages
 * *Run the foreman-installer to:*
 * Run Database migration and seed script
 * Clear the cache and sessions
 * Restart the service

* Operating System upgrade:
 * Use Leapp for switching EL7 to EL8

* Katello:
 * No separate update of Foreman, always wait for Katello release

~~~SECTION:handouts~~~

****

Always follow the instructions in the Foreman documentation providing release and operating system specific steps to do.

In general you should start by creating an up to date backup of the old configuration. Afterwards you have to change the package repository to the newest release because Foreman is always providing a separate repository for any major release. Then cleanup the package metadata and update the packages. 
Run the foreman-installer to execute the database migration and seed script, clear the cache and existing sessions, and restarts the services.

Foreman provided also support for using Leapp for switching from EL7 to EL8 to help with changing from SCL to Modules. In other cases nothing special is required for an operating system upgrade.

Updating Katello requires to have both parts releases to be announced, so after a Foreman release was announced waiting normally 2 to 3 weeks for the corresponding Katello release is required.

~~~ENDSECTION~~~


!SLIDE smbullets small
# Foreman Maintain

* A tool developed to automate the previous tasks
* Handles multiple strategies for
 * Backup
 * Restore
* Handles Updates including Health checks
* Maintenance mode prevents access to Foreman
* Yum plugin prevents unexpected package sources

~~~SECTION:handouts~~~

****

Foreman Maintain is a newly developed tool which tries to automate the previous tasks. It can handle multiple strategies for backup and restore,
like offline and online, full and incremental. It ensures system health during Update and its maintenance mode prevents access to Foreman.

The yum plugin "foreman-protector" is created to prevent accidental updates of packages from unexpected sources.

For more information: https://theforeman.org/plugins/foreman_maintain/0.2/index.html

~~~ENDSECTION~~~
