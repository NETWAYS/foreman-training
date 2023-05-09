!SLIDE smbullets small
# SSH Key Management

* SSH Keys provided by Users
* Available as parameter on hosts owned
* Used in snippet "create_users" during provisioning
* Example code for Puppet

<div style="text-align:right">
<img src="./_images/foreman_usersshkey.png" style="float: center; max-width: 95%; border-style: solid; border-width: 1px;" alt="Foreman User SSH Keys"/>
</div>

~~~SECTION:handouts~~~

****

Foreman provides a feature allowing users to manage their own SSH keys which is made available as parameter on
hosts owned by the user or its groups. An example for usage during provisioning is provided in the snippet "create_users".
Some example code for using this with Puppet exists in the git repositoy at https://github.com/theforeman/puppet-foreman_simple_user.

~~~ENDSECTION~~~
