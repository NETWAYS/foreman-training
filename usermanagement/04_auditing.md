!SLIDE smbullets small
# Auditing

* Almost all changes from WebGUI and API
* User, timestamp, change and parent object
* For templates additional diff of the changes
* Browse and searchable in the WebGUI

<div style="text-align:center">
<img src="./_images/foreman_auditing.png" style="float: center; width: 95%; border-style: solid; border-width: 1px;" alt="Foreman Auditing"/>
</div>

~~~SECTION:handouts~~~

****

Foreman logs almost all changes from the WebGUI and API including the user, a timestamp, the change and
the parent object like the host or a parameter got changed. For templates an additional diff of the changes
is provided.

~~~PAGEBREAK~~~

All this auditing data are browse and searchable in the WebGUI via "Monitor > Audits". To get detailed
auditing data or specific change history simply select an entry.

The events can be deleted or anonymized via cron as needed. This will be covered in a later section of the
training material.

~~~ENDSECTION~~~
