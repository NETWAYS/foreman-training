!SLIDE smbullets small
# Hooks

* Adds hooks to events in Foreman
 * Run additional scripts on events
 * Show status of the scripts during orchestration
 * Handles failure and rollback

* _Use case:_ 
 * Extend the Foreman without writing a plugin
 * Work around the limitations and problems of existing tools

~~~SECTION:handouts~~~

****

The Foreman Plugin Hooks allows to add scripts on events handled by the Foreman. Typically it is used
to integrate other tools during the orchestration process of deploying new hosts instead of writing
a new plugin. For this the status of a script executed is also shown in the WebGUI and handling for
failures and rollback is also provided.

~~~PAGEBREAK~~~

Another use case is to work around the limitations and problems of tools like changing parameters of
VMs which is only available after the creation but are required before starting them.

More details on: https://github.com/theforeman/foreman_hooks

~~~ENDSECTION~~~
