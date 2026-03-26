!SLIDE smbullets small
# Leapp

* Leapp is RHEL's tool for in-place upgrades
 * ELevate is a fork by AlmaLinux supporting the community versions
 * Oracle provides its own version

* Plugin provides Jobs (requiring Ansible)
 * Preupgrade check with Leapp
 * Run remediation plan via Leapp
 * Upgrade with Leapp

* Extends Job detail view with Leapp preupgrade report

* _Use case:_ Makes in-place updates much easier

~~~SECTION:handouts~~~
****

Leapp is the tool provided by Red Hat to upgrade Red Hat Enterprise Linux in-place. While you can argue for or against in-place updates it has its use cases and Leapp tries to make it as safe as possible.
As Leapp is only for RHEL, AlmaLinux created a fork with adjustments and upgrade data to make it run on all the community versions, so it supports AlmaLinux, CentOS Stream and Rocky Linux, and also allows migration from CentOS and Scientific Linux.
Oracle provides its own version for Oracle Linux.

The Leapp plugin for Foreman provides jobs to run the preupgrade check, remediate common inhibitors blocking the upgrade and run the upgrade itself. The upgrade job requires Ansible as it also verifies a successful reboot afterwards.

~~~PAGEBREAK~~~

After a preupgrade check reported by the job itself and after running some remediation the extended job detail view provides a nice overview of upgrade information including the risk factor, possible remediation and blocking inhibitors.

This makes in-place updates much easier, even if some additional steps may be required like making the Leapp binary and data available in advance, manual remediation of some inhibitors, and post upgrade tasks.

~~~ENDSECTION~~~
