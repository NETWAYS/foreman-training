!SLIDE center noprint
# Demo

<div class="div_center">Katello Demo</div>

!SLIDE printonly
# Demo

## Katello Demo

~~~SECTION:handouts~~~

****

Setting up Katello is only a bit more challenging then Foreman, but the team provides an
easy way to create a demo setup.

Requirements:

* git
* vagrant (libvirt or virtualbox provider)
* docker and docker-compose

<br/><br/>The repository https://github.com/Katello/katello-deploy/ includes everything else you need.
Simply clone it with git, use vagrant to provide a Katello server and docker-compose to create
Content Hosts.

~~~ENDSECTION~~~
