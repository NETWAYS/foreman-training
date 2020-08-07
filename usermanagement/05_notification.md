!SLIDE smbullets small
# Internal Notifications

* Notification for own actions
* New feature since 1.15
* Used by Foreman and many plugins
* Also integrates the Foreman RSS feed

<div style="text-align:right">
<img src="./_images/foreman_notification.png" style="float: right, max-width:200px; max-height: 250px; width: auto; height: auto; margin-top: 95px; margin-right: 95px" alt="Foreman Notification"/>
</div>

~~~SECTION:handouts~~~

****

~~~PAGEBREAK~~~

Foreman provides a new notification feature to notify about your own actions since 1.15 which is already used by Foreman and
many plugins. This allows to keep track of actions run independently.

Furthermore it integrates the Foreman RSS feed to keep the user updated, but also to provide some numbers to the Foreman Project.
You can simply opt-out via the setting "RSS enable" on the "Administer > Settings > Notification" tab.

~~~ENDSECTION~~~

!SLIDE smbullets small
# Email Notifications

* General configuration via Foreman Installer or configuration file 
* Optional setting by user
* Frequent summary of specific audit events
* Finished host provisioning
* Puppet run with error on every run or as frequent summary

<div style="text-align:right">
<img src="./_images/foreman_email.png" style="float: center, max-width:1000px; max-height: 250px; width: 400px; height: 200px; margin-top: 50px" alt="Foreman Email"/>
</div>

~~~SECTION:handouts~~~

****

Foreman can send email notifications to the user. This requires email settings configured in Foreman via the Foreman Installer
or manual editing of the configuration file "/etc/foreman/email.yaml". With this configuration in place a user can decide to
opt-in for several kinds of notification. It can send a daily, weekly or monthly summary of audit events which allows to add a
search to specify a subset of events. It also can notify on every successful host build and for Puppet runs on every failed run
or as a frequent summary.

More options are provided by plugins like Katello.

~~~ENDSECTION~~~
