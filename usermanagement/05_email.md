!SLIDE smbullets small
# Email Notifications

* General configuration via Foreman Installer or configuration file 
* Optional setting by user
* Frequent summary of specific audit events
* Finished host provisioning
* Puppet run with error on every run or as frequent summary

<div style="text-align:right">
<img src="./_images/foreman_email.png" style="float: right, max-width:200px; max-height: 250px; width: auto; height: auto; margin-top: 50px; margin-right: 50px" alt="Foreman Email"/>
</div>

~~~SECTION:handouts~~~

****

Foreman can send email notifications to the user. This requires email settings configured in Foreman via the Foreman Installer
or manual editing of the configuration file "/etc/foreman/email.yaml". With this configuration in place a user can decide to
opt-in for several kinds of notification. It can send a daily, weekly or monthly summary of audit events which allows to add a
search to specify a subset of events. It also can notify on every successful host build and for Puppet runs on every failed run
or as a frequent summary.

~~~ENDSECTION~~~
